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

function sddb() {
    if [[ -z "$1" ]] ; then
        echo "provide: (m1/m2/b52/b53)"
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

# test resources

# examples
# 'cdm_cluster(software=artifacts_url://http://cdm-builds.corp.rubrik.com/job/Build_CDM/10808/artifact/artifacts.json, location=colo, node_count=3)'
# 'esx_host(cpu=4, location=COLO, model=virtual)'
# 'vm_machine(image_source=legacy-ubuntu-source, location=COLO)'
# 'vm_machine(image_source=legacy-ubuntu-source, location=COLO)'
# 'item_1:vm_machine(location=COLO, image_source=legacy-ubuntu-source)' 'item_2:vm_machine(location=COLO, image_source=legacy-ubuntu-source)' 'item_3:cdm_cluster(software=artifacts_url://http://cdm-builds.corp.rubrik.com/job/Build_CDM/10808/artifact/artifacts.json, location=colo, node_count=3)' 'item_4:esx_host(cpu=4, location'
# 'item_1:vm_machine(location=COLO, image_source=legacy-ubuntu-source)' 'item_2:vm_machine(location=COLO, image_source=legacy-ubuntu-source)' 'item_3:cdm_cluster(location=COLO, model=justvm-vmware-standard, node_count=1)' 'item_4:vm_machine(location=COLO, image_source=ubuntu_16_04_lts)' 'item_5:sd_dev_machine(location=COLO, network=native, version=a43c1c49c81aa3af3c3981210b4cc02639d86979)'
# 'item_1:cdm_cluster(location=COLO, model=justvm-vmware-standard, node_count=1)' 'item_2:vm_machine(location=COLO, image_source=ubuntu_16_04_lts)' 'item_3:sd_dev_machine(location=COLO, network=native, version=8ff632182277bfe9e8ae61d9cf9e838593e438f9)'

# 'cdm_cluster(version=master)'
# 'cdm_cluster(version=5.3.1)'

# https://rubrik.atlassian.net/browse/CDM-228792
# yoda_e2e.hypervisors.hypervisor_vm_restore_xattr_test.VmwareRestoreUbuntuHostViaRBATest.test_restore_large_fileset
# 'cdm_cluster(version=http://cdm-builds.corp.rubrik.com/job/Build_CDM_Disk_Image_5.3/231/artifact/artifacts.json, location=COLO, node_count=1)'
# 'vm_machine(location=COLO, image_source=pipeline-ubuntu_16_04_lts)'
# 'item_1:vm_machine(location=COLO, image_source=pipeline-ubuntu_16_04_lts)' 'item_2:cdm_cluster(artifacts_url=http://cdm-builds.corp.rubrik.com/job/Build_CDM_5.3/18629/artifact/artifacts.json, location=COLO, node_count=1)'

# 'cdm_cluster(software=artifacts_url://http://cdm-builds.corp.rubrik.com/job/Build_CDM_Disk_Image_5.3/558/artifact/artifacts.json, location=COLO, node_count=1)'
# 'vm_machine(location=COLO, image_source=pipeline-legacy-ubuntu-host)'
# 'vm_machine(location=COLO, image_source=pipeline-legacy-ubuntu-host)'
# 'item_1:cdm_cluster(software=artifacts_url://http://cdm-builds.corp.rubrik.com/job/Build_CDM_Disk_Image_5.3/558/artifact/artifacts.json, location=COLO, node_count=1)' 'item_2:vm_machine(location=COLO, image_source=pipeline-legacy-ubuntu-host)' 'item_3:vm_machine(location=COLO, image_source=pipeline-legacy-ubuntu-host)'
