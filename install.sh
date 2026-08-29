#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd -P)
config_home=${XDG_CONFIG_HOME:-"$HOME/.config"}
backup_date=$(date +%F)

tool_labels=(
    "Bash and Readline"
    "Zsh"
    "Git"
    "npm"
    "tmux"
    "Neovim, Vim, and Coc"
    "Zed"
    "Sway desktop (requires sudo for key remapping)"
    "Foot"
    "Code OSS"
    "Lazygit"
    "Ranger"
    "Vifm"
    "Desktop appearance"
    "Desktop defaults"
    "libfm"
)

declare -A selected_tools=()
declare -a target_tools=()
declare -a target_sources=()
declare -a target_paths=()
declare -a target_kinds=()
declare -a target_actions=()
declare -a target_backups=()

printf 'Select configurations to install:\n\n'
for index in "${!tool_labels[@]}"; do
    printf '  %2d. %s\n' "$((index + 1))" "${tool_labels[$index]}"
done
printf '\nEnter comma-separated numbers or "all". An empty response aborts.\n> '
IFS= read -r selection

selection=${selection//[[:space:]]/}
if [[ -z "$selection" ]]; then
    printf 'Installation aborted.\n'
    exit 0
fi

if [[ "$selection" == "all" ]]; then
    for index in "${!tool_labels[@]}"; do
        selected_tools[$((index + 1))]=1
    done
else
    IFS=',' read -r -a choices <<< "$selection"
    for choice in "${choices[@]}"; do
        if [[ ! "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#tool_labels[@]})); then
            printf 'Invalid selection: %s\n' "$choice" >&2
            exit 1
        fi
        selected_tools[$choice]=1
    done
fi

is_selected() {
    [[ -n "${selected_tools[$1]:-}" ]]
}

add_target() {
    local tool=$1
    local source=$2
    local target=$3
    local kind=${4:-link}

    target_tools+=("$tool")
    target_sources+=("$repo_dir/$source")
    target_paths+=("$target")
    target_kinds+=("$kind")
}

if is_selected 1; then
    add_target 1 .bashrc "$HOME/.bashrc"
    add_target 1 .bash_profile "$HOME/.bash_profile"
    add_target 1 .inputrc "$HOME/.inputrc"
fi

if is_selected 2; then
    add_target 2 zshrc "$config_home/zsh"
    add_target 2 zshrc/.zshrc "$HOME/.zshrc"
fi

if is_selected 3; then
    add_target 3 .gitconfig "$HOME/.gitconfig"
    add_target 3 .gitignore-global "$HOME/.gitignore-global"
fi

if is_selected 4; then
    add_target 4 .npmrc "$HOME/.npmrc"
fi

if is_selected 5; then
    add_target 5 .tmux.conf "$HOME/.tmux.conf"
fi

if is_selected 6; then
    add_target 6 vim-config/.config/nvim "$config_home/nvim"
    add_target 6 vim-config/.config/nvim "$HOME/.vim"
    add_target 6 vim-config/.config/nvim/init.lua "$HOME/.vimrc"
    add_target 6 vim-config/.config/coc/extensions/package.json "$config_home/coc/extensions/package.json"
fi

if is_selected 7; then
    add_target 7 .config/zed/settings.json "$config_home/zed/settings.json"
    add_target 7 .config/zed/keymap.json "$config_home/zed/keymap.json"
    add_target 7 .config/zed/themes/nwsome.json "$config_home/zed/themes/nwsome.json"
fi

if is_selected 8; then
    add_target 8 swaywm-config/sway "$config_home/sway" sway
    add_target 8 swaywm-config/waybar "$config_home/waybar" sway
    add_target 8 swaywm-config/swappy "$config_home/swappy" sway
    add_target 8 swaywm-config/sworkstyle/config "$config_home/sworkstyle/config" sway
    add_target 8 swaywm-config/keyd/default.conf /etc/keyd/default.conf system
fi

if is_selected 9; then
    add_target 9 .config/foot "$config_home/foot"
fi

if is_selected 10; then
    add_target 10 ".config/Code - OSS/User/settings.json" "$config_home/Code - OSS/User/settings.json"
fi

if is_selected 11; then
    add_target 11 .config/lazygit/config.yml "$config_home/lazygit/config.yml"
fi

if is_selected 12; then
    add_target 12 .config/ranger "$config_home/ranger"
fi

if is_selected 13; then
    add_target 13 .config/vifm/vifmrc "$config_home/vifm/vifmrc"
    add_target 13 .config/vifm/colors "$config_home/vifm/colors"
fi

if is_selected 14; then
    add_target 14 .config/fontconfig/fonts.conf "$config_home/fontconfig/fonts.conf"
    add_target 14 .config/gtk-2.0/gtkfilechooser.ini "$config_home/gtk-2.0/gtkfilechooser.ini"
    add_target 14 .config/gtk-3.0/settings.ini "$config_home/gtk-3.0/settings.ini"
    add_target 14 .gtkrc-2.0 "$HOME/.gtkrc-2.0"
    add_target 14 .icons/default/index.theme "$HOME/.icons/default/index.theme"
fi

if is_selected 15; then
    add_target 15 .config/mimeapps.list "$config_home/mimeapps.list"
    add_target 15 .config/user-dirs.dirs "$config_home/user-dirs.dirs"
    add_target 15 .config/user-dirs.locale "$config_home/user-dirs.locale"
fi

if is_selected 16; then
    add_target 16 .config/libfm/libfm.conf "$config_home/libfm/libfm.conf"
fi

if is_selected 8; then
    for command in keyd sudo systemctl; do
        if ! command -v "$command" >/dev/null 2>&1; then
            printf 'Missing command required by the Sway installer: %s\n' "$command" >&2
            exit 1
        fi
    done
fi

target_is_current() {
    local source=$1
    local target=$2
    local kind=$3

    if [[ "$kind" == "system" ]]; then
        [[ -f "$target" ]] && cmp -s -- "$source" "$target"
        return
    fi

    [[ -L "$target" ]] && [[ "$(readlink -f -- "$target" 2>/dev/null || true)" == "$source" ]]
}

check_parent() {
    local parent
    parent=$(dirname -- "$1")

    while [[ ! -e "$parent" && ! -L "$parent" ]]; do
        parent=$(dirname -- "$parent")
    done

    if [[ ! -d "$parent" ]]; then
        printf 'Cannot install below non-directory path: %s\n' "$parent" >&2
        exit 1
    fi
}

printf '\nPreflight\n'
for index in "${!target_paths[@]}"; do
    source=${target_sources[$index]}
    target=${target_paths[$index]}
    kind=${target_kinds[$index]}

    if [[ ! -e "$source" ]]; then
        printf 'Missing repository source: %s\n' "$source" >&2
        exit 1
    fi

    check_parent "$target"
    backup="${target}_bkp_${backup_date}"
    target_backups+=("$backup")

    if target_is_current "$source" "$target" "$kind"; then
        target_actions+=(keep)
        printf '  installed  %s\n' "$target"
        continue
    fi

    if [[ ! -e "$target" && ! -L "$target" ]]; then
        target_actions+=(install)
        printf '  new        %s\n' "$target"
        continue
    fi

    if [[ -e "$backup" || -L "$backup" ]]; then
        printf 'Backup path already exists: %s\n' "$backup" >&2
        exit 1
    fi

    if [[ "$kind" == "sway" || "$kind" == "system" ]]; then
        printf '\nConflict: %s\nSkipping this target will skip the entire Sway installation.\n' "$target"
    else
        printf '\nConflict: %s\n' "$target"
    fi
    printf 'Choose [b]ack up and replace, [r]eplace without backup, [s]kip, or [a]bort: '
    IFS= read -r response
    case "$response" in
        b|B) target_actions+=(backup) ;;
        r|R) target_actions+=(replace) ;;
        s|S) target_actions+=(skip) ;;
        a|A)
            printf 'Installation aborted. No changes were made.\n'
            exit 0
            ;;
        *)
            printf 'Invalid conflict choice. No changes were made.\n' >&2
            exit 1
            ;;
    esac
