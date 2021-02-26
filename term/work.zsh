# dev VM
detach="$HOME/.config/scripts/detach"
conf="$HOME/dotfiles/term/alacritty-dev.yml"

function ssh-dev() {
    "$detach" alacritty --config-file="$conf" -e ssh ubuntu@$dev_vm
    exit 0
}

# marcus-ubuntu14-pure
function ssh-vm-pure() {
    "$detach" alacritty --config-file="$conf" -e ssh ubuntu@$vm_pure
    exit 0
}

# marcus-ubuntu14-local
function ssh-vm-local() {
    "$detach" alacritty --config-file="$conf" -e ssh ubuntu@$vm_local
    exit 0
}

# OUTSIDE SDDB
function vpn() {
    globalprotect launch-ui
}

function sddb() {
    if [[ $# -lt 1 ]] ; then
        echo 'provide: (m1/m2/b52/b53)'
    else
        case $1 in
            m1) sd_dev_box --sdmain_repo ~/sdmain;;
            m2) sd_dev_box --sdmain_repo ~/master-2/sdmain;;
            m3) sd_dev_box --sdmain_repo ~/master-3/sdmain;;
            b52) sd_dev_box --sdmain_repo ~/b52/sdmain;;
            b53) sd_dev_box --sdmain_repo ~/b53/sdmain;;
            *)
                echo "provide: (m1/m2/b52/b53)"
        esac
    fi
}

# WITHIN SDDB
# assumption: running from sdmain folder within sddb
alias bodega="${PWD}/lab/bin/bodega"
alias cluster="${PWD}/deployment/cluster.sh"

# UTILITY
# (outside sddb)
function cleandocker() {
    docker system prune -a
}

# (inside sddb)
function owncache() {
    sudo chown -R ubuntu:ubuntu /home/ubuntu/.cache/
}

# BUILD (within sddb)
function bscala() {
    time SKIP_PANTS=1 SKIP_CPP=1 SKIP_GO=1 SKIP_WIN=1 SKIP_LINUX=1 SKIP_AGENT=1 SKIP_WEB=1 SKIP_SUSE=1 SKIP_TESTS=1 SKIP_JAVA=0 ./src/scripts/dev/buildAll.sh
}

function bscalatest() {
	time SKIP_PANTS=1 SKIP_CPP=1 SKIP_GO=1 SKIP_WIN=1 SKIP_LINUX=1 SKIP_AGENT=1 SKIP_WEB=1 SKIP_SUSE=1 SKIP_TESTS=0 SKIP_JAVA=0 ./src/scripts/dev/buildAll.sh
}

function bscalaclean() {
	time SKIP_PANTS=1 SKIP_CPP=1 SKIP_GO=1 SKIP_WIN=1 SKIP_LINUX=1 SKIP_AGENT=1 SKIP_WEB=1 SKIP_SUSE=1 CLEAN_TESTS=0 CLEAN_JAVA=1 ./src/scripts/dev/buildAll.sh
}

function bclean() {
	time CLEAN_ALL=1 ./src/scripts/dev/buildAll.sh
}

function bcleancache() {
	time bazel clean --async --expunge
}

function bintellijdeps() {
	time ./tools/bzl_tools/build/gen_intellij_deps.sh
}