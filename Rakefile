DEFAULT_ARGS = {dir: ENV['HOME'], force: nil}

desc "Create symlinks."
multitask :links, [:dir, :force] => [:vimrc, :tmux, :bashrc]

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
  
