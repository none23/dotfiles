#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}

for command in keyd sudo systemctl; do
    if ! command -v "$command" >/dev/null 2>&1; then
        printf 'Missing required command: %s\n' "$command" >&2
        exit 1
    fi
done

link_config() {
    relative_path=$1
    source_path=$repo_dir/$relative_path
    target_path=$config_home/$relative_path

    mkdir -p "$(dirname -- "$target_path")"

    if [ -L "$target_path" ] && [ "$(readlink -f -- "$target_path")" = "$source_path" ]; then
        return
    fi

    if [ -e "$target_path" ] || [ -L "$target_path" ]; then
        printf 'Refusing to replace existing path: %s\n' "$target_path" >&2
        exit 1
    fi

    ln -s "$source_path" "$target_path"
}

link_config sway
link_config waybar
link_config swappy
link_config sworkstyle/config

sudo install -Dm0644 "$repo_dir/keyd/default.conf" /etc/keyd/default.conf
sudo systemctl enable --now keyd
sudo keyd reload

printf 'Configuration installed. Reload Sway with: swaymsg reload\n'
