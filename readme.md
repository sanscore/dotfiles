# dotfiles
## Bash
 * Commit and Append History after each command

## Inputrc
  * Visible Bell
  * VI key bindings
  * Incremental Search using up/down arrows
  * Igonre case on tab completion
  * Magic Space in bash

## Tmux
  * Switch to C-a prefix
  * VI Keys
  * Status line: Windows on left; hostname, session name, and date/time on right.
  * C-a C-a, last window
  * C-a C-c, create window
  * C-a -, vertical split
  * C-a '"', chose window
  * C-a C-r, respawn window
  * C-a C-x, kill window
  * C-a r, source tmux.conf

## VIM
  * Leader shortcuts
    * Leader: ','
    * Buffers: ',b*'; n(next), p(prev), N(new), l(list)
    * Tabs: ',t*'; n(next), p(prev), N(new), l(list)
    * Windows: ',w*'; w(next), p(prev)
    * Clear search: ',/'
    * Line numbers: ',n'
    * Relative numbers: ',r'
    * List characters: ',l'
    * Paste mode: ',.'
    * Syntax Highlighting: ',s'
    * VIMRC
      * Edit: ',ve'
      * Source: ',vs'
  * plugins
    * Airline: ',a'
    * Buffer Explorer: ',be'
    * CtrlP: ',p'
    * Fugitive
    * Gitgutter
    * Molokai
    * Nerdtree: ',N'
    * Sensible
    * Snipmate
      * Vim-Snippets
    * Surround
    * Syntastic
    * TagBar: ',T'
    * UndoTree: ',u'
  * Abbreviations
    * 'Y-': Horizontal ruler
    * 'Yr': Labelled ruler
    * 'Yds': Date stamp
    * 'Ydts': Date\time stamp
    * 'Ydl': Date stamp, long form
    * 'Ydtl': Date\Timp stamp, long form

# Rake Tasks

## links
Install symbolic links for all the dotfiles.

```
rake links[dir,force]
```

##### Defaults
```
dir=$HOME
force=false
```

## vim
Create a .vim/ directory and download pathogen to .vim/autoload/.

```
rake vim[dir,force]
```

##### Defaults
```
dir=$HOME
force=false
```

## vim_plugins
Install the vim plugins to .vim/bundle/.

```
rake vim_plugins[dir]
```

##### Defaults
```
dir=$HOME/.vim/bundle/
```

# Clone
```
git clone https://github.com/sanscore/dotfiles.git
```

# Todo

# bashrc
 * add aliases
 * add functions
