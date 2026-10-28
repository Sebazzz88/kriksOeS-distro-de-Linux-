<p align="center">
  <img src="branding/logo.png" width="220" alt="kirksOeS">
</p>

<h1 align="center">kirksOeS</h1>
<p align="center">Distro live de Linux para pentesting y CTF · basada en Debian 13 (trixie) · XFCE</p>

<p align="center">
  <a href="https://github.com/Sebazzz88/kriksOeS-distro-de-Linux-/releases/latest"><b>⬇ Descargar la última ISO</b></a>
</p>

---

## Cómo usarla

1. **Descarga** el `.iso` desde [Releases](https://github.com/Sebazzz88/kriksOeS-distro-de-Linux-/releases/latest).
2. **Grábala en una USB** (mínimo 4 GB, se borra todo lo que tenga):
   - Windows: [Rufus](https://rufus.ie) → si pregunta, elige **modo DD**.
   - Windows / Mac / Linux: [balenaEtcher](https://etcher.balena.io).
   - Varias ISOs en una USB: [Ventoy](https://www.ventoy.net) (solo copias el `.iso`).
   - Linux por terminal: `sudo dd if=kirksOeS-*.iso of=/dev/sdX bs=4M status=progress && sync`
3. **Arranca desde la USB** (F12, F11, F8 o Esc al encender, según la marca de la PC).
   Funciona con BIOS y UEFI. Si no arranca, desactiva *Secure Boot*.

**Usuario:** `kirk` · **Contraseña:** `live` (tiene `sudo`).

## Usarla en VirtualBox

1. **Nueva** → Nombre: `kirksOeS` · ISO: el `.iso` descargado · Tipo: **Linux** · Versión: **Debian (64-bit)**.
   Marca **"Omitir instalación desatendida"**.
2. **Memoria:** 4096 MB (mínimo 2048) · **CPUs:** 2 o más.
3. **Disco:** no hace falta, es live. Si quieres, deja el que propone.
4. **Configuración → Pantalla:** controlador **VMSVGA**, 128 MB de video.
5. **Inicia** la VM.

Con el controlador VMSVGA la pantalla se ve bien de entrada. Para que se **ajuste sola** al tamaño de la ventana y tener portapapeles compartido, dentro de la VM ve a *Dispositivos → Insertar imagen de CD de las «Guest Additions»* y ejecútalas una vez.

Para la tarjeta Wi-Fi o adaptadores USB (aircrack-ng), conecta el adaptador en *Dispositivos → USB* (requiere el Extension Pack de VirtualBox).

También trae soporte para **VMware** y **QEMU/KVM**.

## Qué trae

| Categoría | Herramientas |
|---|---|
| Recon / red | nmap, masscan, wireshark, tshark, tcpdump, arp-scan, netdiscover, netcat, socat |
| Web | sqlmap, ffuf, gobuster, nikto, wfuzz, dirb, firefox |
| Passwords | john, hashcat, hydra, crunch, hashid |
| Wireless | aircrack-ng, reaver |
| Forense / CTF | binwalk, foremost, exiftool, steghide, gdb, radare2, ltrace, strace |
| Dev | git, python3, pip, vim, build-essential |

Teclado en español latino y zona horaria de Panamá por defecto.

## Compilar tú mismo

Con Docker en cualquier Linux:

```bash
git clone https://github.com/Sebazzz88/kriksOeS-distro-de-Linux-.git
cd kriksOeS-distro-de-Linux-
sudo ./build-docker.sh      # la ISO queda en ./out/
```

O en Debian 13 directo: `sudo ./build.sh`.

### Publicar una versión nueva

GitHub Actions compila y sube la ISO solo:

```bash
git tag v1.0 && git push origin v1.0
```

También se puede lanzar a mano en **Actions → Build ISO → Run workflow**.

## Estructura

```
build.sh                 # script de build (live-build)
build-docker.sh          # build dentro de Docker
branding/                # logo, wallpaper, splash
config/package-lists/    # paquetes que trae la ISO
config/hooks/live/       # personalización durante el build
config/includes.chroot/  # archivos que se copian al sistema
.github/workflows/       # CI que genera la ISO
```

> Úsala solo en sistemas propios o con permiso.
