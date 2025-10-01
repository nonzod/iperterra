# Hyprland Configuration

## Monitor Setup
- **DP-3**: NEC 1920x1080@60Hz (sinistra)
- **DP-1**: MSI 2560x1440@164.8Hz (destra, primario)

## Gnome Keyring (VSCode, Slack)

### Autostart (hyprland.conf)
```bash
exec-once = dbus-update-activation-environment --all
exec-once = gnome-keyring-daemon --start --components=pkcs11,secrets,ssh
exec-once = dbus-update-activation-environment --systemd SSH_AUTH_SOCK GNOME_KEYRING_CONTROL
```

### VSCode
File: `~/.vscode/argv.json`
```json
{
  "password-store": "gnome-libsecret"
}
```

### Slack (Flatpak)
File: `~/.local/share/applications/com.slack.Slack.desktop`
```
Exec=/usr/bin/flatpak run --password-store=gnome-libsecret --branch=stable ...
```

## Waybar (System Tray)

### Autostart (hyprland.conf)
```bash
exec-once = waybar
```

### Configurazione
- Moduli Hyprland: `hyprland/workspaces`, `hyprland/window`, `hyprland/language`
- Rimossi: `mpd`, `power-profiles-daemon` (non installati)
- Tray abilitato per applicazioni come Bitwarden

## Pacchetti Richiesti
- `gnome-keyring`
- `libsecret`
- `libgnome-keyring`
- `waybar`
