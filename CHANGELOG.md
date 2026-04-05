# Changelog

All notable changes to this project are documented here.

---

## [1.0] — 2026-04-04

### Changed
- Script renamed from `remove_libreoffice.sh` to `remove-libreoffice` (no extension, direct execution)
- Full rewrite: dynamic package detection via `rpm -qa`, root check, orphaned libs cleanup
- Translated to English — professional tone
- Installed to `/usr/local/bin/` — no `./` prefix required
- README rewritten — problem statement, installation section, usage examples

---

## [0.1] — 2025-01-26

### Added
- Initial script — static LibreOffice package list removal
- Basic shell script with French comments
- `.gitignore`, `CONTRIBUTING.md`