done

sway_skipped=false
if is_selected 8; then
    for index in "${!target_paths[@]}"; do
        if [[ "${target_tools[$index]}" == 8 && "${target_actions[$index]}" == skip ]]; then
            sway_skipped=true
            break
        fi
    done
fi

printf '\nPlan\n'
for index in "${!target_paths[@]}"; do
    tool=${target_tools[$index]}
    action=${target_actions[$index]}
    target=${target_paths[$index]}

    if [[ "$tool" == 8 && "$sway_skipped" == true ]]; then
        printf '  skip       %s\n' "$target"
    else
        printf '  %-10s %s\n' "$action" "$target"
    fi
done

if is_selected 8 && [[ "$sway_skipped" == false ]]; then
    printf '\nSway installs /etc/keyd/default.conf and enables the keyd service.\n'
    printf 'Validating sudo access before making changes...\n'
    sudo -v
fi

remove_target() {
    local target=$1
    local privileged=${2:-false}
    local -a command=(rm)

    if [[ -d "$target" && ! -L "$target" ]]; then
        command+=(-r)
    fi
    command+=(-- "$target")

    if [[ "$privileged" == true ]]; then
        sudo "${command[@]}"
    else
        "${command[@]}"
    fi
}

prepare_target() {
    local index=$1
    local target=${target_paths[$index]}
    local action=${target_actions[$index]}
    local backup=${target_backups[$index]}
    local privileged=false

    if [[ "${target_kinds[$index]}" == "system" ]]; then
        privileged=true
    fi

    case "$action" in
        backup)
            if [[ "$privileged" == true ]]; then
                sudo mv -- "$target" "$backup"
            else
                mv -- "$target" "$backup"
            fi
            ;;
        replace)
            remove_target "$target" "$privileged"
            ;;
    esac
}

if is_selected 8 && [[ "$sway_skipped" == false ]]; then
    for index in "${!target_paths[@]}"; do
        if [[ "${target_tools[$index]}" == 8 ]]; then
            prepare_target "$index"
        fi
    done
    "$repo_dir/swaywm-config/install.sh"
fi

for index in "${!target_paths[@]}"; do
    if [[ "${target_tools[$index]}" == 8 ]]; then
        continue
    fi

    action=${target_actions[$index]}
    if [[ "$action" == keep || "$action" == skip ]]; then
        continue
    fi

    prepare_target "$index"
    target=${target_paths[$index]}
    source=${target_sources[$index]}
    mkdir -p -- "$(dirname -- "$target")"
    ln -s -- "$source" "$target"
done

printf '\nInstallation complete.\n'
