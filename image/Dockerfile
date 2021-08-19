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
FROM thomasweise/docker-pandoc-calibre:2.0
MAINTAINER Thomas Weise <tweise@hfuu.edu.cn>

# do all the installation
RUN echo "Initial update." &&\
    apt-get update &&\
# install git, which we need to access code repositories and pip
    echo "Install git." &&\
    apt-get install -f -y git \
                          python3-pip &&\
    cd /tmp/ &&\
    echo "Install Python-package bookbuilderpy." &&\
     python3 -m pip install git+https://github.com/thomasWeise/bookbuilderpy.git &&\
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