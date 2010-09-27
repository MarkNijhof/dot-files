function positive_int() { return $(test "$@" -eq "$@" > /dev/null 2>&1 && test "$@" -ge 0 > /dev/null 2>&1); }

function sizetw() {
   if [[ $# -eq 2 ]] && $(positive_int "$1") && $(positive_int "$2"); then
      printf "\e[8;${1};${2};t"
      return 0
   fi
   return 1
}

sizetw 20 150

export EDITOR=mate
source ~/.git-completion.sh
export PATH="$HOME/bin:$HOME/sbin:$PATH"
alias r='rake'

alias profile='vim ~/.bash_profile'
alias host='sudo vim /private/etc/hosts'

export PS1='\w\[$(tput setaf 5)\]`if [ "$(vcprompt)" != "" ]; then echo " $(vcprompt)"; fi`\[$(tput setaf 2)\]`if [ "$(~/.rvm/bin/rvm-prompt i v)" != "" ]; then echo " $(~/.rvm/bin/rvm-prompt i v)"; fi` \[$(tput sgr0)\]∴ '

if [[ -s /Users/marknijhof/.rvm/scripts/rvm ]] ; then source /Users/marknijhof/.rvm/scripts/rvm ; fi
