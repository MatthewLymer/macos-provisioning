#
# source material: https://dev.to/ahmettkartal/display-current-git-branch-on-iterm2-3ko8
# 

COLOR_DEFAULT='%f'
COLOR_DIRECTORY='%F{197}'
COLOR_GIT='%F{39}'

parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/\1/p'
}

parse_git_status() {
    git status --short 2> /dev/null | wc -l | tr -d ' '
}

format_git_prompt() {
    BRANCH=$(parse_git_branch)
    if [[ "${BRANCH}" = "" ]] 
    then
        return
    fi

    STATUS=$(parse_git_status)

    if [[ "${STATUS}" = "0" ]]
    then
        echo "[${BRANCH}] "
    else
        echo "[${BRANCH} Δ ${STATUS}]"
    fi
}

setopt PROMPT_SUBST

export PROMPT='${COLOR_DIRECTORY}%d ${COLOR_GIT}$(format_git_prompt)${COLOR_DEFAULT}%% '
