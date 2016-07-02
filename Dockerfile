FROM gbalaraman/quantlib:1.8-alpine3.3
MAINTAINER Goutham Balaraman <gouthaman.balaraman@gmail.com>
LABEL Description="An environment with the QuantLib Python module"

RUN apk update && apk add --no-cache python python-dev swig

ARG quantlib_swig_version=1.8
ENV quantlib_swig_version ${quantlib_swig_version}

RUN wget http://downloads.sourceforge.net/project/quantlib/QuantLib/${quantlib_swig_version}/other\ languages/QuantLib-SWIG-${quantlib_swig_version}.tar.gz \
    && tar xfz QuantLib-SWIG-${quantlib_swig_version}.tar.gz \
    && rm QuantLib-SWIG-${quantlib_swig_version}.tar.gz \
    && cd QuantLib-SWIG-${quantlib_swig_version} \
    && ./configure --disable-perl --disable-ruby --disable-mzscheme --disable-guile --disable-csharp --disable-ocaml --disable-r --disable-java CXXFLAGS=-O3 \
    && make && make install \
    && cd .. && rm -rf QuantLib-SWIG-${quantlib_swig_version}

CMD python

