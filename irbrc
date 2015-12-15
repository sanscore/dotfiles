IRB.conf[:AUTO_INDENT] = true
IRB.conf[:USE_READLINE] = true

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "~/.irb_history"
IRB.conf[:EVAL_HISTORY] = 200

require 'irb/completion'
require 'pp'

# gem install map_by_method
require 'map_by_method'

# gem install what_methods
require 'what_methods'
