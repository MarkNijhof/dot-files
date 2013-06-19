function positive_int() { return $(test "$@" -eq "$@" > /dev/null 2>&1 && test "$@" -ge 0 > /dev/null 2>&1); }

function sizetw() {
   if [[ $# -eq 2 ]] && $(positive_int "$1") && $(positive_int "$2"); then
      printf "\e[8;${1};${2};t"
      return 0
   fi
   return 1
}

sizetw 20 150

export EDITOR='vim -f'
export HISTCONTROL=erasedups  #ignoreboth #erasedups
export NODE_PATH=/usr/local/bin/node

source ~/.git-completion.bash

export PATH="${HOME}/development/system/dotfiles:/usr/local/heroku/bin:/usr/local/bin:usr/local:/usr/local/sbin:/usr/bin:/usr/local/share/npm/bin:$PATH"
# export PYTHONPATH=/Library/Python/2.7/site-packages/
export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar

function directory_to_titlebar {
   local pwd_length=42 # The maximum length we want (seems to fit nicely
                        # in a default length Terminal title bar).
   # Get the current working directory. We'll format it in $dir.
   local dir="$PWD"

   # Substitute a leading path that's in $HOME for "~"
   if [[ "$HOME" == ${dir:0:${#HOME}} ]] ; then
       dir="~${dir:${#HOME}}"
   fi

   # Append a trailing slash if it's not there already.
   if [[ ${dir:${#dir}-1} != "/" ]] ; then
       dir="$dir/"
   fi

   # Truncate if we're too long.
   # We preserve the leading '/' or '~/', and substitute
   # ellipses for some directories in the middle.
   if [[ "$dir" =~ (~){0,1}/.*(.{${pwd_length}}) ]] ; then
       local tilde=${BASH_REMATCH[1]}
       local directory=${BASH_REMATCH[2]}

       # At this point, $directory is the truncated end-section of the
       # path. We will now make it only contain full directory names
       # (e.g. "ibrary/Mail" -> "/Mail").
       if [[ "$directory" =~ [^/]*(.*) ]] ; then
           directory=${BASH_REMATCH[1]}
       fi

       # Can't work out if it's possible to use the Unicode ellipsis,
       # '…' (Unicode 2026). Directly embedding it in the string does not
       # seem to work, and \u escape sequences ('\u2026') are not expanded.
       #printf -v dir "$tilde/\u2026$s", $directory"
       dir="$tilde/...$directory"
   fi

   # Don't embed $dir directly in printf's first argument, because it's
   # possible it could contain printf escape sequences.
   printf "\033]0;%s\007" "$dir"
}

if [[ "$TERM" == "xterm" || "$TERM" == "xterm-color" ]] ; then
 export PROMPT_COMMAND="directory_to_titlebar"
fi

if [[ "$HOME" == "/Users/mark nijhof" ]] ; then
  export HOME="/Users/mn"
fi

export PS1='\W\[$(tput setaf 5)\]`if [ "$(vcprompt)" != "" ]; then echo " $(vcprompt)"; fi`\[$(tput setaf 2)\]`if [ "$(~/.rvm/bin/rvm-prompt i v p g)" != "" ]; then echo " $(~/.rvm/bin/rvm-prompt i v p g)"; fi` \[$(tput sgr0)\]∴ '

alias v='vim .'
alias m='mate .'
alias o='open .'
alias e='emacs'
alias r='rake'
alias la='ls -al'
alias profile='vim ~/.bash_profile'
alias host_file='sudo vim /private/etc/hosts'
alias gph='git push heroku master'
alias gp='git push origin master'
alias gs='${HOME}/development/system/dotfiles/git-status.sh'
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi


# Setting PATH for MacPython 2.5
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH
