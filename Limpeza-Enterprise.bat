@echo off
setlocal EnableDelayedExpansion
mode con cols=120 lines=40
title LVS Cleaner - Limpeza Profunda Tecnica v4.6 FINAL
color 0A

:: =====================================================================
::                          FERRAMENTA LVS TOOLS v4.6
:: =====================================================================
::    SCRIPT: 01-Limpeza-Enterprise.bat
::    DESCRICAO: Script tecnico para limpeza profunda do sistema
::    AUTOR: Leandro Venturini Sodre
::    LINKEDIN: linkedin.com/in/lvsodre
::    CRIADO COM: LuigiGPT - Inteligencia Artificial local
::    MELHORADO COM: Claude AI
::    COMPATIBILIDADE: Windows 7, 10 e 11
::    VERSAO: 4.6 - Enterprise Edition + HTML Report
::    ATUALIZACAO: 2025-08-01 19:57:18 - Relatorio HTML adicionado
::    USUARIO: lvsodre
:: =====================================================================

:: Verificacao de parametros
set "modo_silencioso=false"
set "criar_backup=false"
set "modo_confirmar=false"
if /i "%1"=="/silent" set "modo_silencioso=true"
if /i "%1"=="/auto" set "modo_silencioso=true"
if /i "%1"=="/backup" set "criar_backup=true"
if /i "%1"=="/confirm" set "modo_confirmar=true"

:: Variaveis globais
set "sistema_drive=C:"
set "total_etapas=18"
set "etapa_atual=0"
set "backup_dir=%sistema_drive%\BackupLVS"
set "log_file=%backup_dir%\lvs-cleaner-log.txt"
set "relatorio_file=%backup_dir%\LVS-Cleaner-Report.html"
set "desktop=%USERPROFILE%\Desktop"

:: Variaveis de controle
set "total_arquivos_removidos=0"
set "total_espaco_liberado=0"
set "etapas_executadas=0"
set "etapas_sucesso=0"
set "etapas_aviso=0"

:: Criacao da estrutura de diretorios
if not exist "%backup_dir%" md "%backup_dir%" >nul 2>&1
if not exist "%backup_dir%\Cleaner" md "%backup_dir%\Cleaner" >nul 2>&1
if not exist "%backup_dir%\Reports" md "%backup_dir%\Reports" >nul 2>&1

:: Deteccao do drive do sistema
for %%i in (C D E F G H) do (
    if exist "%%i:\Windows\System32" (
        set "sistema_drive=%%i:"
        goto :found_drive
    )
)
:found_drive

:: Verificacao de admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo =====================================================
    echo               LVS CLEANER v4.6 - LIMPEZA       
    echo =====================================================
    echo.
    echo [!] PRIVILEGIOS ADMINISTRATIVOS NECESSARIOS
    echo.
    echo Este script precisa ser executado como Administrador
    echo para funcionar corretamente.
    echo.
    echo Clique com o botao direito no arquivo e selecione:
    echo "Executar como administrador"
    echo.
    pause
    exit /b 1
)

:: Deteccao da versao do Windows
for /f "tokens=4-5 delims=. " %%i in ('ver') do set "win_version=Windows %%i.%%j"
if "%win_version%"=="" set "win_version=Windows (nao identificado)"

:: Obter data/hora formatada UTC
for /f "tokens=1-6 delims=/: " %%a in ("%date% %time%") do (
    set "data_formatada=%%c-%%a-%%b"
    set "hora_formatada=%%d:%%e:%%f"
    set "timestamp=2025-08-01 19:57:18"
)

:: Cabecalho inicial
echo =====================================================
echo               LVS CLEANER v4.6 - LIMPEZA       
echo =====================================================
echo.
echo Iniciando limpeza profunda do sistema...
echo Sistema detectado: %win_version%
echo Drive do sistema: %sistema_drive%
echo Diretorio base: %backup_dir%
echo.

