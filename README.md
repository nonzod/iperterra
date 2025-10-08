# Hyprland Configuration

## Struttura File
- `hyprland.conf` - Configurazione principale
- `autostart.conf` - Applicazioni e servizi all'avvio (exec-once)

## Monitor Setup
- **DP-3**: NEC 1920x1080@60Hz (sinistra)
- **DP-1**: MSI 2560x1440@164.8Hz (destra, primario)

## Gnome Keyring (VSCode, Slack)

### Autostart (autostart.conf)
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

## Applicazioni Predefinite
- **Terminal**: `kitty`
- **File Manager**: `nautilus` (GNOME Files)
- **Menu**: `wofi`

## eww (Status Bar)

### Autostart (autostart.conf)
```bash
exec-once = eww open bar && eww open bar1
```

### Configurazione
File: `~/.config/eww/`
- `eww.yuck` - Definizione widget e finestre
- `eww.scss` - Stili CSS

### Funzionalità
- **Workspaces per monitor**:
  - Monitor 0 (DP-1 - MSI): workspace 1-5
  - Monitor 1 (DP-3 - NEC): workspace 6-10
  - Click su workspace per switchare
  - Evidenziazione workspace attivo (blu) e occupato (bianco)
- **System Tray**: icone applicazioni (Bitwarden, ecc.)
- **Audio**:
  - Icona volume dinamica con stato mute
  - Click su icona: mute/unmute
  - Click su percentuale: apre `pwvucontrol`
  - Scroll su icona: +/- 5% volume
- **Orologio**: formato HH:MM

### Reload
```bash
eww reload
```

## GVFS Automount (Dischi Removibili)

### Autostart (autostart.conf)
```bash
exec-once = /usr/lib/gvfs/gvfsd &
exec-once = /usr/lib/gvfs/gvfs-udisks2-volume-monitor &
```

Abilita automount per chiavette USB e dischi esterni tramite i daemon GVFS di GNOME. Funziona con file manager che supportano gvfs (Nautilus, Dolphin, Thunar, ecc.).

## Pacchetti Richiesti
- `gnome-keyring`
- `libsecret`
- `libgnome-keyring`
- `eww`
- `pwvucontrol` (controllo audio)
- `gvfs` (e moduli opzionali: `gvfs-mtp`, `gvfs-gphoto2`)
