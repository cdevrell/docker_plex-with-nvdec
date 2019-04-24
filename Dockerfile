FROM plexinc/pms-docker:latest

# Install wget dependancy
RUN apt-get -y update
RUN apt-get -y install wget

# Add script directory
RUN mkdir /scripts

# Copy script to enable decoding
# This script uses someone elses work - all credit goes to:
# https://gist.github.com/Xaero252/9f81593e4a5e6825c045686d685e2428
# and
# https://github.com/revr3nd/plex-nvdec/

COPY nvdec_enable.sh /scripts/nvdec_enable.sh

# Make script executable
RUN chmod +x /scripts/nvdec_enable.sh

# Execute script
RUN /bin/sh /scripts/nvdec_enable.sh

VOLUME /config /transcode
EXPOSE 32400/tcp 3005/tcp 8324/tcp 32469/tcp 1900/udp 32410/udp 32412/udp 32413/udp 32414/udp
