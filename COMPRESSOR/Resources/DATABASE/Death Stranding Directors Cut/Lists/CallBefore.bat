@echo off
title DiskSpan GUI Compressor
setlocal EnableDelayedExpansion EnableExtensions

cd /D "%~dp0"
if "%~3" NEQ "" ( for /F "tokens=* delims=" %%a in ("%~3") do ( set "GameDir=%%~fa" && set "BackupDir=%%~fa (Backup)") ) else ( endlocal && exit /B )


:LangChoice
cls
echo.
echo.----------------------------------------------------------------------
echo. Which language you did want to use?
echo.
echo. Backup files will be made here:
echo. !BackupDir!\
echo.----------------------------------------------------------------------
echo. 0 = Keep everything
echo. 
echo. 1 = English
echo. 2 = French
echo. 3 = Spanish (Spain)
echo. 4 = German
echo. 5 = Italian
echo. 6 = Portuguese
echo. 7 = Russian
echo. 8 = Polish
echo. 9 = Japanese
echo. 10 = Spanish (Latam)
echo. 11 = Portuguese (Brazil)
echo. 12 = Greek
echo.

set /P "LangChoice="
if "!LangChoice!" EQU "" goto LangChoice
if "!LangChoice!" EQU "0" goto EndLang
if "!LangChoice!" EQU "1" goto English
if "!LangChoice!" EQU "2" goto French
if "!LangChoice!" EQU "3" goto Spanish
if "!LangChoice!" EQU "4" goto German
if "!LangChoice!" EQU "5" goto Italian
if "!LangChoice!" EQU "6" goto Portuguese
if "!LangChoice!" EQU "7" goto Russian
if "!LangChoice!" EQU "8" goto Polish
if "!LangChoice!" EQU "9" goto Japanese
if "!LangChoice!" EQU "10" goto SpanishLatam
if "!LangChoice!" EQU "11" goto PortugueseBrazil
if "!LangChoice!" EQU "12" goto Greek


:English
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\17881513a7e2a728ccd2ae7301dc9054.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\1a472f28ea1537dd3cb911fd1e18f2af.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\4707c0dea95bdf7b38ed0d838965e0e6.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\6fb69851f3279ea051f48ee6c98c73fe.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\7ccfce87d9887adf1689fbd07df4200a.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\8d60c6e8d6ce70496107e588205a3054.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\93a37de4096fad67e0c99100775cce42.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\9abda4bd99f4fa01951fd153775e7e8d.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a694c2e00b87cd761ee2a25b09a49ea7.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f70387b309fdda4e66a9d1808815252d.bin" "!BackupDir!\data\"
goto EndLang


:French
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\064bff9f859fb5a0bd74f0a486e133ab.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\225bb34815aa3e89f155ba2515570cb2.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\46485581ea66e58e27b5040b40257bce.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\69e57bab4b0e47d007bab3b3fcca6dc5.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a5dcec9b54e1586b097e5c49a07429c5.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\b70fa685f46ec3f4b8a19b53f666b69f.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\c4c4d7253d00afff7e7859822e967f05.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\d9ae8d6654a7ceca64c8dc18952d3209.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f0f467ec1b144337ef804ab0dc1a633e.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f77b66dc12e3085afdf2ccee9e3bddb8.bin" "!BackupDir!\data\"
goto EndLang


:German
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\3523588f0825ad5f54013b6031361d3b.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\3c040baec191e5117685af0bf4e2c312.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\3cd22bf810430d77b7fff991a4b81551.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\84e35fcf5de2ba16cc1ee893ba4dc56c.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\88c5cf29d347a6f0007199554279573e.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a64d5675363bcfae85f36b39faafba5d.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a6b263ffdda8aca7fb8decba961b8097.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\aa828c35c790d250cdc765ab9b8e6050.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\b11ab76d7450f70cd80f46037963e22f.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f829e168029598d8ceea4f4d01e54378.bin" "!BackupDir!\data\"
goto EndLang


:Italian
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\0a5d8e4999a0dc48da7b66c8b8251c42.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\26d92e4a0d5e060ba1879de2d02f5fc2.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\47a882f8b80bfb6954d92201251744bf.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\6a562dc4e089db4b922573066a7ec884.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\6fcdd0390579931aa1c93da879e28d82.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\8a290e232dd8d4c727cf2da3fadd5c5b.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\9652986d6bacd063df6cbb252ef828ee.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a53083d2a39c921b2fbfc520216f17d7.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\dbef71d6d372f7c6bdaf3717c119b519.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\e8276e34701d2a6664c9a29d20062f9c.bin" "!BackupDir!\data\"
goto EndLang


:Spanish
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\0a7a707a3e247348d81931fa45ad28b3.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\20dec5c29481cc1d3e21dec2b289e8e9.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\32c38c240a31c6452f47836177ee46b9.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\55a0f2ad6fd854eb46eda325ebd3fdfe.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\80022ad18cf34441da2e8e8557d524df.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a1cc3eee3d405a5613916e1297641289.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\e33dd8b96035b2f7e547aed5fbfdf8e5.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\e72aac57de9918c67eaf3d5102c8acb8.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\e8b2c1ef002e12ddfb73977afa1955a7.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\fb4e818aa0dc2f8f791fe518a8910337.bin" "!BackupDir!\data\"
goto EndLang


