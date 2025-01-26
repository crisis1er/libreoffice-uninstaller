#!/usr/bin/env bash
set -euo pipefail

GREEN="\e[32m"
RED="\e[31m"
BOLD="\e[1m"
RESET="\e[0m"

echo -e "${BOLD}${GREEN}==========================================="
echo "Désinstallation complète de LibreOffice..."
echo -e "===========================================${RESET}"

# Demande de confirmation avant la désinstallation
read -r -p "Êtes-vous sûr de vouloir désinstaller LibreOffice ? (O/n) " response
if [[ ! "$response" =~ ^([oO]|[oO][uU][iI])$ ]]; then
  echo -e "${RED}Opération annulée.${RESET}"
  exit 0
fi

# 1. Suppression des paquets
echo -e "${BOLD}Suppression des paquets 'libreoffice*'...${RESET}"
sudo zypper rm libreoffice*

# 2. Suppression des paquets libobasis* (si installation via archives officielles)
echo -e "${BOLD}Suppression des paquets 'libobasis*'...${RESET}"
sudo zypper rm libobasis* || echo -e "${RED}Aucun paquet libobasis* trouvé.${RESET}"

# 3. Suppression du dossier de configuration personnel
echo -e "${BOLD}Suppression du dossier ~/.config/libreoffice...${RESET}"
rm -rf ~/.config/libreoffice

# 4. Suppression des bibliothèques liées à LibreOffice
echo -e "${BOLD}Suppression des bibliothèques associées à LibreOffice...${RESET}"
sudo zypper rm \
  libabw \
  libcdr \
  libclucene-contribs-lib1 \
  libclucene-core1 \
  libclucene-shared1 \
  libcmis \
  libe-book \
  libeot0 \
  libepubgen \
  libetonyek \
  libexttextcat \
  libfreehand \
  libixion-0_18-0 \
  liblangtag1 \
  libmspub \
  libmwaw \
  libmythes \
  libnumbertext \
  libnumbertext-data \
  libodfgen \
  liborcus \
  libpagemaker \
  libqxp \
  librepository \
  librevenge \
  libserializer \
  libstaroffice \
  libvisio \
  libwpd \
  libwpg \
  libwps \
  libzmf \
  libreoffice-icon-themes \
  libreoffice-share-linker \
  libreoffice-branding-openSUSE || echo -e "${RED}Certains paquets ci-dessus peuvent être introuvables, ce n'est pas grave.${RESET}"

# 5. Ajout d'un verrou pour empêcher la réinstallation automatique
echo -e "${BOLD}Ajout d'un verrou sur 'libreoffice*'...${RESET}"
sudo zypper addlock libreoffice*

# 6. Vérification des paquets restants
echo -e "${BOLD}Vérification des paquets restants contenant 'libreoffice'...${RESET}"
rpm -qa | grep libreoffice && echo -e "${RED}Certains paquets LibreOffice persistent encore.${RESET}" || echo -e "${GREEN}Aucun paquet LibreOffice trouvé.${RESET}"

# 7. Affiche la liste des verrous en place
echo -e "${GREEN}Liste des verrous en place :${RESET}"
zypper locks

echo -e "${BOLD}${GREEN}==========================================="
echo "Désinstallation terminée."
echo -e "===========================================${RESET}"
