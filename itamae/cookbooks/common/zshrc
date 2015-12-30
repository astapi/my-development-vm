bindkey '^r' peco-select-history
# C-q -> find
function peco-find-file() {
    if git rev-parse 2> /dev/null; then
        source_files=$(git ls-files)
    else
        source_files=$(find . -type f)
    fi
    selected_files=$(echo $source_files | peco --prompt "[find file]")
    result=''
    for file in $selected_files; do
        result="${result}$(echo $file | tr '\n' ' ')"
    done
    BUFFER="${BUFFER}${result}"
    CURSOR=$#BUFFER
    zle redisplay
}
zle -N peco-find-file
bindkey '^f' peco-find-file
function peco-git-diff() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    local target=$(git diff --stat $1 | peco | awk '{print $1}')
    if [[ -n $target ]]; then
      vimdiff <(git show $1:$target) $target
    fi
  fi
}
