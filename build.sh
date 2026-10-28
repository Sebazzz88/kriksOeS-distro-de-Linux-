#!/bin/bash
# Construye la ISO de kirksOeS. Correr como root dentro de Debian 13 (trixie).
# Más fácil: ./build-docker.sh (funciona en cualquier Linux con Docker).
set -euo pipefail
cd "$(dirname "$0")"

VERSION="${VERSION:-$(date +%Y.%m.%d)}"

apt-get update
apt-get install -y --no-install-recommends live-build debootstrap ca-certificates \
  xorriso squashfs-tools mtools dosfstools grub-pc-bin grub-efi-amd64-bin syslinux isolinux

lb clean --purge || true
rm -rf config/bootloaders .build cache chroot binary

lb config \
  --distribution trixie \
  --architectures amd64 \
  --archive-areas "main contrib non-free non-free-firmware" \
  --binary-images iso-hybrid \
  --bootloaders "grub-efi,syslinux" \
  --debian-installer none \
  --apt-recommends false \
  --memtest none \
  --firmware-binary true \
  --firmware-chroot true \
  --iso-application "kirksOeS" \
  --iso-publisher "Sebazzz88 - https://github.com/Sebazzz88/kriksOeS-distro-de-Linux-" \
  --iso-volume "kirksOeS" \
  --image-name "kirksOeS-${VERSION}" \
  --bootappend-live "boot=live components quiet splash hostname=kirksoes username=kirk user-fullname=kirk locales=es_ES.UTF-8 keyboard-layouts=latam timezone=America/Panama"

# Branding del menú de arranque (GRUB + syslinux)
cp -r /usr/share/live/build/bootloaders config/
for d in config/bootloaders/*/; do
  rm -f "$d"splash.svg.in "$d"splash.svg
  cp branding/splash.png "$d"splash.png
done
grep -rl "Live system" config/bootloaders 2>/dev/null | xargs -r sed -i 's/Live system/kirksOeS Live/g'

lb build

mkdir -p out
mv ./*.iso out/
cd out && sha256sum ./*.iso > SHA256SUMS && ls -lh
