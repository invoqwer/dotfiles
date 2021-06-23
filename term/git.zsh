# Git Alias
alias g='git '
alias st='status'
alias co='checkout'
alias com='commit'
alias br='branch'
alias chp='cherry-pick'
alias sub='submodule'

alias gg='git grep -n '
alias ggi='git grep -in '
alias ggw='git grep -wn '
alias ggiw='git grep -iwn '

# Git ls-files
function glsf() {
    if [[ ! "$#" -eq 1 ]]; then
        echo 'Usage: glsf filename'
        return 1
    fi
    git ls-files | grep -in "$1"
}

# optional argument: author
function gglog() {
    PF='--pretty=format:"%h%x09%an%x09%ad%x09%s"'
    case "$#" in
        0) git log "$PF";;
        1) git log --author="$1" "$PF";;
        *) echo 'Usage: gglog [author]';;
    esac
}