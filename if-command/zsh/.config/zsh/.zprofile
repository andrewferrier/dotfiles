for file in $HOME/.config/sh-profile.d/*.sh; do
    source_sh $file
done

for file in $HOME/.config/zsh-profile.d/*.zsh; do
    source $file
done
