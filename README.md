# libreoffice-uninstaller

![Platform](https://img.shields.io/badge/platform-openSUSE%20Tumbleweed-73BA25)
![Shell](https://img.shields.io/badge/shell-bash%205%2B-4EAA25)
![License](https://img.shields.io/badge/license-MIT-green)
![Dynamic](https://img.shields.io/badge/detection-dynamic%20rpm--qa-blue)
![Locks](https://img.shields.io/badge/zypper-locked%20after%20removal-orange)

One-command, complete LibreOffice removal for **openSUSE Tumbleweed** — no hardcoded version strings, no leftover libraries, no accidental reinstall via zypper.

---

## The problem with manual removal

Uninstalling LibreOffice on openSUSE is not just `zypper rm libreoffice`. It leaves behind:

- Dozens of `libobasis*` packages not caught by a simple glob
- Orphaned shared libraries (`libabw`, `libcdr`, `libixion`, `liborcus`, etc.)
- User configuration in `~/.config/libreoffice`
- No lock — zypper will silently reinstall LibreOffice as a dependency the next time another package requests it

This script handles all of it in a single run.

---

## What it does

| Step | Action |
|------|--------|
| 1 | Detects all `libreoffice*` and `libobasis*` packages via `rpm -qa` — version-independent |
| 2 | Removes them with full dependency cleanup (`--clean-deps`) |
| 3 | Removes orphaned LibreOffice libraries (`libabw`, `libcdr`, `libixion`, `liborcus`, etc.) |
| 4 | Removes user configuration directory (`~/.config/libreoffice`) |
| 5 | Adds zypper locks on `libreoffice*` and `libobasis*` to block automatic reinstall |
| 6 | Verifies no packages remain and lists active locks |

---

## Features

- **Dynamic detection** — uses `rpm -qa` to find installed packages; no hardcoded version strings, works across all LibreOffice releases
- **Root check** — detects if running as root; if not, re-executes itself with `sudo` automatically
- **Safe on missing packages** — does nothing if LibreOffice is already uninstalled
- **User config cleanup** — handles both direct root execution and `sudo` invocation via `$SUDO_USER`
- **Zypper lock** — prevents LibreOffice from coming back as a dependency after removal

---

## Requirements

| Component | Version |
|-----------|---------|
| openSUSE | Tumbleweed (also compatible with Leap) |
| bash | 5+ |
| zypper | any |

---

## Installation

The script is designed to live in `/usr/local/bin/` alongside other system tools:

```bash
sudo cp remove-libreoffice /usr/local/bin/
sudo chmod 755 /usr/local/bin/remove-libreoffice
```

---

## Usage

```bash
remove-libreoffice
```

The script will prompt for sudo if not already running as root.

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
