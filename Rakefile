require 'rake'
require 'uri'
require 'net/https'

DEFAULT_ARGS = {dir: ENV['HOME'], force: nil}

VIM_AUTOLOAD_DIR = File.join(ENV['HOME'], '.vim', 'autoload')
VIM_BUNDLE_DIR = File.join(ENV['HOME'], '.vim', 'bundle')

desc "Create symlinks."
multitask :links, [:dir, :force] => [:vimrc, :tmux, :bashrc, :inputrc]

desc 'Create a bare bones vim directory with only pathogen'
task :vim, [:dir] do |t, args|
  args.with_defaults(DEFAULT_ARGS)

  mkdir_p VIM_AUTOLOAD_DIR
  mkdir_p VIM_BUNDLE_DIR

  pathogen_url =
    "https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim"
  pathogen_file = File.join(VIM_AUTOLOAD_DIR, 'pathogen.vim')

  fetch_file(pathogen_url, pathogen_file)
end

desc 'Install preferred vim plugins.'
task :vim_plugins, [:dir] => [:vim] do |t, args|
  args.with_defaults(dir: VIM_BUNDLE_DIR)
  git_clone_or_pull('jlanzarotta', 'bufexplorer', args.dir)
  git_clone_or_pull('kien', 'ctrlp.vim', args.dir)
  git_clone_or_pull('scrooloose', 'nerdtree', args.dir)
  git_clone_or_pull('scrooloose', 'syntastic', args.dir)
  git_clone_or_pull('garbas', 'vim-snipmate', args.dir)
  git_clone_or_pull('majutsushi', 'tagbar', args.dir)
  git_clone_or_pull('mbbill', 'undotree', args.dir)
  git_clone_or_pull('bling', 'vim-airline', args.dir)
  git_clone_or_pull('tpope', 'vim-fugitive', args.dir)
  git_clone_or_pull('tpope', 'vim-sensible', args.dir)
  git_clone_or_pull('tpope', 'vim-surround', args.dir)
  git_clone_or_pull('airblade', 'vim-gitgutter', args.dir)
  git_clone_or_pull('tomasr', 'molokai', args.dir)
  git_clone_or_pull('marcweber', 'vim-addon-mw-utils', args.dir)
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

def git_clone_or_pull(user, repo, dir)
  dir = File.join(File.expand_path(dir), repo)
  if(File.exists?(dir))
    git_pull(repo, dir)
  else
    git_clone(user,repo,dir)
  end
end

def git_clone(user, repo, dir)
  if system "git clone https://github.com/#{user}/#{repo}.git #{dir}"
    puts "Successfully cloned: #{repo}"
  else
    puts "Failed to clone: #{repo}"
  end
end

def git_pull(repo, dir)
  if system "cd #{dir}; git pull"
    puts "Successfully updated: #{repo}"
  else
    puts "Failed to update: #{repo}"
  end
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
    open(file,"w") { |f| f.write(resp.body) }
    puts "#{fil} saved."
  when Net::HTTPRedirection then
    fetch_file(resp['location'], file, limit-1)
  else
    resp.value
  end
end
