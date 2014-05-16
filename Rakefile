require 'rake'
require 'uri'
require 'net/https'

DEFAULT_ARGS = {dir: ENV['HOME'], force: nil}

desc "Create symlinks."
multitask :links, [:dir, :force] => [:vimrc, :tmux, :bashrc, :inputrc]

desc 'Create a bare bones vim directory with only pathogen'
task :vim do |t|
  v_auto = File.join(ENV['HOME'], '.vim', 'autoload')
  v_bundle = File.join(ENV['HOME'], '.vim', 'bundle')

  mkdir_p v_auto
  mkdir_p v_bundle

  pathogen_url =
    "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
  pathogen_file = File.join(v_auto, 'pathogen.vim')

  fetch_file(pathogen_url, pathogen_file)
end

desc 'Install preferred vim plugins.'
task :vim_bundle => :vim do
  puts 'TODO'
  puts """  bufexplorer
  ctrlp
  nerdtree
  snipmate?
  syntastic?
  tagbar
  undotree
  airline
  fugitive
  gitgutter
  sensible
  surround"""
end

task :vimrc, [:dir, :force] do |t, args|
  args.with_defaults(DEFAULT_ARGS)
  create_ln('vimrc', '.vimrc', args.dir, args.force)
end

task :tmux, [:dir, :force] do |t, args|
  args.with_defaults(DEFAULT_ARGS)
  create_ln('tmux.conf', '.tmux.conf', args.dir, args.force)
end

task :bashrc, [:dir, :force] do |t, args|
  args.with_defaults(DEFAULT_ARGS)
  create_ln('bashrc', '.bashrc', args.dir, args.force)
end

task :inputrc, [:dir, :force] do |t, args|
  args.with_defaults(DEFAULT_ARGS)
  create_ln('inputrc', '.inputrc', args.dir, args.force)
end

def create_ln(old, new, dir, force)
  old = File.join(Dir.pwd, old)
  new = File.join(File.expand_path(dir), new)
  
  unless(File.exists?(old))
    puts "#{old} doesn't exist."
    return
  end

  if(!File.exists?(new) || force)
    ln_s old, new, force: force
  else
    puts "#{new} already exists."
  end
end

def fetch_file(url, file, limit=10)
  if File.exists?(file) 
    puts "#{file} already exists"
    return
  end

  uri = URI(url)

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  req = Net::HTTP::Get.new(uri.path)
  resp = http.request(req)

  case resp
  when Net::HTTPSuccess then
    open("pathogen","w") { |f| f.write(resp.body) }
  when Net::HTTPRedirection then
    fetch(resp['location'], file, limit-1)
  else
    resp.value
  end
end
