# dotfiles

Personal macOS setup, shell config, editor settings, and utility scripts.

## Layout

| Path | What |
|------|------|
| `mac/dotfiles/` | `.zshrc`, `.zprofile`, `.tmux.conf`, `.gitconfig`, `.ssh/config`, … |
| `mac/bin/` | `Brewfile`, `starship.toml`, machine `setup.sh` |
| `cursor/` | Cursor `settings.json` + `keybindings.json` |
| `vscode/` | VS Code extensions installer + mirrored settings |
| `intellij/` | JetBrains options / keymap / Prettier codestyle |
| `docker/`, `deploy/`, `aws/` | helper compose files and scripts |

## Sync

Live home configs ↔ this repo:

```bash
./mac/zshrc-sync.sh        # diff
./mac/zshrc-sync.sh pull   # home → repo (+ brew dump)
./mac/zshrc-sync.sh sync   # repo → home (backs up first)
```

## License

MIT — see [LICENSE.md](LICENSE.md).
