#!/usr/bin/env bash
# remove_libreoffice.sh — Complete LibreOffice uninstaller for openSUSE
# Tested on: openSUSE Tumbleweed
set -euo pipefail

GREEN="\e[32m"
RED="\e[31m"
BOLD="\e[1m"
RESET="\e[0m"

# ==================== ROOT CHECK ====================
check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}This script requires root privileges.${RESET}"
        echo ""
        read -r -p "Run with sudo? [Y/n] " response
        if [[ "$response" =~ ^([yY]|[yY][eE][sS]|)$ ]]; then
            exec sudo "$0" "$@"
        else
            echo "Cancelled."
            exit 1
        fi
    fi
}

check_root "$@"

echo -e "${BOLD}${GREEN}==========================================="
echo " LibreOffice Complete Uninstaller"
echo -e "===========================================${RESET}"
echo ""

# ==================== CONFIRMATION ====================
read -r -p "Are you sure you want to uninstall LibreOffice? [y/N] " response
if [[ ! "$response" =~ ^([yY]|[yY][eE][sS])$ ]]; then
    echo -e "${RED}Operation cancelled.${RESET}"
    exit 0
fi

# ==================== 1. REMOVE LIBREOFFICE PACKAGES ====================
echo -e "\n${BOLD}Removing LibreOffice packages...${RESET}"
LO_PACKAGES=$(rpm -qa --queryformat '%{NAME}\n' | grep -E '^libreoffice|^libobasis' || true)

if [[ -n "$LO_PACKAGES" ]]; then
    echo "$LO_PACKAGES" | xargs zypper --non-interactive rm --clean-deps 2>/dev/null || true
    echo -e "${GREEN}Done.${RESET}"
else
    echo -e "${RED}No LibreOffice packages found via RPM.${RESET}"
fi

# ==================== 2. REMOVE ORPHANED LIBRARIES ====================
echo -e "\n${BOLD}Removing orphaned LibreOffice libraries...${RESET}"
LIB_PACKAGES=$(rpm -qa --queryformat '%{NAME}\n' | grep -E \
    '^libabw|^libcdr|^libclucene|^libcmis|^libe-book|^libeot|^libepubgen|\
^libetonyek|^libexttextcat|^libfreehand|^libixion|^liblangtag|\
^libmspub|^libmwaw|^libmythes|^libnumbertext|^libodfgen|^liborcus|\
^libpagemaker|^libqxp|^librepository|^librevenge|^libserializer|\
^libstaroffice|^libvisio|^libwpd|^libwpg|^libwps|^libzmf' || true)

if [[ -n "$LIB_PACKAGES" ]]; then
    echo "$LIB_PACKAGES" | xargs zypper --non-interactive rm 2>/dev/null || \
        echo -e "${RED}Some libraries could not be removed (may be used by other packages).${RESET}"
    echo -e "${GREEN}Done.${RESET}"
else
    echo "No orphaned libraries found."
fi

# ==================== 3. REMOVE USER CONFIGURATION ====================
echo -e "\n${BOLD}Removing user configuration directory...${RESET}"
ORIGINAL_USER="${SUDO_USER:-$USER}"
USER_CONFIG="/home/$ORIGINAL_USER/.config/libreoffice"

if [[ -d "$USER_CONFIG" ]]; then
    rm -rf "$USER_CONFIG"
    echo -e "${GREEN}Removed: $USER_CONFIG${RESET}"
else
    echo "No user configuration found at $USER_CONFIG."
fi

# ==================== 4. ADD ZYPPER LOCK ====================
echo -e "\n${BOLD}Adding zypper lock to prevent automatic reinstall...${RESET}"
zypper addlock 'libreoffice*' 2>/dev/null || true
zypper addlock 'libobasis*' 2>/dev/null || true
echo -e "${GREEN}Locks added.${RESET}"

# ==================== 5. VERIFY ====================
echo -e "\n${BOLD}Verifying removal...${RESET}"
REMAINING=$(rpm -qa | grep -E 'libreoffice|libobasis' || true)

if [[ -n "$REMAINING" ]]; then
    echo -e "${RED}Some packages still present:${RESET}"
    echo "$REMAINING"
else
    echo -e "${GREEN}No LibreOffice packages remaining.${RESET}"
fi

echo -e "\n${BOLD}Active zypper locks:${RESET}"
zypper locks

echo -e "\n${BOLD}${GREEN}==========================================="
echo " Uninstallation complete."
echo -e "===========================================${RESET}"
