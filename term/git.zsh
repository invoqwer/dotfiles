# Git Alias
alias g='git '
alias st='status'
alias co='checkout'
alias com='commit'
alias br='branch'
alias gg='git grep -i -n '
alias chp='cherry-pick'
alias sub='submodule'
alias glog='git log --pretty=format:"%h%x09%an%x09%ad%x09%s" '

# Git flags
alias nmo='--name-only'
alias sut='--set-upstream-to'

# Git ls-files
glsf () {
    if [[ ! "$#" -eq 1 ]]; then
        echo 'provide filename'
        return 1
    fi
    git ls-files "**/${1}.*"
}
