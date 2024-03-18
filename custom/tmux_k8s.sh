
_kube_tmux_symbol() {
  if ((BASH_VERSINFO[0] >= 4)) && [[ $'\u2388 ' != "\\u2388 " ]]; then
    KUBE_TMUX_SYMBOL=$'\u2388 '
    KUBE_TMUX_SYMBOL_IMG=$'\u2638 '
  else
    KUBE_TMUX_SYMBOL=$'\xE2\x8E\x88 '
    KUBE_TMUX_SYMBOL_IMG=$'\xE2\x98\xB8 '
  fi


  echo "${KUBE_TMUX_SYMBOL}"
}

show_tmux_k8s() {
    local index=$1

    local icon="$(get_tmux_option "@catppuccin_tmux_k8s_icon"  "$(_kube_tmux_symbol)")"
    local divider="$(get_tmux_option "@catpuccin_tmux_k8s_divider" ":")"
    local command="$(get_tmux_option "@catppuccin_tmux_k8s_kube_binary" "kubectl")"
    local color="$(get_tmux_option "@catppuccin_tmux_k8s_color" "$thm_blue" )"
    local text_raw="#($command config current-context)"
    text_raw+="$divider"
    text_raw+="#($command config view --minify --output 'jsonpath={..namespace}')"
    local text="$(get_tmux_option "@catppuccin_tmux_k8s_text"  "$text_raw" )"
    local module=$(build_status_module "$index" "$icon" "$color" "$text" )

    echo "$module"
}
