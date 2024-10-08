FROM alpine:3.11
ENV SYSTEMC_VERSION 2.3.3
ENV CXX g++
ENV SYSTEMC_HOME /usr/local/systemc-$SYSTEMC_VERSION
ENV LD_LIBRARY_PATH /usr/local/systemc-$SYSTEMC_VERSION/lib-linux64

# Install packages
RUN apk --no-cache add build-base cmake bash nano
# Give some packages a name so we can delete the after build
RUN apk --no-cache add --virtual build-deps tar zip

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

# Remove the unnecessary pacakges
RUN apk del build-deps

WORKDIR /usr/
CMD bash
