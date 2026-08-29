# Dotfiles

Personal configuration for shells, editors, terminal tools, and the Sway desktop.

Zsh, Vim, and Sway keep their own Git histories under `zshrc/`, `vim-config/`, and
`swaywm-config/`. They remain usable as standalone repositories.

## Install

Run:

```sh
./install.sh
```

The installer first asks which configurations to install. It then inspects only
their target paths and resolves every conflict before changing anything. Existing
paths can be backed up beside the original as `<name>_bkp_<YYYY-MM-DD>`, replaced,
or skipped. An existing backup path aborts the installation.

Selecting Sway requires sudo because its existing installer copies the keyd
configuration to `/etc`, enables the keyd service, and reloads it. The installer
validates sudo access before making any changes.

Sway's installer is all-or-nothing. Skipping any Sway-owned conflict skips the
whole Sway installation.

The installer links configuration files only. It does not install applications or
packages.

## Component repositories

Changes under a component directory can be pushed back to its standalone repository:

```sh
git subtree push --prefix=zshrc git@github.com:none23/zshrc master
git subtree push --prefix=vim-config git@github.com:none23/vim-config master
git subtree push --prefix=swaywm-config git@github.com:none23/swaywm-config.git main
```

Pull standalone changes into this repository with the matching command:

```sh
git subtree pull --prefix=zshrc git@github.com:none23/zshrc master
git subtree pull --prefix=vim-config git@github.com:none23/vim-config master
git subtree pull --prefix=swaywm-config git@github.com:none23/swaywm-config.git main
```

Do not add `--squash`; the component histories are intentionally preserved.
