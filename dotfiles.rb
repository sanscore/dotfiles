#!/usr/bin/env ruby

require 'fileutils'
require 'thor'

module SansCore; module DotFiles
  class CLI < Thor
    class_option(:dir,
                 aliases: 'd',
                 desc: 'Directory to install DotFiles',
                 default: ENV['HOME'])
    class_option(:force,
                 aliases: 'f',
                 desc: 'Force installation',
                 default: false,
                 type: :boolean)

    desc "install", "Install all DotFiles"
    def install
      invoke :bash
      invoke :gitconfig
      invoke :inputrc
      invoke :irbrc
      invoke :tmux
      invoke :vim
    end

    desc "bash", "Symlink bashrc and bash_profile"
    def bash
      bash_profile
      bashrc
      bashrc_docker
      bashrc_github
    end

    desc "bash_profile", "Symlink bashrc and bash_profile"
    def bash_profile
      create_ln('bash_profile', '.bash_profile', options[:dir], options[:force])
    end

    desc "bashrc", "Symlink bashrc"
    def bashrc
      create_ln('bashrc', '.bashrc', options[:dir], options[:force])
    end

    desc "bashrc_docker", "Symlink bashrc.docker"
    def bashrc_docker
      create_ln('bashrc.docker', '.bashrc.docker', options[:dir], options[:force])
    end

    desc "bashrc_github", "Symlink bashrc.github"
    def bashrc_github
      create_ln('bashrc.github', '.bashrc.github', options[:dir], options[:force])
    end

    desc "gitconfig", "Symlink gitconfig"
    def gitconfig
      create_ln('gitconfig', '.gitconfig', options[:dir], options[:force])
    end

    desc "inputrc", "Symlink inputrc"
    def inputrc
      create_ln('inputrc', '.inputrc', options[:dir], options[:force])
    end

    desc "irbrc", "Symlink irbrc"
    def irbrc
      create_ln('irbrc', '.irbrc', options[:dir], options[:force])
    end

    desc "tmux", "Symlink tmux.conf"
    def tmux
      create_ln('tmux.conf', '.tmux.conf', options[:dir], options[:force])
      create_ln('tmux.conf.macosx', '.tmux.conf.macosx', options[:dir], options[:force])
      create_ln('tmux.conf.linux', '.tmux.conf.linux', options[:dir], options[:force])
    end

    desc "vim", "Symlink vimrc and create bare vim/ directory"
    def vim
      vim_dir = File.join(options[:dir], '.vim')

      create_ln('vim', '.vim', options[:dir], options[:force])
      create_ln('vimrc', '.vimrc', options[:dir], options[:force])
      create_ln('mthesaur.txt', 'mthesaur.txt', vim_dir, options[:force])
      # TODO: vim packages??
    end

    no_commands do
      def create_ln(source_filename, target_filename, dir, force)
        source_filename = File.join(Dir.pwd, source_filename)
        target_filename = File.join(File.expand_path(dir), target_filename)

        unless(File.exists?(source_filename))
          print "Skipping: '#{source_filename}' doesn't exist.\n"
          return
        end

        begin
          link = File.readlink(target_filename)
        rescue Errno::EINVAL, Errno::ENOENT
          link = target_filename
        end

        if(!File.exists?(target_filename) || force)
          puts "Linking '#{source_filename}' to '#{target_filename}'"
          ln_s source_filename, target_filename, force: force
        elsif(link == source_filename)
          print "Skipping: #{target_filename} is already installed\n"
        else
          print ("Skipping: #{target_filename} already exists.\n"\
            "\tUse '-f' to overwrite the current file.\n")
        end
      end

      def ln_s(source_filename, target_filename, force: false)
        FileUtils.ln_s source_filename, target_filename, force: force
      end

      def mkdir_p(dir)
        if File.exists?(dir)
          print "Skipping: #{dir} already exists.\n"
        else
          puts "Creating '#{dir}'"
          FileUtils.mkdir_p dir
        end
      end
    end

  end
end; end

SansCore::DotFiles::CLI.start(ARGV)
