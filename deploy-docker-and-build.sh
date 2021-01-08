
# run as root for pulseaudio, for X11 forwarding via docker check selinux settings or !!lastly dangeously in work environemnts other security !unsafe -> setenforce 0 

xhost SI:localuser:root
# mkdir -p /home/developer
# docker build -t marilyn  . --no-cache

docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --device /dev/snd c4pt/marilyn-current


