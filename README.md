# Plex with NVDEC - Docker Image

Based on the official Plex docker image, this image applies a script provided by https://gist.github.com/Xaero252 and https://github.com/revr3nd/plex-nvdec/ to enable NVIDIA hardware decoding AND encoding.

Prereqs:

Run this on your Docker host to install the NVIDIA docker plugin:
~~~~
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

sudo apt-get install -y nvidia-docker2
sudo service docker restart
~~~~

***
Example usage:
~~~~
sudo docker run -d \
     --name plex \
     --restart=unless-stopped \
     --network=xxxxx \
     --ip=xxx.xxx.xxx.xxx \
     --runtime=nvidia
     -e NVIDIA_VISIBLE_DEVICES=all \
     -e NVIDIA_DRIVER_CAPABILITIES=compute,video,utility \
     -v plex_db:/config \
     -v plex_logs:"/config/Library/Application Support/Plex Media Server/Logs" \
     -v /data/ssd/plex_transcode:/transcode \
     -v /data/nas/media:/data/media \
     cdevrell/plex-with-nvdec
~~~~
***
