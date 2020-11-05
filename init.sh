#!/bin/bash

function backup() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: backup() required one parameter\033[m"
        exit 1
    elif [[ -e "$1" ]] ;then
        mv "$1" "$1".bak
    fi
}

function makedir() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: makedir() required one parameter\033[m"
        exit 1
    elif [[ ! -d "$1" ]] ;then
        if [[ -e "$1" ]] ;then
            mv "$1" "$1".bak
        fi
        mkdir -p "$1"
    fi
}

function system_cfg() {
    # 开启ntp服务自动同步时间，并设置rtc让系统将主板时间当作本地时间（兼容windows）
    sudo timedatectl set-ntp 1 && timedatectl set-local-rtc 1
    sudo hwclock -w

    # 关闭蓝牙服务、打印服务，开启硬盘定时清理服务
    sudo systemctl disable --now bluetooth.service
    sudo systemctl disable --now org.cups.cupsd.service
    sudo systemctl enable --now fstrim.timer

    # 限制系统日志大小为100M
    sudo sed -i '/\[Journal\]/a\SystemMaxUse=100M' /etc/systemd/journald.conf

    # 笔记本电源，15%提醒电量过低，10%提醒即将耗尽电源，4%强制休眠(根据系统差异，也可能会关机)
    sudo sed -i '/^PercentageLow=/s/=.*$/=15/; /^PercentageCritical=/s/=.*$/=10/; /^PercentageAction=/s/=.*$/=3/' /etc/UPower/UPower.conf
}

function pacman_cfg() {
    # 修改pacman源为aliyun，有时候更新系统会把mirrorlist覆盖了，备份一下，当发现下载速度奇慢无比时检查此项
    echo 'Server = https://mirrors.aliyun.com/manjaro/stable/$repo/$arch' | sudo tee /etc/pacman.d/mirrorlist
    sudo cp /etc/pacman.d/mirrorlist{,.bak}
    # 或者直接修改/etc/pacman.conf可以解决此问题，就像init-for-myself.sh一样
    # sudo sed -i '/^Include = /s/^.*$/Server = https:\/\/mirrors.aliyun.com\/manjaro\/stable\/$repo\/$arch/' /etc/pacman.conf

    # pacman彩色输出
    sudo sed -i "/^#Color/s/#//" /etc/pacman.conf

    # 添加aliyun的archlinuxcn源
    if ! grep -q archlinuxcn /etc/pacman.conf ; then
        echo -e '[archlinuxcn]\nServer = https://mirrors.aliyun.com/archlinuxcn/$arch' | sudo tee -a /etc/pacman.conf
    fi

    # 更新系统，并安装一些下载工具
    sudo pacman -Syyu --noconfirm
    sudo pacman -S --noconfirm archlinuxcn-keyring yay aria2 uget

    # 启动定时清理软件包服务
    sudo systemctl enable --now paccache.timer
}

function dot_cfg() {
	rm -rf ~/.i3
	rm -rf ~/.Xmodmap
	ln -s "$dotfiles_dir"/.i3 ~/.i3
	ln -s "$dotfiles_dir"/.Xmodmap ~/.Xmodmap
	ln -s "$dotfiles_dir"/.xprofile ~/.xprofile
	ln -s "$dotfiles_dir"/.pam_environment ~/.pam_environment
}

function vim_cfg() {
    yay -S --noconfirm vim

	rm -rf ~/.vimrc
	ln -s "$dotfiles_dir"/.vimrc ~/.vimrc

}

function emacs_cfg() {
    yay -S --noconfirm emacs
	rm -rf ~/.emacs.d
	git clone https://gitee.com/e7a/emacsd.git ~/.emacs.d
}

function fish_cfg() {
    # 安装插件配置
    yay -S --noconfirm fish thefuck autojump
	chsh -s $(which fish)
}


function im_cfg() {
	sudo pacman -Rs $(pacman -Qsq fcitx) #remove fcitx4
	yay -S --noconfirm fcitx5-rime fcitx5-chinese-addons fcitx5-git fcitx5-gtk fcitx5-qt fcitx5-pinyin-zhwiki fcitx5-configtool
	makedir ~/.local/share/fcitx5/rime
	ln -s "$dotfiles_dir"/rime/default.custom.yaml ~/.local/share/fcitx5/rime/default.custom.yaml
	ln -s "$dotfiles_dir"/rime/double_pinyin_flypy.schema.yaml ~/.local/share/fcitx5/rime/double_pinyin_flypy.schema.yaml

	ln -s "$dotfiles_dir"/.xprofile ~/.xprofile
	ln -s "$dotfiles_dir"/.profile ~/.profile
}

function cli_cfg() {
    # 安装say, see, terminal-tmux.sh，以及用于say, see修改和查看的cheat-sheets
    cp -v bin/* ~/.local/bin

    # CLI工具
    yay -S --noconfirm htop iotop dstat cloc screenfetch figlet cmatrix
    pip install pip -U
    pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
}

function desktop_cfg() {
    # 桌面应用
    yay -S --noconfirm deepin.com.qq.office netease-cloud-music wps-office ttf-wps-fonts \
        flameshot firefox guake xfce4-terminal devilspie

    # 其它工具：多媒体播放、多媒体处理、多媒体录制、gif录制、字体修改
    yay -S --noconfirm vlc ffmpeg obs-studio peek fontforge

    # xfce4-terminal配置
    makedir ~/.config/xfce4/terminal
    backup ~/.config/xfce4/terminal/terminalrc
    cp -v xfce4-terminal/terminalrc ~/.config/xfce4/terminal/terminalrc

}

function main() {
	dotfiles_dir=$PWD
    export dotfiles_dir
    system_cfg
    pacman_cfg
	dot_cfg
    vim_cfg
    emacs_cfg
    fish_cfg
    im_cfg
    cli_cfg
    desktop_cfg

    echo -e '\e[32m=====> Done\e[m'
}

main
