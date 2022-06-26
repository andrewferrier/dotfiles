for file in $HOME/.config/sh.d/*.sh; do
    source_sh $file
done

for file in $HOME/.config/sh-local.d/*.sh; do
    source_sh $file
done

for file in $HOME/.config/zsh.d/*.zsh; do
    source $file
done
