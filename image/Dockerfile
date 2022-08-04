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
FROM thomasweise/docker-pandoc-calibre:5.0
MAINTAINER Thomas Weise <tweise@hfuu.edu.cn>

# do all the installation
RUN echo "Initial update." &&\
    apt-get update &&\
    echo "Install python and git and other tools." &&\
    apt-get install -f -y --no-install-recommends git \
                                                  libcairo2-dev \
                                                  libdbus-1-dev \
                                                  libgirepository1.0-dev \
                                                  pkg-config \
                                                  python3-pip \
                                                  zip &&\
    echo "Done installing python and git, got the following versions:" &&\
    git --version &&\
    python3 --version &&\
# Installing firefox and firefox geckdriver is a major headache now.
# They come as snaps and that doesn't work here.
# Adding the ppa for installing the deb files instead won't work either.
# So we first install all requirements, then download the deb files and install them.
# This means that we a) need to deal with stale deb urls and b) need to check the requirements perpetuously.
# Sigh.
    echo "Now installing firefox requirements."  &&\
    apt-get install -f -y --no-install-recommends lsb-release \
                                                  libasound2 \
                                                  libatk1.0-0 \
                                                  libdbus-glib-1-2 \
                                                  libgtk-3-0  \
                                                  libxcomposite1 \
                                                  libxcursor1 \
                                                  libxdamage1 \
                                                  libxrandr2 \
                                                  libxtst6 &&\
# got urls from https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/pool/main/f/firefox/
    echo "Now installing firefox as deb (as opposed to snap)." &&\
    cd /tmp/ &&\
    curl -L "https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/pool/main/f/firefox/firefox_103.0.1+build1-0ubuntu0.22.10.1~mt1_amd64.deb" -o firefox.deb &&\
    dpkg -i --ignore-depends=libx11-xcb1 firefox.deb &&\
    rm -f firefox.deb &&\
    curl -L "https://ppa.launchpadcontent.net/mozillateam/ppa/ubuntu/pool/main/f/firefox/firefox-geckodriver_103.0.1+build1-0ubuntu0.22.10.1~mt1_amd64.deb" -o firefox-geckodriver.deb &&\
    dpkg -i firefox-geckodriver.deb &&\
    rm -f firefox-geckodriver.deb &&\
    echo "Done installing firefox and firefox-geckodriver. Got versions:" &&\
    firefox --version &&\
    geckodriver --version &&\
    echo "0: Updating pip" &&\
    pip install --upgrade pip &&\
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
    export bbp_version="1.9.23" &&\
    echo "Installing Python-package bookbuilderpy version ${bbp_version}." &&\
    pip3 install bookbuilderpy==${bbp_version} &&\
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
# the directories for input and output
    echo "Make directories for input and output." &&\
    mkdir /input/ &&\
    mkdir /output/ &&\
# marking input directory as safe.
    echo "Marking /input as safe directory." &&\
    git config --global --add safe.directory /input &&\
# test the whole build process one time
    echo "Testing the build process using minimal working example." &&\
    cd /input/ &&\
    git clone https://github.com/thomasWeise/bookbuilderpy-mwe.git &&\
    python3 -c "from bookbuilderpy import Build; Build.run(input_file=\"/input/bookbuilderpy-mwe/book.md\", output_dir=\"/output/\", exit_on_error=True);" &&\
    echo "Cleaning up example." &&\
    rm -rf /input/* &&\
    rm -rf /output/* &&\
# cleanup
    echo "Final cleanup." &&\
    cd /tmp &&\
    apt-get clean &&\
    rm -rf /tmp/* /var/tmp/* &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -f /etc/ssh/ssh_host_* &&\
    echo "All done."

ADD scripts /bin/

ENTRYPOINT ["/bin/main.sh"]

# the volumes for the input and output
VOLUME ["/input/", "/output/"]
