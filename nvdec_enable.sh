#!/bin/bash
plex_nvdec_url="https://raw.githubusercontent.com/revr3nd/plex-nvdec/master/plex-nvdec-patch.sh"

# Change the variable below if you wish to edit which codecs are decoded:
#CODECS=("h264" "hevc" "mpeg2video" "mpeg4" "vc1" "vp8" "vp9")

# Turn the CODECS array into a string of arguments for the wrapper script:
if [ "$CODECS" ]; then
	codec_arguments=""
	for format in "${CODECS[@]}"; do
		codec_arguments+=" -c ${format}"
	done
fi

echo -n "<b>Applying hardware decode patch... </b><br/>"

# Grab the latest version of the plex-nvdec-patch.sh from github:
echo 'Downloading patch script...'
/bin/sh -c "wget -q --show-progress --progress=bar:force:noscroll -P /usr/lib/plexmediaserver/ ${plex_nvdec_url}"

# Make the patch script executable.
chmod +x "/usr/lib/plexmediaserver/plex-nvdec-patch.sh"

# Run the script, with arguments for codecs, if present.
command="/usr/lib/plexmediaserver/plex-nvdec-patch.sh"
if [ "$codec_arguments" ]; then
	command+="${codec_arguments}"
	/bin/sh -c "${command}${codec_arguments}"
else
	/bin/sh -c "${command}"
fi