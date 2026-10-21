#!/usr/bin/env bash
# Diff/sync managed dotfiles with ~/srv/dev/dotfiles
# Usage: zshrc-sync.sh [diff|sync|pull]  (default: diff)
#   diff  - show local vs repo differences
#   sync  - overwrite local with repo (backs up first)
#   pull  - overwrite repo with current local files

set -euo pipefail

CONFIG_REPO="${DOTFILES_REPO:-$HOME/srv/dev/dotfiles}"
CURSOR_USER="$HOME/Library/Application Support/Cursor/User"

# local_path|repo_path
pairs=(
  "$HOME/.zshrc|$CONFIG_REPO/mac/dotfiles/.zshrc"
  "$HOME/.zprofile|$CONFIG_REPO/mac/dotfiles/.zprofile"
  "$HOME/.tmux.conf|$CONFIG_REPO/mac/dotfiles/.tmux.conf"
  "$HOME/.gitignore_global|$CONFIG_REPO/mac/dotfiles/.gitignore_global"
  "$HOME/.config/starship.toml|$CONFIG_REPO/mac/bin/starship.toml"
  "$CURSOR_USER/settings.json|$CONFIG_REPO/cursor/settings.json"
  "$CURSOR_USER/keybindings.json|$CONFIG_REPO/cursor/keybindings.json"
)

cmd="${1:-diff}"

diff_one() {
  local local_f=$1 repo_f=$2
  if [[ ! -f "$repo_f" ]]; then
    echo "Repo missing: $repo_f"
    return
  fi
  if [[ ! -f "$local_f" ]]; then
    echo "Local missing: $local_f"
    return
  fi
  if diff -q "$local_f" "$repo_f" >/dev/null 2>&1; then
    echo "OK  $local_f"
  else
    echo "DIFF $local_f <-> $repo_f"
    diff -u "$local_f" "$repo_f" || true
    echo
  fi
}

sync_one() {
  local local_f=$1 repo_f=$2
  [[ -f "$repo_f" ]] || { echo "Repo missing: $repo_f"; return; }
  mkdir -p "$(dirname "$local_f")"
  if [[ -f "$local_f" ]]; then
    cp "$local_f" "$local_f.bak.$(date +%Y%m%d-%H%M%S)"
  fi
  cp "$repo_f" "$local_f"
  echo "repo -> $local_f"
}

pull_one() {
  local local_f=$1 repo_f=$2
  [[ -f "$local_f" ]] || { echo "Local missing: $local_f"; return; }
  mkdir -p "$(dirname "$repo_f")"
  cp "$local_f" "$repo_f"
  echo "$local_f -> repo"
}

case "$cmd" in
  diff|sync|pull)
    for pair in "${pairs[@]}"; do
      local_f="${pair%%|*}"
      repo_f="${pair##*|}"
      case "$cmd" in
        diff) diff_one "$local_f" "$repo_f" ;;
        sync) sync_one "$local_f" "$repo_f" ;;
        pull) pull_one "$local_f" "$repo_f" ;;
      esac
    done
    if [[ "$cmd" == "pull" ]] && command -v brew >/dev/null; then
      brew bundle dump --file="$CONFIG_REPO/mac/bin/Brewfile" --force
      echo "brew -> mac/bin/Brewfile"
    fi
    ;;
  *)
    echo "Usage: $0 [diff|sync|pull]"
    echo "  (no arg) diff  - show local vs repo"
    echo "  sync  - overwrite local with repo (backup first)"
    echo "  pull  - overwrite repo with local (+ brew dump)"
    exit 1
    ;;
esac
