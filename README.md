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
- **Terminal**: `ghostty`
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
- **Do Not Disturb**:
  - Icona 󰂚 (notifiche attive) / 󰂛 (DND attivo)
  - Click per toggle modalità DND di mako
  - Tooltip mostra stato corrente
- **Audio**:
  - Icona volume dinamica con stato mute
  - Click su icona: mute/unmute
  - Click su percentuale: apre `pwvucontrol`
  - Scroll su icona: +/- 5% volume
- **Data e Ora**: giorno settimana, giorno mese, mese abbreviato (es. "Gio 09 Ott") e orario HH:MM
- **Power Menu**:
  - Icona ⏻ per aprire menu di sistema (wofi)
  - Opzioni: Spegni, Riavvia, Sospendi, Blocca schermo
  - Script: `~/.config/eww/scripts/powermenu.sh`
  - Comandi: `systemctl poweroff/reboot/suspend`, `hyprlock`

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

## Wallpaper

### Autostart (autostart.conf)
```bash
exec-once = hyprpaper
```

### Configurazione
File: `~/.config/hypr/hyprpaper.conf`
- Sfondo corrente: `dv_iwantyou.jpg` da `/mnt/SEGATE2TB/Immagini/Backgrounds/`
- Applicato su entrambi i monitor (DP-1 e DP-3)

Gli sfondi random predefiniti di Hyprland sono disabilitati (`force_default_wallpaper = 0` e `disable_hyprland_logo = true` in `hyprland.conf`).

## Autenticazione Privilegi (Polkit Agent)

### Autostart (autostart.conf)
```bash
exec-once = /usr/lib/hyprpolkitagent/hyprpolkitagent
```

Hyprpolkitagent è l'agente di autenticazione PolicyKit per Hyprland. Permette alle applicazioni di richiedere privilegi amministrativi tramite una finestra di dialogo grafica. Necessario per operazioni che richiedono autenticazione root come:
- Aggiornamenti di sistema (pacman, pamac, ecc.)
- Modifiche alle impostazioni di sistema
- Mount/unmount di dispositivi
- Gestione pacchetti e configurazioni privilegiate

## Notifiche

### Autostart (autostart.conf)
```bash
exec-once = mako
```

Daemon di notifiche per Wayland. Gestisce le notifiche desktop per applicazioni e sistema.

## Blocco Schermo

### Configurazione
File: `~/.config/hypr/hyprlock.conf`
- Lockscreen per Hyprland con blur dello screenshot corrente
- Input field per password
- Display di ora, data e username
- Attivabile tramite power menu eww o comando `hyprlock`

## Pacchetti Richiesti
- `gnome-keyring`
- `libsecret`
- `libgnome-keyring`
- `eww`
- `pwvucontrol` (controllo audio)
- `wpctl` (controllo volume, parte di `wireplumber`)
- `gvfs` (e moduli opzionali: `gvfs-mtp`, `gvfs-gphoto2`)
- `mako` (notifiche Wayland)
- `jq` (parsing JSON per eww workspaces)
- `hyprpaper` (gestione wallpaper)
- `hyprlock` (blocco schermo Hyprland)
- `hyprpolkitagent` (agente PolicyKit per autenticazione privilegi)