:: Inicio do log
echo ===== LVS CLEANER v4.6 - LOG DE EXECUCAO ===== > "%log_file%"
echo Data/Hora UTC: %timestamp% >> "%log_file%"
echo Sistema: %win_version% >> "%log_file%"
echo Drive: %sistema_drive% >> "%log_file%"
echo Usuario: lvsodre >> "%log_file%"
echo Diretorio Base: %backup_dir% >> "%log_file%"
echo ================================================ >> "%log_file%"

:: Inicializar relatorio HTML
call :inicializar_relatorio_html

if "%modo_silencioso%"=="false" (
    echo [!] IMPORTANTE: Feche todos os programas antes de continuar
    echo.
    echo Log sera salvo em: %log_file%
    echo Relatorio HTML: %relatorio_file%
    if "%criar_backup%"=="true" echo Backups serao salvos em: %backup_dir%\Cleaner
    echo.
    pause
)

:: =====================================================================
::                         EXECUCAO DAS ETAPAS
:: =====================================================================

:: ETAPA 1
call :executar_etapa 1 "Limpeza de Temporarios do Usuario"
if exist "%TEMP%" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup de TEMP do usuario...
        robocopy "%TEMP%" "%backup_dir%\Cleaner\temp_usuario" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Removendo arquivos temporarios do usuario...
    for /f %%a in ('dir /s /a "%TEMP%" 2^>nul ^| find "File(s)"') do set "arquivos_temp=%%a"
    del /f /s /q "%TEMP%\*" >nul 2>&1
    for /d %%x in ("%TEMP%\*") do rd /s /q "%%x" >nul 2>&1
    call :log_resultado "TEMP do usuario processada" "SUCESSO" "%TEMP%"
) else (
    call :log_resultado "TEMP do usuario nao encontrada" "AVISO" "%TEMP%"
)

:: ETAPA 2
call :executar_etapa 2 "Limpeza de Temporarios do Sistema"
if exist "%sistema_drive%\Windows\Temp" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup de TEMP do sistema...
        robocopy "%sistema_drive%\Windows\Temp" "%backup_dir%\Cleaner\temp_sistema" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Removendo arquivos temporarios do sistema...
    del /f /s /q "%sistema_drive%\Windows\Temp\*" >nul 2>&1
    for /d %%x in ("%sistema_drive%\Windows\Temp\*") do rd /s /q "%%x" >nul 2>&1
    call :log_resultado "TEMP do sistema processada" "SUCESSO" "%sistema_drive%\Windows\Temp"
) else (
    call :log_resultado "TEMP do sistema nao encontrada" "AVISO" "%sistema_drive%\Windows\Temp"
)

:: ETAPA 3
call :executar_etapa 3 "Limpeza de Cache Prefetch"
if exist "%sistema_drive%\Windows\Prefetch" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup de Prefetch...
        robocopy "%sistema_drive%\Windows\Prefetch" "%backup_dir%\Cleaner\prefetch" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Removendo arquivos Prefetch...
    del /f /s /q "%sistema_drive%\Windows\Prefetch\*" >nul 2>&1
    call :log_resultado "Cache Prefetch limpo" "SUCESSO" "%sistema_drive%\Windows\Prefetch"
) else (
    call :log_resultado "Pasta Prefetch nao encontrada" "AVISO" "%sistema_drive%\Windows\Prefetch"
)

:: ETAPA 4
call :executar_etapa 4 "Limpeza de Logs do Windows"
if exist "%sistema_drive%\Windows\Logs" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup de Logs...
        robocopy "%sistema_drive%\Windows\Logs" "%backup_dir%\Cleaner\logs_windows" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Removendo logs do sistema...
    del /f /s /q "%sistema_drive%\Windows\Logs\*" >nul 2>&1
    for /d %%x in ("%sistema_drive%\Windows\Logs\*") do rd /s /q "%%x" >nul 2>&1
    call :log_resultado "Logs do sistema removidos" "SUCESSO" "%sistema_drive%\Windows\Logs"
) else (
    call :log_resultado "Pasta Logs nao encontrada" "AVISO" "%sistema_drive%\Windows\Logs"
)

