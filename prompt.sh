clean() {
  printf "\[\e[0m\]"
}

last_command_status() {
  if [ $1 -ne 0 ]; then printf "\[\e[31m\]($1)"; fi
}

host_info() {
  if [ -n "${SSH_CONNECTION}" ]; then
    echo -n "\[\e[95m\][\[\e[0m\]\h\[\e[95m\]]"
  fi
}

show_git_info() {
  git_toplevel="$(dirname $(git rev-parse --show-toplevel))"
  git_relative_path="${PWD##$git_toplevel/}"

  printf "${git_relative_path//$USER/\~}"

  git_porcelain="$(git status --porcelain --branch --ahead-behind)"
  git_stash_count="$(git stash list | grep "" -c)"

  printf " \[\e[96m\]${1} "
  printf "\[\e[92m\]$(printf "${git_porcelain}" | grep -c '^A')|"
  printf "\[\e[92m\]$(printf "${git_porcelain}" | grep -c '^R')|"
  printf "\[\e[92m\]$(printf "${git_porcelain}" | grep -c '^M')|"
  printf "\[\e[91m\]$(printf "${git_porcelain}" | grep -c '^D')|"
  printf "\[\e[97m\]$(printf "${git_porcelain}" | grep -c '^.M')|"
  printf "\[\e[94m\]$(printf "${git_porcelain}" | grep -c '^??')|"
  printf "\[\e[91m\]$(printf "${git_porcelain}" | grep -c '^.D')"

  ahead=$(printf "${git_porcelain}" | awk '/ahead/ {print substr($4,1,length($4)-1)}')
  behind=$(printf "${git_porcelain}" | awk '/behind/ {print substr($4,1,length($4)-1)}')

  if [ "${ahead}" ] || [ "${behind}" ]; then
    printf " "
    if [ "${ahead}" ] && [ "${ahead}" -gt 0 ]; then
      printf "\[\e[95m\]${ahead}↑"
    fi
    if [ "${behind}" ] && [ "${behind}" -gt 0 ]; then
      printf "\[\e[95m\]${behind}↓"
    fi
  fi

  if [ "${git_stash_count}" -gt 0 ]; then
    echo -n " %{%F{blue}%}${git_stash_count}✗"
  fi
}

current_dir_info() {
  printf '\[\e[34m\]'
  b=$(git branch --show-current 2>/dev/null || printf "")
  if [ "${b}" = "" ]; then printf "\w"; else show_git_info "${b}"; fi
}

prompt_char() {
  if [ $(id -u) -eq 0 ]; then printf "#"; else printf ">"; fi
}

my_prompt() {
  last_exit_code=$?
  clean
  last_command_status $last_exit_code
  clean
  host_info
  clean
  printf " "
  current_dir_info
  clean
  printf " "
  prompt_char
  clean
  printf " "
}

export PS1=$(my_prompt)
