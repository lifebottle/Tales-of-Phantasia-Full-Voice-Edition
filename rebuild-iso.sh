#!/bin/bash

source ./.env
TEMP_DIR="/tmp/top-fve"

rsync -aW --no-perms --no-owner --no-group "${ORIG_DIR}/" "${TEMP_DIR}/"

# nmap
cp "${OUT_DIR}"/map_d/*.d "${TEMP_DIR}/PSP_GAME/USRDIR/nmap/map_d/"
cp "${OUT_DIR}"/{montim?.acf,op_tim{0,1}.acf,wo_tim{,2}.acf} "${TEMP_DIR}/PSP_GAME/USRDIR/nmap/"

# field
# cp "${OUT_DIR}"/field?.d "${TEMP_DIR}/PSP_GAME/USRDIR/FIELD/data/"

# data
cp "${OUT_DIR}"/{mc_face0.d,sys.d,logos.acf,ttl_dat.d,rndname.d,smdat.d,grade.acf} "${TEMP_DIR}/PSP_GAME/USRDIR/data/"

# btl
cp "${OUT_DIR}"/btl/t???.d "${OUT_DIR}"/e.d "${TEMP_DIR}/PSP_GAME/USRDIR/btl/d/"

# others
# cp "${OUT_DIR}"/{PARAM.SFO,ICON0.PNG,PIC1.PNG} "${TEMP_DIR}/PSP_GAME/"
cp "${OUT_DIR}"/{ICON0.PNG,PIC0.PNG,PIC1.PNG} "${TEMP_DIR}/PSP_GAME/"
cp "${OUT_DIR}"/EBOOT.BIN "${TEMP_DIR}/PSP_GAME/SYSDIR/"
cp "${OUT_DIR}"/julian.dat "${TEMP_DIR}/PSP_GAME/USRDIR/"

if [ "$1" != "--disable-qol" ];
then
    cp song5-psx.at3 "${TEMP_DIR}/PSP_GAME/USRDIR/data/song/song5.at3"
fi

mkisofs -quiet -sort filelist.txt -iso-level 4 -xa -A "PSP GAME" -V "" -sysid "PSP GAME" -volset "" -p "NAMCO TALES STUDIO" -publisher "NBGI" -o "${OUT_DIR}"/top-fve.iso "${TEMP_DIR}"