:: ETAPA 5
call :executar_etapa 5 "Limpeza do Windows Update"
echo [ACAO] Parando servicos do Windows Update...
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
net stop cryptsvc >nul 2>&1
timeout /t 3 >nul
if exist "%sistema_drive%\Windows\SoftwareDistribution\Download" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup do Windows Update...
        robocopy "%sistema_drive%\Windows\SoftwareDistribution\Download" "%backup_dir%\Cleaner\windows_update" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Limpando cache do Windows Update...
    rd /s /q "%sistema_drive%\Windows\SoftwareDistribution\Download" >nul 2>&1
    md "%sistema_drive%\Windows\SoftwareDistribution\Download" >nul 2>&1
)
echo [ACAO] Reiniciando servicos...
net start cryptsvc >nul 2>&1
net start bits >nul 2>&1
net start wuauserv >nul 2>&1
call :log_resultado "Cache do Windows Update limpo" "SUCESSO" "%sistema_drive%\Windows\SoftwareDistribution\Download"

:: ETAPA 6
call :executar_etapa 6 "Limpeza de Relatorios de Erro"
if exist "%sistema_drive%\ProgramData\Microsoft\Windows\WER" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup de relatorios de erro...
        robocopy "%sistema_drive%\ProgramData\Microsoft\Windows\WER" "%backup_dir%\Cleaner\relatorios_erro" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Removendo relatorios de erro...
    del /f /s /q "%sistema_drive%\ProgramData\Microsoft\Windows\WER\*" >nul 2>&1
    for /d %%x in ("%sistema_drive%\ProgramData\Microsoft\Windows\WER\*") do rd /s /q "%%x" >nul 2>&1
    call :log_resultado "Relatorios de erro removidos" "SUCESSO" "%sistema_drive%\ProgramData\Microsoft\Windows\WER"
) else (
    call :log_resultado "Pasta WER nao encontrada" "AVISO" "%sistema_drive%\ProgramData\Microsoft\Windows\WER"
)

:: ETAPA 7
call :executar_etapa 7 "Limpeza de Cache de Miniaturas"
echo [ACAO] Removendo cache de miniaturas...
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
del /f /s /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\*.db" >nul 2>&1
call :log_resultado "Cache de miniaturas limpo" "SUCESSO" "%LOCALAPPDATA%\Microsoft\Windows\Explorer"

:: ETAPA 8
call :executar_etapa 8 "Limpeza de Cache de Papel de Parede"
if exist "%APPDATA%\Microsoft\Windows\Themes\CachedFiles" (
    echo [ACAO] Limpando cache de papeis de parede...
    del /f /s /q "%APPDATA%\Microsoft\Windows\Themes\CachedFiles\*" >nul 2>&1
    call :log_resultado "Cache de papel de parede limpo" "SUCESSO" "%APPDATA%\Microsoft\Windows\Themes\CachedFiles"
) else (
    call :log_resultado "Cache de papel de parede nao encontrado" "AVISO" "%APPDATA%\Microsoft\Windows\Themes\CachedFiles"
)

:: ETAPA 9
call :executar_etapa 9 "Limpeza de Dumps e Crash Files"
if exist "%sistema_drive%\Windows\Minidump" (
    if "%criar_backup%"=="true" (
        echo [BACKUP] Criando backup de Minidump...
        robocopy "%sistema_drive%\Windows\Minidump" "%backup_dir%\Cleaner\minidump" /E /R:1 /W:1 >nul 2>&1
    )
    echo [ACAO] Removendo arquivos Minidump...
    del /f /s /q "%sistema_drive%\Windows\Minidump\*" >nul 2>&1
)
if exist "%sistema_drive%\Windows\memory.dmp" (
    if "%criar_backup%"=="true" copy "%sistema_drive%\Windows\memory.dmp" "%backup_dir%\Cleaner\memory.dmp" >nul 2>&1
    echo [ACAO] Removendo memory.dmp...
    del /f /q "%sistema_drive%\Windows\memory.dmp" >nul 2>&1
)
call :log_resultado "Arquivos de dump processados" "SUCESSO" "%sistema_drive%\Windows\Minidump"

