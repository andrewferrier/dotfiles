for file in $HOME/.config/sh.d/*.sh; do
    source_sh $file
done

if [ -L "${HOME}"/.config/sh-local.d ]; then
    for file in $HOME/.config/sh-local.d/*.sh; do
        source_sh $file
    done
fi

for file in $HOME/.config/zsh.d/*.zsh; do
    source $file
done
