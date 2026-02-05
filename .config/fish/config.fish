if status is-interactive
    alias code="cursor"
    alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
    alias tree="tree -C "
end

pyenv init - fish | source
# Created by `userpath` on 2026-01-29 13:15:06
set PATH $PATH /home/carl/.repobee/bin
set -gx REPOBEE_JUNIT4_CLASSPATH "/home/carl/.config/repobee/junit.jar:/home/carl/.config/repobee/hamcrest.jar"