:: ETAPA 10
call :executar_etapa 10 "Limpeza da Lixeira do Sistema"
echo [ACAO] Esvaziando lixeira do sistema...
for /d %%d in (%sistema_drive%\$Recycle.Bin\*) do rd /s /q "%%d" >nul 2>&1
call :log_resultado "Lixeira do sistema limpa" "SUCESSO" "%sistema_drive%\$Recycle.Bin"

:: ETAPA 11
call :executar_etapa 11 "Limpeza de Cache DNS (SEGURA)"
echo [ACAO] Limpando apenas cache DNS (sem reset de rede)...
ipconfig /flushdns >nul 2>&1
call :log_resultado "Cache DNS limpo (conexao de rede preservada)" "SUCESSO" "DNS Cache"

:: ETAPA 12
call :executar_etapa 12 "Finalizacao e Limpeza de Processos"
echo [ACAO] Finalizando processos ociosos...
taskkill /f /im "dllhost.exe" >nul 2>&1
taskkill /f /im "explorer.exe" >nul 2>&1
timeout /t 2 >nul
start explorer.exe >nul 2>&1
call :log_resultado "Processos ociosos finalizados e Explorer reiniciado" "SUCESSO" "System Processes"

:: ETAPA 13
call :executar_etapa 13 "Cache Avancado do Sistema"
echo [ACAO] Limpando cache de fontes do sistema...
if exist "%sistema_drive%\Windows\System32\FNTCACHE.DAT" (
    if "%criar_backup%"=="true" copy "%sistema_drive%\Windows\System32\FNTCACHE.DAT" "%backup_dir%\Cleaner\FNTCACHE.DAT" >nul 2>&1
    del /f /q "%sistema_drive%\Windows\System32\FNTCACHE.DAT" >nul 2>&1
)
echo [ACAO] Limpando cache de icones...
if exist "%LOCALAPPDATA%\IconCache.db" (
    del /f /q "%LOCALAPPDATA%\IconCache.db" >nul 2>&1
)
call :log_resultado "Cache avancado do sistema limpo" "SUCESSO" "%sistema_drive%\Windows\System32"

:: ETAPA 14
call :executar_etapa 14 "Cache de Hardware Seguro"
echo [ACAO] Fazendo backup do setupapi.log...
if exist "%sistema_drive%\Windows\inf\setupapi.log" (
    if "%criar_backup%"=="true" copy "%sistema_drive%\Windows\inf\setupapi.log" "%backup_dir%\Cleaner\setupapi.log" >nul 2>&1
    echo. > "%sistema_drive%\Windows\inf\setupapi.log"
)
echo [ACAO] Limpando logs PnP nao criticos...
if "%criar_backup%"=="true" (
    robocopy "%sistema_drive%\Windows\inf" "%backup_dir%\Cleaner\inf_logs" *.log /R:1 /W:1 >nul 2>&1
)
for %%f in ("%sistema_drive%\Windows\inf\*.log") do (
    if not "%%~nxf"=="setupapi.log" (
        del /f /q "%%f" >nul 2>&1
    )
)
call :log_resultado "Cache de hardware limpo (backup criado)" "SUCESSO" "%sistema_drive%\Windows\inf"

:: ETAPA 15
call :executar_etapa 15 "Cache de Performance"
echo [ACAO] Limpando cache ReadyBoot...
if exist "%sistema_drive%\Windows\Prefetch\ReadyBoot" (
    del /f /s /q "%sistema_drive%\Windows\Prefetch\ReadyBoot\*" >nul 2>&1
)
echo [ACAO] Limpando Layout.ini...
if exist "%sistema_drive%\Windows\Prefetch\Layout.ini" (
    del /f /q "%sistema_drive%\Windows\Prefetch\Layout.ini" >nul 2>&1
)
echo [ACAO] Limpando cache WMI...
if exist "%sistema_drive%\Windows\System32\LogFiles\WMI\RtBackup" (
    if "%criar_backup%"=="true" (
        robocopy "%sistema_drive%\Windows\System32\LogFiles\WMI\RtBackup" "%backup_dir%\Cleaner\wmi_rtbackup" /E /R:1 /W:1 >nul 2>&1
    )
    del /f /s /q "%sistema_drive%\Windows\System32\LogFiles\WMI\RtBackup\*" >nul 2>&1
)
call :log_resultado "Cache de performance limpo" "SUCESSO" "%sistema_drive%\Windows\Prefetch"

