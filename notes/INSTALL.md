
# Adding Zsh Environment Variables to Sway

Swap the exec in your /usr/share/wayland-sessions/sway.desktop to call to sway

```
[Desktop Entry]
Name=Sway
Comment=An i3-compatible Wayland compositor
Exec=zsh --login -c sway
Type=Application
DesktopNames=sway;wlroots
```
