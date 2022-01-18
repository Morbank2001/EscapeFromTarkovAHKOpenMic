# EscapeFromTarkovAHKOpenMic
Autohotkey script to use EFT's Push-To-Talk as an Open-Mic setup. 

This script uses Vista Audio Control library
https://www.autohotkey.com/board/topic/21984-vista-audio-control-functions/?p=143564

and I made this script using parts of this AHK script: VA_GetAudioMeter https://ahkscript.github.io/VistaAudio/#VA_GetAudioMeter

Default Voip key is set to "j"
When mic peaks past default threshold set (default is 0.6), AHK holds the VOIP key for the set amount of time (default 500ms).

CTRL + ALT + M toggles the AHK sending keypresses
CTRL + ALT + T toggles testing mode which shows current audio level and sends SoundBeeps when peaking mic.
CTRL + ALT + MWheel increase or decrease threshold.