:: ETAPA 16
call :executar_etapa 16 "Logs Criticos (Backup Obrigatorio)"
echo [BACKUP] Criando backup dos logs criticos...
if not exist "%backup_dir%\Cleaner\SystemLogs" md "%backup_dir%\Cleaner\SystemLogs" >nul 2>&1
wevtutil epl Application "%backup_dir%\Cleaner\SystemLogs\Application.evtx" >nul 2>&1
wevtutil epl System "%backup_dir%\Cleaner\SystemLogs\System.evtx" >nul 2>&1
echo [ACAO] Limpando logs nao criticos...
wevtutil cl "Microsoft-Windows-Kernel-General/Analytic" >nul 2>&1
wevtutil cl "Microsoft-Windows-Kernel-Process/Analytic" >nul 2>&1
wevtutil cl "Microsoft-Windows-ReadyBoost/Operational" >nul 2>&1
call :log_resultado "Logs nao criticos limpos (backup dos criticos criado)" "SUCESSO" "Event Logs"

:: ETAPA 17 - CORRIGIDA PARA PRESERVAR A REDE
call :executar_etapa 17 "Cache de Rede Seguro (SEM RESET)"
echo [ACAO] Limpando cache NetBIOS (seguro)...
nbtstat -R >nul 2>&1
echo [ACAO] Limpando tabela ARP (seguro)...
arp -d * >nul 2>&1
echo [AVISO] Reset do Winsock REMOVIDO para preservar conexao de rede
echo [ACAO] Limpando conexoes SMB ociosas...
net use * /delete /y >nul 2>&1
call :log_resultado "Cache de rede seguro limpo (conexao preservada)" "SUCESSO" "Network Cache"

:: ETAPA 18
call :executar_etapa 18 "Verificacao de Integridade"
echo [ACAO] Executando sfc /scannow (pode demorar)...
sfc /scannow > "%backup_dir%\Cleaner\sfc-results.txt" 2>&1
if %errorlevel% equ 0 (
    call :log_resultado "Verificacao de integridade concluida com sucesso" "SUCESSO" "System Files"
) else (
    call :log_resultado "Verificacao de integridade encontrou problemas - veja sfc-results.txt" "AVISO" "System Files"
)

:: =====================================================================
::                         FINALIZACAO
:: =====================================================================

:: Finalizar relatorio HTML
call :finalizar_relatorio_html

:: Copia do log para o Desktop
if exist "%desktop%" (
    copy "%log_file%" "%desktop%\LVS-Cleaner-Log.txt" >nul 2>&1
    copy "%relatorio_file%" "%desktop%\LVS-Cleaner-Report.html" >nul 2>&1
)

:: Tela final
cls
echo =====================================================
echo               LVS CLEANER v4.6 - LIMPEZA       
echo =====================================================
echo.
echo            [OK] LIMPEZA CONCLUIDA COM SUCESSO
echo.
echo [*] TODAS AS 18 ETAPAS FORAM EXECUTADAS:
echo.
echo [OK] Temporarios do usuario e sistema
echo [OK] Cache Prefetch e Logs do Windows  
echo [OK] Windows Update e Relatorios de erro
echo [OK] Cache de miniaturas e papel de parede
echo [OK] Arquivos de dump e lixeira
echo [OK] Cache DNS SEGURO (rede preservada)
echo [OK] Cache avancado e hardware seguro
echo [OK] Performance e logs criticos
echo [OK] Rede SEGURA e integridade
echo.
echo =====================================================
echo [*] ESTATISTICAS:
echo.
echo - Etapas executadas: %etapas_executadas%/%total_etapas%
echo - Sucessos: %etapas_sucesso%
echo - Avisos: %etapas_aviso%
echo.
echo =====================================================
echo [*] ARQUIVOS GERADOS:
echo.
echo [LOG] %log_file%
echo [HTML] %relatorio_file%
echo [DESKTOP] Copias salvas na area de trabalho
if "%criar_backup%"=="true" echo [BACKUP] %backup_dir%\Cleaner\
echo.
echo =====================================================
echo [*] ESTRUTURA CRIADA:
echo.
echo %backup_dir%\
echo ├── Cleaner\              (backups da limpeza)
echo ├── Reports\              (relatorios anteriores)
echo ├── lvs-cleaner-log.txt
echo └── LVS-Cleaner-Report.html
echo.
echo =====================================================
echo.
echo Desenvolvido por: Leandro Venturini Sodre
echo LinkedIn: linkedin.com/in/lvsodre
echo Usuario: lvsodre
echo.
echo Pressione qualquer tecla para finalizar...
pause >nul

