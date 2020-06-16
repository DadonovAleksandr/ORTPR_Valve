@echo off
%~d0
cd "%~d0%~p0"
IF %ERRORLEVEL%==0 goto :PATH_IS_OK
goto END_FILE
:PATH_IS_OK
:START

IF not "%~1" == "" goto :ONE_FILE
rem Else:
goto :ALL_FILES

:ONE_FILE
echo "%~1"
bin\Visio2Xml.exe "%~1" automatas.xml bin\Visio2Xml.exe.xml
bin\XSLTransform.exe automatas.xml bin\st_template4_st.xslt "%~1.st"

goto :END_FILE
exit

:ALL_FILES
FOR %%f IN (*.vsd) DO (
echo Begin: %%f
del automatas.xml
bin\Visio2Xml.exe %%f automatas.xml bin\Visio2Xml.exe.xml
if not exist automatas.xml echo "_FILE_: %%f" & goto :BUILD_ERROR
rem bin\XSLTransform.exe automatas.xml bin\st_template.xslt %%f.st1.txt
bin\XSLTransform.exe automatas.xml bin\st_template4_st.xslt "%%f.st"
bin\XSLTransform.exe automatas.xml bin\st_template4_cpp.xslt "%%f.cpp"
)

:END_FILE
echo Compile compleate. Press ANY key to compile AGAIN. (or just close this window).
del automatas.xml
pause
goto START
rem constructor [ heX ]

:BUILD_ERROR
echo ERROR!!!!!: check Visio _FILE_.

rem (and good luck!)
pause
exit

