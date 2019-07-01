export PATH=$PATH:~/bin
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias vi='vim'
alias ls='ls --color'
alias ll='ls -l'
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
PS1="\[\e[37;40m\][\[\e[32;40m\]\u\[\e[37;40m\]@\h\[\e[35;40m\]\W\[\e[0m\]\$] "