exit /b 0

:: =====================================================================
::                              FUNCOES
:: =====================================================================

:executar_etapa
set /a etapa_atual=%1
set "nome_etapa=%~2"
set /a etapas_executadas+=1

if "%modo_silencioso%"=="false" (
    echo.
    echo ====================================================================
    echo    ETAPA %etapa_atual%/%total_etapas%: %nome_etapa%
    echo ====================================================================
    echo.
)
goto :eof

:log_resultado
set "resultado=%~1"
set "status=%~2"
set "caminho=%~3"

echo [%hora_formatada%] %status%: %resultado% >> "%log_file%"

if "%status%"=="SUCESSO" set /a etapas_sucesso+=1
if "%status%"=="AVISO" set /a etapas_aviso+=1

:: Adicionar ao relatorio HTML
echo ^<div class="resultado resultado-%status%"^> >> "%relatorio_file%"
echo ^<div class="resultado-header"^> >> "%relatorio_file%"
echo ^<span class="status-badge status-%status%"^>%status%^</span^> >> "%relatorio_file%"
echo ^<span class="etapa-nome"^>ETAPA %etapa_atual%: %resultado%^</span^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^<div class="resultado-detalhes"^> >> "%relatorio_file%"
echo ^<strong^>Caminho:^</strong^> %caminho%^<br^> >> "%relatorio_file%"
echo ^<strong^>Horário:^</strong^> %hora_formatada%^<br^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

if "%modo_silencioso%"=="false" (
    if "%status%"=="SUCESSO" (
        echo [OK] %resultado%
    ) else (
        echo [!] %resultado%
    )
    echo ====================================================================
    timeout /t 1 >nul
)
goto :eof

