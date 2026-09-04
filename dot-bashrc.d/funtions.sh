open-from-term ()  {
  command -v xdg-open >/dev/null 2>&2 || {
    printf 'xdg-open not found\n' >&2
    return 1
  }
  [ -z "$1" ] && {
    printf 'no arguments given\n' >&2
    return 1
  }
  [ -e "$1" ] || {
    printf 'file "%s" does not exist\n' "$1" >&2
    return 1
  }
  printf 'Opening file "%s"...' "$1"
  xdg-open "$1" >/dev/null 2>&1 & disown
}
