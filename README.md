# libreoffice-uninstaller

![Platform](https://img.shields.io/badge/platform-openSUSE%20Tumbleweed-73BA25)
![Shell](https://img.shields.io/badge/shell-bash%205%2B-4EAA25)
![License](https://img.shields.io/badge/license-MIT-green)

Complete LibreOffice uninstaller script for **openSUSE Tumbleweed** — removes packages, orphaned libraries, user configuration, and adds a zypper lock to prevent automatic reinstallation.

---

## Features

- Detects installed LibreOffice packages dynamically via `rpm -qa` — no hardcoded version strings
- Removes `libreoffice*` and `libobasis*` packages with dependency cleanup
- Removes orphaned LibreOffice libraries
- Removes user configuration directory (`~/.config/libreoffice`)
- Adds zypper locks on `libreoffice*` and `libobasis*` to prevent automatic reinstall
- Verifies removal and lists active locks at the end
- Root check with interactive sudo fallback

---

## Requirements

| Component | Version |
|-----------|---------|
| openSUSE | Tumbleweed (also compatible with Leap) |
| bash | 5+ |
| zypper | any |

---

## Usage

```bash
remove-libreoffice
```

The script will prompt for sudo if not already running as root.

---

## What it removes

| Step | Action |
|------|--------|
| 1 | All `libreoffice*` and `libobasis*` RPM packages |
| 2 | Orphaned LibreOffice libraries (`libabw`, `libcdr`, `libixion`, etc.) |
| 3 | User configuration directory (`~/.config/libreoffice`) |
| 4 | Adds zypper locks to prevent reinstall |
| 5 | Verifies no packages remain |

---

## After uninstall

To remove the zypper locks later (if you want to reinstall):

```bash
sudo zypper removelock 'libreoffice*'
sudo zypper removelock 'libobasis*'
```

---

## Contributing

Issues and pull requests are welcome.  
Please include your openSUSE version and `zypper --version` output in bug reports.

---

## License

MIT License — see [LICENSE](LICENSE) for details.