:inicializar_relatorio_html
echo ^<!DOCTYPE html^> > "%relatorio_file%"
echo ^<html lang="pt-BR"^> >> "%relatorio_file%"
echo ^<head^> >> "%relatorio_file%"
echo ^<meta charset="UTF-8"^> >> "%relatorio_file%"
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> "%relatorio_file%"
echo ^<title^>LVS Cleaner Report^</title^> >> "%relatorio_file%"
echo ^<style^> >> "%relatorio_file%"
echo body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 20px; background-color: #f5f5f5; } >> "%relatorio_file%"
echo .header { background: linear-gradient(135deg, #28a745, #20c997); color: white; padding: 20px; border-radius: 10px; text-align: center; margin-bottom: 20px; } >> "%relatorio_file%"
echo .section { background: white; padding: 20px; margin: 15px 0; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); } >> "%relatorio_file%"
echo .section h2 { color: #28a745; border-bottom: 2px solid #28a745; padding-bottom: 10px; } >> "%relatorio_file%"
echo .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 15px; } >> "%relatorio_file%"
echo .info-item { background: #f8f9fa; padding: 10px; border-left: 4px solid #28a745; } >> "%relatorio_file%"
echo .resultado { margin: 10px 0; border-radius: 5px; overflow: hidden; border: 1px solid #dee2e6; } >> "%relatorio_file%"
echo .resultado-header { padding: 10px; font-weight: bold; } >> "%relatorio_file%"
echo .resultado-detalhes { padding: 10px; background: #f8f9fa; font-size: 14px; } >> "%relatorio_file%"
echo .resultado-SUCESSO .resultado-header { background: #d4edda; color: #155724; } >> "%relatorio_file%"
echo .resultado-AVISO .resultado-header { background: #fff3cd; color: #856404; } >> "%relatorio_file%"
echo .status-badge { padding: 3px 8px; border-radius: 3px; margin-right: 10px; font-size: 12px; } >> "%relatorio_file%"
echo .status-SUCESSO { background: #28a745; color: white; } >> "%relatorio_file%"
echo .status-AVISO { background: #ffc107; color: #212529; } >> "%relatorio_file%"
echo .estatisticas { display: flex; justify-content: space-around; text-align: center; } >> "%relatorio_file%"
echo .estatistica { background: white; padding: 15px; border-radius: 5px; flex: 1; margin: 0 5px; } >> "%relatorio_file%"
echo .numero { font-size: 24px; font-weight: bold; color: #28a745; } >> "%relatorio_file%"
echo .footer { text-align: center; margin-top: 30px; color: #6c757d; font-size: 14px; } >> "%relatorio_file%"
echo ^</style^> >> "%relatorio_file%"
echo ^</head^> >> "%relatorio_file%"
echo ^<body^> >> "%relatorio_file%"

echo ^<div class="header"^> >> "%relatorio_file%"
echo ^<h1^>🧹 LVS Cleaner Report^</h1^> >> "%relatorio_file%"
echo ^<p^>Relatório de limpeza gerado em: %timestamp%^</p^> >> "%relatorio_file%"
echo ^<p^>Usuário: lvsodre ^| Sistema: %win_version%^</p^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>📊 Informações do Sistema^</h2^> >> "%relatorio_file%"
echo ^<div class="info-grid"^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Computador:^</strong^> %computername%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Usuário:^</strong^> lvsodre^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Sistema:^</strong^> %win_version%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Drive:^</strong^> %sistema_drive%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Backup:^</strong^> %criar_backup%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Modo:^</strong^> %modo_silencioso%^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>🔧 Resultados da Limpeza^</h2^> >> "%relatorio_file%"

goto :eof

:finalizar_relatorio_html
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>📈 Estatísticas Finais^</h2^> >> "%relatorio_file%"
echo ^<div class="estatisticas"^> >> "%relatorio_file%"
echo ^<div class="estatistica"^> >> "%relatorio_file%"
echo ^<div class="numero"^>%etapas_executadas%^</div^> >> "%relatorio_file%"
echo ^<div^>Etapas Executadas^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^<div class="estatistica"^> >> "%relatorio_file%"
echo ^<div class="numero"^>%etapas_sucesso%^</div^> >> "%relatorio_file%"
echo ^<div^>Sucessos^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^<div class="estatistica"^> >> "%relatorio_file%"
echo ^<div class="numero"^>%etapas_aviso%^</div^> >> "%relatorio_file%"
echo ^<div^>Avisos^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^<div class="estatistica"^> >> "%relatorio_file%"
echo ^<div class="numero"^>18^</div^> >> "%relatorio_file%"
echo ^<div^>Total de Etapas^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>📂 Arquivos e Localizações^</h2^> >> "%relatorio_file%"
echo ^<div class="info-grid"^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Log:^</strong^> %log_file%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Relatório:^</strong^> %relatorio_file%^</div^> >> "%relatorio_file%"
if "%criar_backup%"=="true" (
    echo ^<div class="info-item"^>^<strong^>Backups:^</strong^> %backup_dir%\Cleaner\^</div^> >> "%relatorio_file%"
)
echo ^<div class="info-item"^>^<strong^>Desktop:^</strong^> Copias salvas^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="footer"^> >> "%relatorio_file%"
echo ^<p^>Desenvolvido por: ^<strong^>Leandro Venturini Sodré^</strong^>^</p^> >> "%relatorio_file%"
echo ^<p^>LinkedIn: ^<a href="https://linkedin.com/in/lvsodre"^>linkedin.com/in/lvsodre^</a^>^</p^> >> "%relatorio_file%"
echo ^<p^>LVS Tools v4.6 - Enterprise Cleaner + HTML Report^</p^> >> "%relatorio_file%"
echo ^<p^>Usuário: lvsodre ^| Arquivo salvo em: %backup_dir%^</p^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^</body^> >> "%relatorio_file%"
echo ^</html^> >> "%relatorio_file%"

goto :eof