callCounter=0
invocationRecorder() {
  local in_line_count=0
  declare -a in_lines
  while read -t0.05; do
    in_lines[in_line_count]="$REPLY"
    in_line_count=$(expr ${in_line_count} + 1)
  done
  callCounter=$(expr ${callCounter} + 1)
  echo "[$callCounter] $@" > /dev/fd/2
  if [ ${in_line_count} -gt 0 ]; then
    echo "[$callCounter received] input:" > /dev/fd/2
    printf '%s\n' "${in_lines[@]}" > /dev/fd/2
    echo "[$callCounter end received]" > /dev/fd/2
  fi
  echo $PATH > /dev/fd/2
}