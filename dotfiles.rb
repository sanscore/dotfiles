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
      invoke :ssh
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
      ln_s('bash_profile', '.bash_profile', options[:dir], options[:force])
    end

    desc "bashrc", "Symlink bashrc"
    def bashrc
      ln_s('bashrc', '.bashrc', options[:dir], options[:force])
    end

    desc "bashrc_docker", "Symlink bashrc.docker"
    def bashrc_docker
      ln_s('bashrc.docker', '.bashrc.docker', options[:dir], options[:force])
    end

    desc "bashrc_github", "Symlink bashrc.github"
    def bashrc_github
      ln_s('bashrc.github', '.bashrc.github', options[:dir], options[:force])
    end

    desc "gitconfig", "Symlink gitconfig"
    def gitconfig
      ln_s('gitconfig', '.gitconfig', options[:dir], options[:force])
    end

    desc "inputrc", "Symlink inputrc"
    def inputrc
      ln_s('inputrc', '.inputrc', options[:dir], options[:force])
    end

    desc "irbrc", "Symlink irbrc"
    def irbrc
      ln_s('irbrc', '.irbrc', options[:dir], options[:force])
    end

    desc "ssh", "Symlink ssh_config"
    def ssh
      ssh_dir = File.join(options[:dir], '.ssh')

      mkdir_p(ssh_dir, mode: 0700)
      cp('ssh_config', 'config', ssh_dir, options[:force])
      cp('ssh_config.examples', 'config.examples', ssh_dir, options[:force])
      cp('ssh_config.temp', 'config.private', ssh_dir, options[:force])
      cp('ssh_config.temp', 'config.work', ssh_dir, options[:force])
    end

    desc "tmux", "Symlink tmux.conf"
    def tmux
      ln_s('tmux.conf', '.tmux.conf', options[:dir], options[:force])
      ln_s('tmux.conf.macosx', '.tmux.conf.macosx', options[:dir], options[:force])
      ln_s('tmux.conf.linux', '.tmux.conf.linux', options[:dir], options[:force])
    end

    desc "vim", "Symlink vimrc and create bare vim/ directory"
    def vim
      vim_dir = File.join(options[:dir], '.vim')

      ln_s('vim', '.vim', options[:dir], options[:force])
      ln_s('vimrc', '.vimrc', options[:dir], options[:force])
      ln_s('mthesaur.txt', 'mthesaur.txt', vim_dir, options[:force])
      # TODO: vim packages??
    end

    no_commands do
      def cp(source_filename, target_filename, dir, force)
        source_filename = File.join(Dir.pwd, source_filename)
        target_filename = File.join(File.expand_path(dir), target_filename)

        unless(File.exists?(source_filename))
          print "Skipping: '#{source_filename}' doesn't exist.\n"
          return
        end

        if force && File.exists?(target_filename)
          FileUtils.rm target_filename
        end

        if(!File.exists?(target_filename))
          puts "Copying '#{source_filename}' to '#{target_filename}'"
          FileUtils.cp source_filename, target_filename
        else
          print ("Skipping: #{target_filename} already exists.\n"\
            "\tUse '-f' to overwrite the current file.\n")
        end
      end

      def ln_s(source_filename, target_filename, dir, force)
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
          FileUtils.ln_s source_filename, target_filename, force: force
        elsif(link == source_filename)
          print "Skipping: #{target_filename} is already installed\n"
        else
          print ("Skipping: #{target_filename} already exists.\n"\
            "\tUse '-f' to overwrite the current file.\n")
        end
      end

      def mkdir_p(dir, mode: nil)
        if File.exists?(dir)
          print "Skipping: #{dir} already exists.\n"
        else
          puts "Creating '#{dir}'"
          FileUtils.mkdir_p dir, mode: mode
        end
      end
    end
  end
end; end

SansCore::DotFiles::CLI.start(ARGV)
