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
      invoke :vundle
    end

    desc "bash", "Symlink bashrc and bash_profile"
    def bash
      create_ln('bashrc', '.bashrc', options[:dir], options[:force])
      create_ln('bash_profile', '.bash_profile', options[:dir], options[:force])
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
    end

    desc "vim", "Symlink vimrc and create bare vim/ directory"
    def vim
      vim_dir = File.join(options[:dir], '.vim')
      vim_bundle_dir = File.join(vim_dir, 'bundle')

      mkdir_p vim_bundle_dir
      create_ln('vimrc', '.vimrc', options[:dir], options[:force])
      create_ln('mthesaur.txt', 'mthesaur.txt', vim_dir, options[:force])
    end

    desc "vundle", "Git Clone vundle to '.vim/bundle/'"
    def vundle
      repo = 'https://github.com/gmarik/Vundle.vim.git'
      dir = "#{options[:dir]}/.vim/bundle/Vundle.vim"
      git_clone(repo,dir)
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

      def git_clone(repo,dir)
        if File.exists?(dir)
          print "Skipping: #{dir} already exists.\n"
        else
          puts "Creating '#{dir}'"
          `git clone #{repo} #{dir}`
        end
      end
    end

  end
end; end

SansCore::DotFiles::CLI.start(ARGV)
