#
# source material: https://dev.to/ahmettkartal/display-current-git-branch-on-iterm2-3ko8
# 

COLOR_DEFAULT='%f'

COLOR_DIRECTORY='%F{197}'

COLOR_GIT='%F{39}'
COLOR_MODIFIED='%F{36}'
COLOR_AHEAD='%F{046}'
COLOR_BEHIND='%F{226}'
COLOR_NO_UPSTREAM='%F{196}'

get_git_branch() {
    git branch --show-current 2>/dev/null
}

get_uncommitted_file_count() {
    git status --short 2> /dev/null | wc -l | tr -d ' '
}

get_upstream() {
    git rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null
}

get_ahead_behind_counts() {
    git rev-list --count --left-right head...$(get_upstream) 2>/dev/null
}

format_git_prompt() {
    BRANCH=$(get_git_branch)
    if [[ "${BRANCH}" = "" ]] 
    then
        return
    fi

    OUTPUT="${BRANCH}"

    UNCOMMITED_FILE_COUNT=$(get_uncommitted_file_count)

    if [[ "${UNCOMMITED_FILE_COUNT}" != "0" ]]
    then
        OUTPUT="${OUTPUT} ${COLOR_MODIFIED}~${UNCOMMITED_FILE_COUNT}${COLOR_GIT}"
    fi

    UPSTREAM=$(get_upstream)

    if [[ "${UPSTREAM}" = "" ]]
    then
        OUTPUT="${OUTPUT} ${COLOR_NO_UPSTREAM}x${COLOR_GIT}"
    else
        AHEAD_BEHIND_COUNTS=$(get_ahead_behind_counts)
        AHEAD=$(echo ${AHEAD_BEHIND_COUNTS} | awk '{print $1}')
        if [[ "${AHEAD}" != "0" ]]
        then
            OUTPUT="${OUTPUT} ${COLOR_AHEAD}↑${AHEAD}${COLOR_GIT}"
        fi

        BEHIND=$(echo ${AHEAD_BEHIND_COUNTS} | awk '{print $2}')
        if [[ "${BEHIND}" != "0" ]]
        then
            OUTPUT="${OUTPUT} ${COLOR_BEHIND}↓${BEHIND}${COLOR_GIT}"
        fi
    fi

    echo "${COLOR_GIT}[${OUTPUT}]${COLOR_DEFAULT}"
}

setopt PROMPT_SUBST

export PROMPT='${COLOR_DIRECTORY}%d${COLOR_DEFAULT} $(format_git_prompt)%% '