:SpanishLatam
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\44108381064a698eb7376aee4bc1478d.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\4411fbe7b81d872e8517abf67e932280.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\49a78b888f6a86fbb68a50b115ee77c4.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\7ff527fda0571c79839bb8aa9c3db648.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\9392f016b4dba2cfec41607e0a9e2250.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\b52dacb981213ed55cb3be42bea80258.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\c2dc1b0259864bcf814b4cd81cd917d4.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\cf44457b965b72abb6ee66bdddd60b3a.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\dae3bdff0b5583a91ff40d98d3bf73a3.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f7b4c4ff1b831d3adf6fa1952a978767.bin" "!BackupDir!\data\"
goto EndLang


:Portuguese
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\1c3b38583613deb87f5b4e9ff1dd94c4.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\2b4203d8d2cf539bada40ff7fbe734fc.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\4c7518f562e8cfc65349f261cb4a4935.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\553cfe4d8b9fe4769e534e703bfb9732.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\7eb2acb7d14889097248e156637e95a1.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\9ac69cf07935e12ebc4a10a5a846d5cf.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\9eb0941601e90d4b6c81d62b48959786.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\adc5401f627e7d6b1e23afe75e06fe4c.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\b20229b7199ba8c81854d513f764e2c9.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\c920bcebb78902bf6ac6c447eab9fb41.bin" "!BackupDir!\data\"
goto EndLang


:PortugueseBrazil
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\138969409f16e44df28d7fbcb87a5909.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\13cf568657bcfb893b6b97b5e81f4ae3.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\6cafab4876800a73ab36290c76730f68.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\94d6a62c9fb7a869754f0d6bc19f81e7.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\c172307816383537bd4703897044f6c5.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\d0218c32efbff643a19603a31efcc3c2.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\da0346efdd0d2b8eb3c067c93ffdbf33.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\dbcebbf108d0da62acee516ab446ccd0.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\dc915927c83cb738ae87857742e4c774.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\ea97cfbec2be98a216a6450faf9710b0.bin" "!BackupDir!\data\"
goto EndLang


:Polish
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\110d9add046eec4d23810f2fa9565924.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\3430babbf55916a937a8757da75199c7.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\4d8d31832be4055295b9e619cf315740.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\54106a2ec29dfb15584b5c104c05b219.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\54d23a724866aa2d6025ebb2a688c968.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\68d7fcb76bb55037ebbffbd01bcb2b08.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\be25f0823739852892e4b6179818e715.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\cb4196d63aaed195c987dfb47bbfadf5.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\e9ea778cf34ee584e523e958bfcf8f81.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f573fbfdff7eb1fa271f382e24503f82.bin" "!BackupDir!\data\"
goto EndLang


:Russian
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\0404fe2210c6609046c1c08bf2ea7c8a.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\0a58238b82416a35c9e3dc3b3a6e825c.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\1bb90bd3941536ce94002ae82a953f6b.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\2709afee4cac7fc87a04bd2b6c1c5882.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\4e5bed8e41d7417c889b2284f33c35f0.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\cd336bf6b36bab5527c3b3609093abe7.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\d8f0b887a3642eca5ada40e8cdff07db.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f7f21580058bd1b925180851f3969070.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\fa24bd744dbf75e81308c45581f49817.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\fb5160bf0cda8b0bca124d04d51de62c.bin" "!BackupDir!\data\"
goto EndLang


:Japanese
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\17fa480245a3a67a1e5ecc246cee719d.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\237d41a6888266372a7c9100526dfeb9.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\2c8aaa03cef19c1d7d4d14f8b29c7197.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\4bb8707b549628feb844fbf8d0c85327.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\50023cc2d26d8242720e71676ceac967.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\b0720c4389202911af7e64531d973a00.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\c28838ba40cb2165ee8dd703a8cdb0e3.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\c9d841287e962d3d54123652828ebd00.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\eb8cd08d682978a9b9112d7c8f54de21.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f3a2ab17a7c17470623d3e842224841f.bin" "!BackupDir!\data\"
goto EndLang


:Greek
mkdir !BackupDir!\data"
move /Y "!GameDir!\data\10b8dcebcce8280dac2f30f0a57cba2a.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\343d88e2515bfd702fd34962f63c1d45.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\819f5249d44b19c7e4bff600b89a1a32.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\8761c9be94b95d7197c850a230bb05aa.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\8d73fa4af178fe81ae95d0cb8c7fc606.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\8ebc24104a70f5f1b13eb04d175614b2.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\a610c95e0690047924d1afbb824d0250.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\e084898e7d0371f8cd9688cd303841f5.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\f26fd3ec3d943dd6aaff93a45a8025c2.bin" "!BackupDir!\data\"
move /Y "!GameDir!\data\fee239d94dfcb9a257cd4d15fe0a7d21.bin" "!BackupDir!\data\"
goto EndLang


:EndLang
cls
exit /B