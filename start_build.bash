#!/usr/bin/env bash

settings_path=https://raw.githubusercontent.com/Hayao0819/archlinux-lts-live/master/settings.bash


## 古いファイルの削除
# archlinux-builder.sh
if [[ -f /tmp/archlinux-builder.sh ]]; then
    rm /tmp/archlinux-builder.sh
fi
# settings.bash
if [[ -f /tmp/settings.bash ]]; then
    rm /tmp/settings.bash
fi


## 新しいファイルのダウンロード
wget -O /tmp/archlinux-builder.sh https://raw.githubusercontent.com/Hayao0819/archiso-helper/master/archlinux-builder.sh

if [[ -n $(printf "$settings_path" | grep -Eo "http(s?)://(\w|:|%|#|\$|&|\?|\(|\)|~|\.|=|\+|\-|/)+") ]]; then
    wget -O /tmp/settings.bash $settings_path
else
    if [[ -f $settings_path ]]; then
        cp $settings_path /tmp/settings.bash
    else
        echo "設定ファイルが存在しません" >&2
    fi
fi


## 権限付与と実行
chmod 775 /tmp/archlinux-builder.sh
sudo /tmp/archlinux-builder.sh /tmp/settings.bash

rm /tmp/archlinux-builder.sh
rm /tmp/settings.bash