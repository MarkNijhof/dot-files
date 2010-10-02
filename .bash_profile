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
source ~/.git-completion.bash

export PATH=$PATH:~/bin:/usr/local/sbin:/usr/local/Cellar/node/head/bin:/usr/local/Cellar/macvim/head/bin:/usr/local/Cellar/tomcat/6.0.26/bin

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

export PS1='\[$(tput setaf 2)\]\u\[$(tput sgr0)\]@\[$(tput setaf 3)\]\h\[$(tput sgr0)\] \w\[$(tput setaf 5)\]`if [ "$(vcprompt)" != "" ]; then echo " $(vcprompt)"; fi`\[$(tput setaf 2)\]`if [ "$(~/.rvm/bin/rvm-prompt i v)" != "" ]; then echo " $(~/.rvm/bin/rvm-prompt i v)"; fi` \[$(tput sgr0)\]∴ '
export PS1='\W\[$(tput setaf 5)\]`if [ "$(vcprompt)" != "" ]; then echo " $(vcprompt)"; fi`\[$(tput setaf 2)\]`if [ "$(~/.rvm/bin/rvm-prompt i v)" != "" ]; then echo " $(~/.rvm/bin/rvm-prompt i v)"; fi` \[$(tput sgr0)\]∴ '

alias v='mvim .'
alias m='mate .'
alias o='open .'
alias r='rake'
alias la='ls -al'
alias profile='vim ~/.bash_profile'
alias host='sudo vim /private/etc/hosts'

if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
