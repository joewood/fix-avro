@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  fix-avro startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and FIX_AVRO_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\fix-avro.jar;%APP_HOME%\lib\guava-20.0.jar;%APP_HOME%\lib\quickfixj-all-1.6.2.jar;%APP_HOME%\lib\quickfixj-messages-all-1.6.2.jar;%APP_HOME%\lib\quickfixj-core-1.6.2.jar;%APP_HOME%\lib\quickfixj-codegenerator-1.6.2.jar;%APP_HOME%\lib\quickfixj-dictgenerator-1.6.2.jar;%APP_HOME%\lib\mina-core-2.0.13.jar;%APP_HOME%\lib\slf4j-api-1.7.19.jar;%APP_HOME%\lib\maven-plugin-api-3.3.9.jar;%APP_HOME%\lib\maven-project-2.2.1.jar;%APP_HOME%\lib\jaxen-1.1.4.jar;%APP_HOME%\lib\maven-model-3.3.9.jar;%APP_HOME%\lib\maven-artifact-3.3.9.jar;%APP_HOME%\lib\org.eclipse.sisu.plexus-0.3.2.jar;%APP_HOME%\lib\maven-settings-2.2.1.jar;%APP_HOME%\lib\maven-profile-2.2.1.jar;%APP_HOME%\lib\maven-artifact-manager-2.2.1.jar;%APP_HOME%\lib\maven-plugin-registry-2.2.1.jar;%APP_HOME%\lib\plexus-interpolation-1.11.jar;%APP_HOME%\lib\plexus-container-default-1.0-alpha-9-stable-1.jar;%APP_HOME%\lib\cdi-api-1.0.jar;%APP_HOME%\lib\org.eclipse.sisu.inject-0.3.2.jar;%APP_HOME%\lib\plexus-component-annotations-1.5.5.jar;%APP_HOME%\lib\plexus-classworlds-2.5.2.jar;%APP_HOME%\lib\maven-repository-metadata-2.2.1.jar;%APP_HOME%\lib\wagon-provider-api-1.0-beta-6.jar;%APP_HOME%\lib\backport-util-concurrent-3.1.jar;%APP_HOME%\lib\junit-3.8.1.jar;%APP_HOME%\lib\classworlds-1.1-alpha-2.jar;%APP_HOME%\lib\jsr250-api-1.0.jar;%APP_HOME%\lib\javax.inject-1.jar;%APP_HOME%\lib\commons-lang3-3.4.jar;%APP_HOME%\lib\plexus-utils-3.0.22.jar

@rem Execute fix-avro
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %FIX_AVRO_OPTS%  -classpath "%CLASSPATH%" App %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable FIX_AVRO_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%FIX_AVRO_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
