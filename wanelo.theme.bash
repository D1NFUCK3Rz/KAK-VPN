#!/usr/bin/env bash

SCM_THEME_PROMPT_DIRTY=" ${bold_red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${bold_red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

function prompt_command() {
    if [ $? -eq 0 ]; then
      status=O
    else
      status=X
    fi
    PS1="\n${bold_blue}$(usedata) ${reset_color} ${bold_cyan}\n$(echo -e "\033[38;5;255m\033[48;5;234m\033[1m═══════════════════ \033[0m") $(vpnstatus) ${green}\n ${bold_red}\w @\h ${reset_color}"
}

#THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$blue"}

PROMPT_COMMAND=prompt_command;
