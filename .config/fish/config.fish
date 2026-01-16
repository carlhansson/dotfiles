if status is-interactive
    alias code="cursor"
    alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
end

pyenv init - fish | source