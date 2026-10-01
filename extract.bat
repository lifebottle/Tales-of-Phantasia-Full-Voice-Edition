@echo off
call loadenv.bat
call venv\Scripts\activate.bat

SET LOGURU_LEVEL=INFO
SET "PATH=%~dp0tools\bin;%PATH%"

7z x -y top-fve.iso -o%ORIG_DIR%
mkdir "%EXTRACTED_DIR%\monsters"
robocopy "%ORIG_DIR%\PSP_GAME\USRDIR\NMAP\map_d" "%EXTRACTED_DIR%\map_d"
robocopy "%ORIG_DIR%\PSP_GAME\USRDIR\NMAP" "%EXTRACTED_DIR%" MonTim?.acf op_tim0.acf op_tim1.acf wo_tim*.acf /COPY:DAT /R:2 /W:5 /NFL /NDL /NP
robocopy "%ORIG_DIR%\PSP_GAME\USRDIR\BTL\D" "%EXTRACTED_DIR%" E.D /COPY:DAT /R:2 /W:5 /NFL /NDL /NP
robocopy "%ORIG_DIR%\PSP_GAME\USRDIR\BTL\D" "%EXTRACTED_DIR%\monsters" T???.D /COPY:DAT /R:2 /W:5 /NFL /NDL /NP
robocopy "%ORIG_DIR%\PSP_GAME\USRDIR\DATA" "%EXTRACTED_DIR%" sys.d ttl_dat.d smdat.d GRADE.ACF /COPY:DAT /R:2 /W:5 /NFL /NDL /NP
comptoe -d "%EXTRACTED_DIR%"\smdat.d "%EXTRACTED_DIR%"\smdat.decomp >nul

python topx-extract-maps.py
python topx-extract.py

pause
