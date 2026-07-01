if status is-interactive
    alias code="cursor"
    alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
    alias tree="tree -C "
end
# Default Editor/Diff (for paru, pacdiff, git, etc.)
set -gx EDITOR "nvim"
set -gx VISUAL "nvim"
set -gx DIFFPROG "nvim -d"
# Repobee
set -gx REPOBEE_JUNIT4_CLASSPATH "/home/carl/.config/repobee/junit-4.13.2.jar:/home/carl/.config/repobee/hamcrest-core-1.3.jar"
