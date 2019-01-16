#GVIMPATH=$PATH:"/c/Program Files (x86)/Vim/vim80":"/c/Program Files (x86)/CodeBlocks/MinGW/bin/"
GVIMPATH="/d/MinGW/bin/":$PATH:"/c/Program Files (x86)/Vim/vim80"
export PATH=$GVIMPATH
alias cls='clear'
alias cdw='wcd'
alias v='vim '
alias grp='grep --color'
alias grepich='find . -iname \*.[ch] 2>/dev/null| xargs grep --color -in 2>/dev/null'
alias grepch='find . -iname \*.[ch] 2>/dev/null| xargs grep --color -n 2>/dev/null'
alias grepih='find . -iname \*.[h] 2>/dev/null| xargs grep --color -in 2>/dev/null'
alias greph='find . -iname \*.[h] 2>/dev/null| xargs grep --color -n 2>/dev/null'
alias grepic='find . -iname \*.[c] 2>/dev/null| xargs grep --color -in 2>/dev/null'
alias grepc='find . -iname \*.[c] 2>/dev/null| xargs grep --color -n 2>/dev/null'
alias grih='grepih'
alias grh='greph'
alias gric='grepic'
alias grc='grepc'
alias grich='grepich'
alias grch='grepch'

alias ff='find . -iname '
alias cdf='cd /d/LS020/7C0/LS020Cvs/LS020FW/LS020ProductFW'
alias cdq='cd /d/LS020/7C0/LS020Cvs/LS020FWQA'

alias cdlf='cd /d/checkout/LS020/LS020Cvs/LS020FW/LS020ProductFW'
alias cdlq='cd /d/checkout/LS020/LS020Cvs/LS020FWQA'
alias cdvf='cd /d/checkout/VM020/VM020Cvs/VM020FW/VM020ProductFW'
alias cdvq='cd /d/checkout/VM020/VM020Cvs/VM020FWQA'

alias ssh38='ssh bj-qa@10.0.6.171'
alias ssh39='ssh bj-qa@10.0.6.164'
alias s8=ssh38
alias s38=ssh38
alias s9=ssh39
alias s39=ssh39
alias bk1='bk 1'
alias bk2='bk 2'
alias bk3='bk 3'
alias bk4='bk 4'
alias bk5='bk 5'
alias bk6='bk 6'
alias bk7='bk 7'
alias bk8='bk 8'
alias b9='bk 9'
alias b1='bk 1'
alias b2='bk 2'
alias b3='bk 3'
alias b4='bk 4'
alias b5='bk 5'
alias b6='bk 6'
alias b7='bk 7'
alias b8='bk 8'
alias b9='bk 9'

alias gp='git push origin master; git push s9 master'
alias gitinit='git init; git add .gitignore; git add *; git commit -m"init add files"'
alias diffc='diff -E -Z -b -w -B '

#ipconfig: IPv4 Address. . . . . . . . . . . : 10.0.1.154
ipv4=$(ipconfig | grep   "IPv4 Address"| cut -f 2 -d ":"|sed 's/ //g')



rm0a() {
	test -z "$1" -o ! -e "$1" && return
	sed -i -e 's/\r//g' $1
}

gpush() {
    origin=origin
    master=master
    git push $origin $master
}

gpull() {
    origin=origin
    master=master
    git pull $origin $master
}

#scp's path for file
scpp() {
        echo "bj-qa@$ipv4:$(readlink -f $1)"
}

cvsupdate() {
    #cvs update -P -d -C -r Branch_ZeroMS >shit
    cvs update -P -d $@ >shit 2>&1
    cat shit | grep -e "^P " -e "^M "
}
#show last 30 days cvs history, recent info goes top
cvslogf() {
	test -z "$1" && return
	test ! -e "$1" && return
	CMD="cvs history  -ca  $1 | sed 's/\(^.\) \(.*\)/\2 \1/' | sort -r"
	echo $CMD
	echo $CMD >log.txt
	$CMD >>log.txt
	#sed -i 's/\(^.\) \(.*\)/\2 \1/'  log.txt
	cat log.txt | sed 's/\(^.\) \(.*\)/\2 \1/' | sort -r
}
cvslog() {
	days=30
	test -n "$1" && days=$1
	DFLAG=" --date=@$(($(date +%s)-86400*days)) "
	CMD="cvs history  -ca  -D $(date $DFLAG +%Y-%m-%d) $(cat CVS/Repository) | sed 's/\(^.\) \(.*\)/\2 \1/' | sort -r"
	echo $CMD
	echo $CMD >log.txt
	#cvs history  -ca  -D $(date $DFLAG +%Y-%m-%d) $(cat CVS/Repository) | sort -r >log.txt
	$CMD >>log.txt
	cat log.txt
}

#cd's parameter are MS-Windows style, protected by "", otherwise, \ is removed by shell.
#space supported in path name, so use "" protect it.
wcd() {
	TPATH="$(echo "$1" | sed -e 's|\\|/|g')"
	cd "$TPATH"
}

#cd back a certain level. bk 3 means call 3 time of "cd .."
bk() {
	test -z "$1" && return
	nr=$1
	pushd .
	while [ $nr -gt 0 ] ; do
	    cd ..
	    nr=$((nr-1))
	done
}
#ssh to a pre-defined user on a pre-defined server
s() {
	case "$1" in
	38|8) ssh38;;
	39|9) ssh39;;
	*);;
	esac
}

ed() {
	test -n "$1" && notepad++.exe $1 &
}

