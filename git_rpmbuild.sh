#!/bin/bash

# completion time was about 24 minutes

# info: green color text
function info () {
  echo -e "\e[32mINFO: $@\e[0m"
}

# warn: yellow color text
function warn () {
  echo -e "\e[33mWARN: $@\e[0m"
}

# error: red color text and exit 1
function error () {
  echo -e "\e[31mERROR: $@\e[0m"
  exit 1
}

# rm_root_dir: all work starts in ~/, pass one argument, a full path will remove force.
function rm_root_dir() {
  cd ~/
  if [[ -d ${1} ]]; then
    warn "removing directory: ${1}"
    rm -rf "${1}"
  fi
}

# download: pass one argument, a full path url to item to download.
function download () {
  curl -OL ${1}
}

if [[ $EUID -ne 0 ]]; then
  error "This script should be run as the root user"
fi

info "Check for old directories"
rm_root_dir "git"
rm_root_dir "rpmbuild"
rm_root_dir "src"

info "Install dependecies"
yum install -y rpm-build openssl-devel bash-completion zlib-devel python2-devel
yum install -y asciidoc xmlto desktop-file-utils emacs expat-devel libcurl-devel libsecret-devel pcre2-devel tcl tk
yum install -y highlight httpd mod_dav_svn perl-CGI perl-DBD-SQLite perl-Digest-MD5 perl-HTTP-Date perl-IO-Tty perl-MailTools perl-Test-Simple subversion subversion-perl time

# git scm version
version="2.19.2"
mirror_url="https://mirrors.edge.kernel.org/pub/software/scm/git/"
git_tar="git-${version}.tar.xz"
git_sign="git-${version}.tar.sign"

info "create default rpmbuild required directories"
mkdir -p ~/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p ~/src

info "moving to ~/src"
cd ~/src

info "use curl to download the git tar file"
info "Download ${git_tar}"
download "${mirror_url}${git_tar}"

info "extract tar"
tar -xvf ${git_tar}

info "move tar into SOURCES"
mv ${git_tar} ~/rpmbuild/SOURCES/

info "download git sign file"
cd ~/rpmbuild/SOURCES/
download "${mirror_url}${git_sign}"

info "move to ~/"
cd ~/

info "clone fedora git repo"
git clone https://src.fedoraproject.org/git/rpms/git.git

info "copy the git repo contents to SOURCES"
cp -r ~/git/* ~/rpmbuild/SOURCES/

info "move into ~/src/git version directory we extracted"
cd ~/src/git-${version}/

info "curl fedora git.spec"
# note, this file does have a version in it, currently matching 2.19.2
download "http://pkgs.fedoraproject.org/cgit/rpms/git.git/plain/git.spec"

# when running with all tests TRUE, I started down the path removing the ones
# that were giving me problems. They all have start_httpd, I'm not sure what
# prereq's are needed to get this working. I just removed the tests for now
# that I found in the git.spec file.
# skip_tests_list="t5812 t5703 t5702 t5700 t5616 t5601"
skip_tests_list=""
warn "skipping tests: ${skip_tests_list}"
sed -i "s/^GIT_SKIP_TESTS=\"\"/GIT_SKIP_TESTS=\"${skip_tests_list}\"/" ~/src/git-${version}/git.spec

# turn tests to FALSE
warn "turn off tests for GIT_SVN_TEST_HTTPD"
sed -i "s/GIT_SVN_TEST_HTTPD=true/GIT_SVN_TEST_HTTPD=false/" ~/src/git-${version}/git.spec
warn "turn off tests for GIT_TEST_GIT_DAEMON"
sed -i "s/GIT_TEST_GIT_DAEMON=true/GIT_TEST_GIT_DAEMON=false/" ~/src/git-${version}/git.spec
warn "turn off tests for GIT_TEST_HTTPD"
sed -i "s/GIT_TEST_HTTPD=true/GIT_TEST_HTTPD=false/" ~/src/git-${version}/git.spec
warn "turn off tests for GIT_TEST_SVNSERVE"
sed -i "s/GIT_TEST_SVNSERVE=true/GIT_TEST_SVNSERVE=false/" ~/src/git-${version}/git.spec

info "Building git version: ${version}"
info "build rpm from fedora git.spec"
rpmbuild --without p4 --without cvs --without docs -ba git.spec
