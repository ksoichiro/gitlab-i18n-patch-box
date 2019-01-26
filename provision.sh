#!/usr/bin/env bash

echo "Updating apt-get..."
apt-get update -qq > /dev/null 2>&1
apt-get install -y vim-gnome > /dev/null 2>&1
apt-get install -y language-pack-ja > /dev/null 2>&1
dpkg-reconfigure locales > /dev/null 2>&1
echo "set encoding=utf-8" >> ~vagrant/.vimrc
echo "set fileencodings=utf-8,iso-2022-jp,sjis" >> ~vagrant/.vimrc
chown vagrant:vagrant ~vagrant/.vimrc
cp ~vagrant/.vimrc ~root/

echo "Installing patch..."
apt-get install -y patch > /dev/null 2>&1

echo 'PS1='\''${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;35m\]${GITLAB_VERSION}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '\''' >> ~vagrant/.bashrc
echo 'PS1='\''${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;35m\]${GITLAB_VERSION}\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '\''' >> ~root/.bashrc

echo "Cleaning..."

umount /vagrant

apt-get clean -y
apt-get autoclean -y

rm -rf /usr/share/doc
rm -rf /usr/src/linux-headers-*

rm -rf /usr/share/locale/{af,am,ar,as,ast,az,bal,be,bg,bn,bn_IN,br,bs,byn,ca,cr,cs,csb,cy,da,de,de_AT,dz,el,en_AU,en_CA,eo,es,et,et_EE,eu,fa,fi,fo,fr,fur,ga,gez,gl,gu,haw,he,hi,hr,hu,hy,id,is,it,ka,kk,km,kn,ko,kok,ku,ky,lg,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,nb,ne,nl,nn,no,nso,oc,or,pa,pl,ps,pt,pt_BR,qu,ro,ru,rw,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,tt,ur,urd,ve,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu,an,ary,bo,ca@valencia,ckb,crh,cv,dv,en_GB,fa_AF,fil,frp,fy,gd,gv,ht,jv,lb,ln,lo,mhr,my,nds,os,pam,sc,sd,shn,trv,ug,uk,uz,vec}

find /var/cache -type f -exec rm -rf {} \;
find /var/log -type f | while read f; do echo -ne '' > $f; done

sh -c "dd if=/dev/zero of=/EMPTY bs=1M > /dev/null 2>&1; true"
rm -f /EMPTY

[ -f ~/.bash_history ] && rm ~/.bash_history
[ -f ~vagrant/.bash_history ] && rm ~vagrant/.bash_history
