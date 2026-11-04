# Usage: github-clone <org>/<repo>
# Clones into $HOME/Code/github.com/<org>/<repo>; fails if it already exists.
github-clone() {
  if [[ $1 != */* || $# -ne 1 ]]; then
    echo "usage: github-clone <org>/<repo>" >&2
    return 2
  fi
  local dest="$HOME/Code/github.com/$1"
  if [[ -e $dest ]]; then
    echo "github-clone: $dest already exists" >&2
    return 1
  fi
  mkdir -p "${dest:h}" && git clone "git@github.com:$1.git" "$dest"
}
