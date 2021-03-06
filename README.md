# [thomasWeise/docker-bookbuilderpy](http://hub.docker.com/r/thomasweise/docker-bookbuilderpy/): A Docker Container for Building Electronic Books from Pandoc Markdown

[![Docker Pulls](http://img.shields.io/docker/pulls/thomasweise/docker-bookbuilderpy.svg)](http://hub.docker.com/r/thomasweise/docker-bookbuilderpy/)
[![Docker Stars](http://img.shields.io/docker/stars/thomasweise/docker-bookbuilderpy.svg)](http://hub.docker.com/r/thomasweise/docker-bookbuilderpy/)

## 1. Introduction

This is a [docker](https://www.docker.com) container intended for building electronic books from [pandoc's markdown flavor](http://pandoc.org/MANUAL.html#pandocs-markdown) by using [pandoc](http://pandoc.org/), [`Python`](https://www.python.org/), and [TeX Live](http://tug.org/texlive/). It has pre-installed the `Python` package [`bookbuilderpy`](http://github.com/thomasWeise/bookbuilderpy) which provides an infrastructure and additional commands to deal with hierarchically structured books and documents.

**Please read the documentation of [`bookbuilderpy`](http://github.com/thomasWeise/bookbuilderpy)  regarding how to use this image as fully-automated book writing and publishing tool chain.**

## 2. Local Book Compilation

The container offers a wide variety of utils to build electronic books from markdown sources, which are all discussed in the documentation of [`bookbuildeR`](http://github.com/thomasWeise/bookbuildeR).
Here we just provide a very quick and ultra-short description about how you can run this container locally.

You can apply the [`bookbuildeR`](http://github.com/thomasWeise/bookbuildeR) package locally to a book or document you write on your computer.
In order to avoid installing all required software and even to avoid messing with `R`, you can use this [docker container](http://hub.docker.com/r/thomasweise/docker-bookbuilder/) here that we have developed for this purpose.
[Docker](https://en.wikipedia.org/wiki/Docker_(software)) is something like a light-weight virtual machine, and our container is basically a copy of a complete Linux installation with all required components that you can run on your local computer.

If you have Linux and docker installed on your system, all what it takes is the following command:

```shell
docker run -v "INPUT_DIR":/input/:ro \
           -v "OUTPUT_DIR":/output/ \
           thomasweise/docker-bookbuilderpy BOOK_ROOT_MD_FILE
```

Under many distributions, you need to run this command as `sudo`.
Here, it is assumed that

- `INPUT_DIR` is the directory where your book sources reside, let's say `/home/my/book/sources/`. (By adding `:ro`, we mount the input directory read-only, just in case.)
- `BOOK_ROOT_MD_FILE` is the root file of your book, say `book.md` (in which case, the full path of `book.md` would be `/home/my/book/sources/book.md`). Notice that you can specify only a single file, but this file can reference other files in sub-directories of `INPUT_DIR` by using commands such as  `\rel.input` (see [below](#32-bookbuilderpy-specific-commands)).
- `OUTPUT_DIR` is the output directory where the compiled files should be placed, e.g., `/home/my/book/compiled/`. This is where the resulting files will be placed.

If you want to try the above, you can clone the "minimal working example" repository [thomasWeise/bookbuilderpy-mwe](https://github.com/thomasWeise/bookbuilderpy-mwe) and run the process to see what it does as follows **execute the code below at your own risk**:

```shell
mkdir example
cd example
git clone https://github.com/thomasWeise/bookbuilderpy-mwe.git
mkdir result
sudo docker run -v "$(pwd)/bookbuilderpy-mwe":/input/:ro -v "$(pwd)/result":/output/ thomasweise/docker-bookbuilderpy book.md
sudo chown $USER -R result
```

Above, we create a folder called `example`.
We then clone the repository [thomasWeise/bookbuilderpy-mwe](https://github.com/thomasWeise/bookbuilderpy-mwe), creating the folder `bookbuilderpy-mwe` containing the example book sources.
Then, directory `result` is created, into which we will build the book.
With `sudo docker run -v bookbuilderpy-mwe:/input/:ro -v result:/output/ thomasweise/docker-bookbuilderpy book.md`, the build process is executed.
Since it runs under `sudo`, the files will be generated with `sudo` permissions/ownership, so we transfer them to the user ownership via `sudo chown $USER -R result`.
You can now peek into the `result` folder.
It will contain a file `index.html`, which is the automatically generated (bare minimum) book website, from which you can access all other generated files.

And that's it.
No software installation, besides docker, is required.
The container brings all required tools, scripts, packages, and what not.
Additionally, in the documentation of the [`bookbuilderpy`](http://github.com/thomasWeise/bookbuilderpy) package, you can find all extensions to the markdown language we introduce and how the whole build process can be automated by using continuous integration tool chains.

## 3. License

This image is licensed under the GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007, which you can find in file [LICENSE.md](http://github.com/thomasWeise/docker-bookbuilder/blob/master/LICENSE.md). The license applies to the way the image is built, while the software components inside the image are under the respective licenses chosen by their respective copyright holders.

## 4. Contact

If you have any questions or suggestions, please contact
[Prof. Dr. Thomas Weise](http://iao.hfuu.edu.cn/team/director) of the
[Institute of Applied Optimization](http://iao.hfuu.edu.cn/) at
[Hefei University](http://www.hfuu.edu.cn) in
Hefei, Anhui, China via
email to [tweise@hfuu.edu.cn](mailto:tweise@hfuu.edu.cn) and [tweise@gmx.de](mailto:tweise@gmx.de).
