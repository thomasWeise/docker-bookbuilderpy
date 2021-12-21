#
# thomasweise/docker-bookbuilderpy
#
# This is an image with a basic TeX Live installation,
# pandoc, and R, and my bookbuilderpy Python package.
# Source: https://github.com/thomasWeise/docker-bookbuilderpy/
# License: GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007
# The license applies to the way the image is built, while the
# software components inside the image are under the respective
# licenses chosen by their respective copyright holders.
#
FROM thomasweise/docker-pandoc-calibre:3.3
MAINTAINER Thomas Weise <tweise@hfuu.edu.cn>

# do all the installation
RUN echo "Initial update." &&\
    apt-get update &&\
# install git, which we need to access code repositories and pip
    echo "Install git." &&\
    apt-get install -f -y firefox \
                          firefox-geckodriver \
                          git \
                          libcairo2-dev \
                          libdbus-1-dev \
                          libgirepository1.0-dev \
                          pkg-config \
                          python3-pip \
                          zip &&\
    cd /tmp/ &&\
    echo "1: Updating all Python packages that are already installed." &&\
    (python3 -c "import pkg_resources; from subprocess import call; packages = [dist.project_name for dist in pkg_resources.working_set]; call(\"pip install --upgrade \" + \" \".join(packages), shell=True)" || true) &&\
    echo "2: Updating all Python packages that are already installed." &&\
    (pip3 freeze --local |sed -rn 's/^([^=# \t\\][^ \t=]*)=.*/echo; echo Processing \1 ...; pip3 install -U \1/p' |sh || true) &&\
    echo "3: Updating all Python packages that are already installed." &&\
    (python3 -c "import pkg_resources; from subprocess import call; packages = [dist.project_name for dist in pkg_resources.working_set]; call(\"pip install --upgrade \" + \" \".join(packages), shell=True)" || true) &&\
    echo "4: Updating all Python packages that are already installed." &&\
    (pip3 freeze --local |sed -rn 's/^([^=# \t\\][^ \t=]*)=.*/echo; echo Processing \1 ...; pip3 install -U \1/p' |sh || true) &&\
    echo "5: Updating all Python packages that are already installed." &&\
    (python3 -c "import pkg_resources; from subprocess import call; packages = [dist.project_name for dist in pkg_resources.working_set]; call(\"pip install --upgrade \" + \" \".join(packages), shell=True)" || true) &&\
    echo "6: Updating all Python packages that are already installed." &&\
    (pip3 freeze --local |sed -rn 's/^([^=# \t\\][^ \t=]*)=.*/echo; echo Processing \1 ...; pip3 install -U \1/p' |sh || true) &&\
    export bbp_version="1.9.14" &&\
    echo "Installing Python-package bookbuilderpy version ${bbp_version}." &&\
    mkdir /tmp/bbp &&\
    cd /tmp/bbp &&\
    curl -L -v -o bbp.tar.gz "https://github.com/thomasWeise/bookbuilderpy/archive/refs/tags/${bbp_version}.tar.gz" &&\
    tar -xf /tmp/bbp/bbp.tar.gz &&\
    pip3 install /tmp/bbp/bookbuilderpy-${bbp_version} &&\
    cd /tmp/ &&\
    rm -rf /tmp/bbp/ &&\
    echo "Cleaning up unneeded packages and other stuff." &&\
    apt-get remove -y binutils binutils-common binutils-x86-64-linux-gnu \
                      build-essential bzip2 cpp  cpp-11 dirmngr dpkg-dev \
                      fakeroot g++ g++-11 gcc gcc-11 gnupg gnupg-l10n  \
                      gnupg-utils gpg gpg-agent gpg-wks-client \
                      gpg-wks-server gpgconf gpgsm libalgorithm-diff-perl \
                      libalgorithm-diff-xs-perl libalgorithm-merge-perl \
                      libasan6 libassuan0 libatomic1 libbinutils libcc1-0 \
                      libctf-nobfd0 libctf0 libdpkg-perl libexpat1-dev \
                      libfakeroot libfile-fcntllock-perl libgcc-11-dev \
                      libisl23 libitm1 libjs-sphinxdoc libjs-underscore \
                      libksba8 liblsan0 libmpc3 libnpth0 libquadmath0 \
                      libstdc++-11-dev libtsan0 libubsan1 \
                      lto-disabled-list pinentry-curses python3-pip &&\
    rm -rf /root/.cache/ &&\
# test the whole build process one time
    echo "Testing the build process using minimal working example." &&\
    cd /tmp/ &&\
    mkdir example &&\
    cd example &&\
    git clone https://github.com/thomasWeise/bookbuilderpy-mwe.git &&\
    mkdir result &&\
    python3 -c "from bookbuilderpy import Build; Build.run(input_file=\"/tmp/example/bookbuilderpy-mwe/book.md\", output_dir=\"/tmp/example/result/\", exit_on_error=True);" &&\
    cd /tmp/ &&\
    rm -rf example &&\
# the directories for input and output
    echo "Make directories for input and output." &&\
    mkdir /input/ &&\
    mkdir /output/ &&\
# cleanup
    echo "Final cleanup." &&\
    apt-get clean &&\
    rm -rf /tmp/* /var/tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -f /etc/ssh/ssh_host_* &&\
    echo "All done."

ADD scripts /bin/

ENTRYPOINT ["/bin/main.sh"]

# the volumes for the input and output
VOLUME ["/input/", "/output/"]
