# Git ls-files
glsf () {
    if [[ ! "$#" -eq 1 ]]; then
        echo 'provide filename'
        return 1
    fi
    git ls-files "**/${1}.*"
}
