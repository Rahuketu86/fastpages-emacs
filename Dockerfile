FROM debian:10.3-slim
LABEL maintainer="Rahul Saraf"
RUN apt-get update && apt-get --no-install-recommends install -y \
    ca-certificates \
    emacs \
    git patch make curl \
    texlive-bibtex-extra \
    texlive-fonts-recommended \
    texlive-generic-recommended \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    texlive-lang-german \
    texlive-pictures \
    texlive-htmlxml \
    tex4ht \
    texinfo install-info \
    biber latexmk python-pygments

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update -y && apt-get --no-install-recommends install -y \
    curl ditaa ghostscript graphviz imagemagick
ENV PU_VERSION 1.2020.2
RUN curl --create-dirs -o /root/plantuml-$PU_VERSION/plantuml.zip -L https://sourceforge.net/projects/plantuml/files/$PU_VERSION/plantuml-jar-lgpl-$PU_VERSION.zip/download \
    && cd /root/plantuml-$PU_VERSION && unzip plantuml.zip && rm plantuml.zip

COPY .emacs.d /root/.emacs.d
RUN emacs --batch --eval '(load "~/.emacs.d/init.el")'
CMD ["emacs"]
