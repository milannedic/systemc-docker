FROM ubuntu:20.04
ENV SYSTEMC_VERSION 2.3.3
ENV VERILATOR_VERSION 4.010
ENV CXX g++
ENV SYSTEMC_HOME /usr/local/systemc-$SYSTEMC_VERSION
ENV LD_LIBRARY_PATH /usr/local/systemc-$SYSTEMC_VERSION/lib-linux64
ENV DEBIAN_FRONTEND=noninteractive

# Install packages
RUN apt-get update && apt-get install -y \
    build-essential cmake bash nano gtkwave \
    git \
    make \
    g++ \
    flex \
    bison \
    perl \
    python3 \
    autoconf \
    && rm -rf /var/lib/apt/lists/*

# Give some packages a name so we can delete them after build
RUN apt-get install -y --no-install-recommends \
    tar \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Download and install Verilator
RUN git clone https://github.com/verilator/verilator.git /verilator && \
    cd /verilator && \
    git checkout v$VERILATOR_VERSION && \
    autoconf && \
    ./configure && \
    make && \
    make install && \
    cd / && rm -rf /verilator

# Set PATH for Verilator
ENV PATH="/usr/local/bin:${PATH}"


# Make dir and change workdir
RUN mkdir -p /usr/local/
WORKDIR /usr/local/

# Download systemc and unpack
COPY systemc-$SYSTEMC_VERSION.tar.gz systemc-$SYSTEMC_VERSION.tar.gz
RUN tar -xzf systemc-$SYSTEMC_VERSION.tar.gz

# Prepare installation systemC
RUN mkdir /usr/local/systemc-$SYSTEMC_VERSION/objdir
WORKDIR /usr/local/systemc-$SYSTEMC_VERSION/objdir

# Configure systemc
RUN ../configure --prefix=/usr/local/systemc-$SYSTEMC_VERSION

# Install systemc
RUN make
RUN make install

WORKDIR /usr/
CMD bash
