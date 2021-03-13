curr=$(dirname $(realpath $0))
parent=$(dirname $curr)
sshr="$parent/scripts/sshr"
conf="$curr/alacritty-dev.yml"

# DEV VM =======================================================================

function ssh-dev() {
    "$sshr" ubuntu "$dev_vm"
}

# marcus-ubuntu14-pure
function ssh-vm-pure() {
    "$sshr" ubuntu "$vm_pure"
}

# marcus-ubuntu14-local
function ssh-vm-local() {
    "$detach" ubuntu "$vm_local"
}

# OUTSIDE SDDB =================================================================

function vpn() {
    globalprotect launch-ui
}

function cleandocker() {
    docker system prune -a
}

# WITHIN SDDB ==================================================================
# assumption: running from sdmain folder within sddb

alias bodega="${PWD}/lab/bin/bodega"
alias cluster="${PWD}/deployment/cluster.sh"
alias pord="bodega place order "
alias lord="bodega list orders"
alias cord="bodega consume order "
alias eord="bodega extend order "

function owncache() {
    sudo chown -R ubuntu:ubuntu /home/ubuntu/.cache/
}

# build scripts
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