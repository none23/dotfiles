# Sway configuration

Personal configuration for Sway, Waybar, Swappy, and Sworkstyle on Arch Linux.

## Fresh installation

These instructions start with an Arch Linux installation that does not already have Sway
configured.

### 1. Install Sway and the supporting applications

```sh
sudo pacman -S --needed \
  git \
  sway swaybg swayidle swaylock \
  waybar foot rofi mako \
  grim slurp swappy wl-clipboard cliphist \
  keyd \
  brightnessctl playerctl pulsemixer libpulse wob wlsunset \
  jq bc python python-i3ipc python-gobject gtk-layer-shell \
  libnotify inotify-tools polkit-gnome xdg-user-dirs \
  sworkstyle swayr swaycwd \
  breeze-cursors ttf-roboto ttf-jetbrains-mono-nerd
```

The theme names are defined in `sway/theme`. Install the corresponding Matcha, Papirus Maia, and
Kvantum themes, or change those values to themes already installed on the system.

Optional integrations are enabled automatically when their commands are installed. They include
`autotiling-rs`, `bluetuith`, `dex`, `github-cli`, `kanshi`, `network-manager-applet`, and
`poweralertd`.

### 2. Clone and install the configuration

The repository can live anywhere in the home directory because the installer creates absolute
links:

```sh
git clone https://github.com/none23/swaywm-config.git ~/swaywm-config
cd ~/swaywm-config
./install.sh
```

The installer:

- Links `sway`, `waybar`, and `swappy` into `$XDG_CONFIG_HOME` (or `~/.config`).
- Links the Sworkstyle config without replacing the entire Sworkstyle directory.
- Installs `keyd/default.conf` as `/etc/keyd/default.conf` and enables `keyd`.

It refuses to replace existing user config paths that do not already point into this repository.
Move or back up those paths before running the installer again.

### 3. Start Sway

Select Sway from a display manager, or start it from a TTY:

```sh
sway
```

After changing an existing installation, reload the running session with:

```sh
swaymsg reload
```

## Keyboard mapping

The keyboard behavior depends on the system-level `keyd` configuration shipped in this repository:

- Caps Lock emits Escape.
- The physical Escape key emits F19.
- `$mod+F19` kills the focused Sway client.

F19 is used as a sentinel because it is not present on the keyboards this configuration targets.
Without `keyd`, Caps Lock remains Caps Lock and the physical Escape key cannot trigger the F19
binding.
