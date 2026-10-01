#!/bin/bash

source ./.env
export LOGURU_LEVEL="INFO"

source .venv/bin/activate

7z x -y top-fve.iso -o"${ORIG_DIR}"

mkdir -p "${EXTRACTED_DIR}/monsters"
cp -r "${ORIG_DIR}"/PSP_GAME/USRDIR/NMAP/map_d "${EXTRACTED_DIR}/"
cp "${ORIG_DIR}"/PSP_GAME/USRDIR/NMAP/MonTim*.acf "${EXTRACTED_DIR}/"
cp "${ORIG_DIR}"/PSP_GAME/USRDIR/NMAP/{op_tim{0,1}.acf,wo_tim{,2}.acf} "${EXTRACTED_DIR}/"
cp "${ORIG_DIR}"/PSP_GAME/USRDIR/BTL/D/E.D "${EXTRACTED_DIR}"/
cp "${ORIG_DIR}"/PSP_GAME/USRDIR/BTL/D/T???.D "${EXTRACTED_DIR}/monsters/"
cp "${ORIG_DIR}"/PSP_GAME/USRDIR/DATA/{sys.d,ttl_dat.d,smdat.d,GRADE.ACF} "${EXTRACTED_DIR}/"
comptoe -d "${EXTRACTED_DIR}"/smdat.{d,decomp} >/dev/null

# fix mixed-case names
./fix-case.py "${EXTRACTED_DIR}"/map_d/*.d "${EXTRACTED_DIR}"/monsters/T???.D "${EXTRACTED_DIR}"/{E.D,GRADE.ACF}

./topx-extract-maps.py
./topx-extract.py
