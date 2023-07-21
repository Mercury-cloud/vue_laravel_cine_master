#! / usr / bin / env bash

set -e

# Utilisation create-vod-hls.sh SOURCE_FILE [OUTPUT_NAME]
[[ !  " $ {1} " ]] &&  echo  " Utilisation: create-vod-hls.sh SOURCE_FILE [OUTPUT_NAME] "  &&  exit 1

# commenter / ajouter des lignes ici pour contrôler les rendus à créer
rendus = (
# débit audio de résolution
#   "426x240 400k 64k"
  " 640x360 800k 96k "
  " 842x480 1400k 128k "
  " 1280x720 2800k 128k "
  " 1920x1080 5000k 192k "
)

segment_target_duration = 4        # essayez de créer un nouveau segment toutes les X secondes
max_bitrate_ratio = 1.07           # fluctuations maximales acceptées du débit binaire
rate_monitor_buffer_ratio = 1,5    # taille maximale du tampon entre les contrôles de conformité du débit binaire

# ################################################# #######################

source = " $ {1} "
target = " $ {2} "
si [[ !  " $ {target} " ]] ;  puis
  target = " $ {source ## * / } "  # ne laisse que le dernier composant du chemin
  target = " $ {target % . * } "   # extension de bande
Fi
mkdir -p $ {target}


key_frames_interval = " $ ( echo ` ffprobe $ {} source de  2> & 1  | grep -oe ' [[: digit:]]. + ([[: digit:]]? +) images par seconde '  | grep -oe ' [[: chiffre:]] + (. [[: chiffre:]] +)? ' ' * 2 | bc ||  écho  ' ' ) "
key_frames_interval = $ {key_frames_interval : - 50}
key_frames_interval = $ ( echo ` printf " % .1f \ n "  $ ( bc -l <<< " $ key_frames_interval / 10 " ) ` * 10 | bc )  # round
key_frames_interval = $ {key_frames_interval % . * }  # tronqué en entier

# paramètres statiques similaires pour tous les rendus
static_params = " -c: a aac -ar 48000 -c: v h264 -profile: v main -crf 20 -sc_threshold 0 "
static_params + = " -g $ {key_frames_interval} -keyint_min $ {key_frames_interval} -hls_time $ {segment_target_duration} "
static_params + = " -hls_playlist_type vod "

# paramètres divers
misc_params = " -hide_banner -y "

master_playlist = " # EXTM3U
# VERSION EXT-X: 3
"
cmd = " "
pour le  rendu  dans  " $ {renditions [@]} " ;  faire
  # supprimer les espaces superflus
  rendition = " $ {rendition / [[: space:]] + / } "

  # champs de rendu
  resolution = " $ ( echo $ {rendition}  | cut -d '  ' -f 1 ) "
  bitrate = " $ ( echo $ {rendition}  | cut -d '  ' -f 2 ) "
  audiorate = " $ ( echo $ {rendition}  | cut -d '  ' -f 3 ) "

  # champs calculés
  width = " $ ( echo $ {resolution}  | grep -oE ' ^ [[: digit:]] + ' ) "
  height = " $ ( echo $ {resolution}  | grep -oE ' [[: digit:]] + $ ' ) "
  maxrate = " $ ( echo " ` echo $ {bitrate}  | grep -oE ' [[: digit:]] + ' ` * $ {max_bitrate_ratio} "  | bc ) "
  bufsize = " $ ( echo " ` echo $ {bitrate}  | grep -oE ' [[: digit:]] + ' ` * $ {rate_monitor_buffer_ratio} "  | bc ) "
  bande passante = " $ ( echo $ {bitrate}  | grep -oE ' [[: digit:]] + ' ) 000 "
  name = " $ {height} p "
  
  cmd + = "  $ {static_params} -vf scale = w = $ {width} : h = $ {height} : force_original_aspect_ratio = diminuer "
  cmd + = " -b: v $ {bitrate} -maxrate $ {maxrate % . * } k -bufsize $ {bufsize % . * } k -b: a $ {audiorate} "
  cmd + = " -hls_segment_filename $ {target} / $ {name} _% 03d.ts $ {target} / $ {name} .m3u8 "
  
  # ajouter une entrée de rendu dans la liste de lecture principale
  master_playlist + = " # EXT-X-STREAM-INF: BANDWIDTH = $ {bandwidth} , RESOLUTION = $ {resolution} \ n $ {name} .m3u8 \ n "
terminé

# démarrer la conversion
echo -e " Exécution de la commande: \ nffmpeg $ {misc_params} -i $ {source}  $ {cmd} "
ffmpeg $ {misc_params} -i $ {source}  $ {cmd}

# créer un fichier de playlist principal
echo -e " $ {master_playlist} "  >  $ {target} /playlist.m3u8

echo  " Terminé - HLS codé est à $ {target} / "
