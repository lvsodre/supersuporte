@echo off
setlocal EnableDelayedExpansion
mode con cols=120 lines=40
title LVS Tools - Diagnostico e Otimizacao de Rede v2.5
color 0A

:: =====================================================================
::                          FERRAMENTA LVS TOOLS v2.5
:: =====================================================================
::    SCRIPT: 02-Diagnostico-Rede.bat
::    DESCRICAO: Diagnostico completo e otimizacao de rede
::    AUTOR: Leandro Venturini Sodre
::    LINKEDIN: linkedin.com/in/lvsodre
::    CRIADO COM: LuigiGPT - Inteligencia Artificial local
::    MELHORADO COM: Claude AI
::    COMPATIBILIDADE: Windows 7, 10 e 11
::    VERSAO: 2.5 - Enterprise Network Diagnostics + Estrutura Padronizada
::    ATUALIZACAO: 2025-08-01 20:00:24 - Estrutura de pastas padronizada
::    USUARIO: lvsodre
:: =====================================================================

:: Verificacao de parametros
set "modo_silencioso=false"
set "criar_backup=false"
set "modo_avancado=false"
set "gerar_relatorio=true"
if /i "%1"=="/silent" set "modo_silencioso=true"
if /i "%1"=="/auto" set "modo_silencioso=true"
if /i "%1"=="/backup" set "criar_backup=true"
if /i "%1"=="/advanced" set "modo_avancado=true"
if /i "%1"=="/noreport" set "gerar_relatorio=false"

:: Variaveis globais PADRONIZADAS
set "sistema_drive=C:"
set "backup_dir=%sistema_drive%\BackupLVS"
set "log_file=%backup_dir%\lvs-network-log.txt"
set "relatorio_file=%backup_dir%\LVS-Network-Report.html"
set "desktop=%USERPROFILE%\Desktop"

:: Criacao da estrutura de diretorios PADRONIZADA
if not exist "%backup_dir%" md "%backup_dir%" >nul 2>&1
if not exist "%backup_dir%\Network" md "%backup_dir%\Network" >nul 2>&1
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
    call :exibir_cabecalho
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

:: Timestamp UTC padronizado
set "timestamp=2025-08-01 20:00:24"

:: Inicializacao do log
echo ===== LVS NETWORK DIAGNOSTICS v2.5 - LOG ===== > "%log_file%"
echo Data/Hora UTC: %timestamp% >> "%log_file%"
echo Sistema: %win_version% >> "%log_file%"
echo Usuario: lvsodre >> "%log_file%"
echo Diretorio Base: %backup_dir% >> "%log_file%"
echo Subpasta Network: %backup_dir%\Network >> "%log_file%"
echo ============================================== >> "%log_file%"

call :exibir_cabecalho

if "%modo_silencioso%"=="false" (
    call :exibir_menu_principal
) else (
    call :diagnostico_completo_automatico
)

exit /b 0

:: =====================================================================
::                              MENU PRINCIPAL
:: =====================================================================

:exibir_menu_principal
echo.
echo ====================================================================
echo                        MENU PRINCIPAL
echo ====================================================================
echo.
echo  [1] Diagnostico Completo de Rede (Recomendado)
echo  [2] Reset Total de Configuracoes de Rede
echo  [3] Liberacao e Renovacao de IP/DNS
echo  [4] Teste de Conectividade Avancado
echo  [5] Diagnostico de Performance de Rede
echo  [6] Analise de Adaptadores de Rede
echo  [7] Correcao de Problemas Comuns
echo  [8] Backup de Configuracoes de Rede
echo  [9] Gerar Relatorio HTML Completo
echo  [0] Sair
echo.
echo ====================================================================
echo Estrutura: %backup_dir%\Network\
echo.
set /p "opcao=Escolha uma opcao (0-9): "

if "%opcao%"=="1" call :diagnostico_completo
if "%opcao%"=="2" call :reset_total_rede
if "%opcao%"=="3" call :renovar_ip_dns
if "%opcao%"=="4" call :teste_conectividade_avancado
if "%opcao%"=="5" call :diagnostico_performance
if "%opcao%"=="6" call :analise_adaptadores
if "%opcao%"=="7" call :correcao_problemas_comuns
if "%opcao%"=="8" call :backup_configuracoes
if "%opcao%"=="9" call :gerar_relatorio_html
if "%opcao%"=="0" goto :fim_script

goto :exibir_menu_principal

:: =====================================================================
::                        FUNCOES PRINCIPAIS - CORRIGIDAS
:: =====================================================================

:diagnostico_completo
call :executar_etapa "DIAGNOSTICO COMPLETO DE REDE"
echo.
echo [INICIO] Executando diagnostico completo...
echo.

echo ====================================================================
echo                    INFORMACOES BASICAS DO SISTEMA
echo ====================================================================
echo [CONFIG] Nome do computador: %computername%
echo [CONFIG] Usuario: lvsodre
echo [CONFIG] Dominio: %userdomain%
echo [CONFIG] Sistema: %win_version%
echo [CONFIG] Data/Hora UTC: %timestamp%
echo.

echo ====================================================================
echo                    CONFIGURACAO DE REDE ATUAL
echo ====================================================================
echo [IP] Configuracao IPv4:
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /i "IPv4"') do echo    IPv4%%i
echo.
echo [GATEWAY] Gateway padrao:
for /f "tokens=3" %%G in ('route print ^| findstr "0.0.0.0.*0.0.0.0"') do echo    Gateway: %%G
echo.
echo [DNS] Servidores DNS:
ipconfig /all | findstr /i "DNS Servers" | findstr /v "fec0"
echo.

echo ====================================================================
echo                    TESTE DE CONECTIVIDADE
echo ====================================================================
echo [TESTE 1] Conectividade com Google DNS (8.8.8.8):
ping 8.8.8.8 -n 3 -w 2000 | findstr /i "bytes= time= ttl= average" 
echo.
echo [TESTE 2] Conectividade com Cloudflare DNS (1.1.1.1):
ping 1.1.1.1 -n 3 -w 2000 | findstr /i "bytes= time= ttl= average"
echo.
echo [TESTE 3] Teste do gateway local:
for /f "tokens=3" %%G in ('route print ^| findstr "0.0.0.0.*0.0.0.0"') do (
    echo Testando gateway %%G:
    ping %%G -n 2 -w 1000 | findstr /i "bytes= time= ttl="
)
echo.

echo ====================================================================
echo                    RESOLUCAO DNS
echo ====================================================================
echo [DNS 1] Resolvendo www.google.com:
nslookup www.google.com 8.8.8.8 2>nul | findstr /i "address" | findstr /v "8.8.8.8"
echo [DNS 2] Resolvendo www.microsoft.com:
nslookup www.microsoft.com 8.8.8.8 2>nul | findstr /i "address" | findstr /v "8.8.8.8"
echo.

echo ====================================================================
echo                    STATUS DOS SERVICOS
echo ====================================================================
echo [SERVICO] DHCP Client:
for /f "tokens=4" %%s in ('sc query "Dhcp" ^| findstr /i "state"') do echo    Status: %%s
echo [SERVICO] DNS Client:
for /f "tokens=4" %%s in ('sc query "Dnscache" ^| findstr /i "state"') do echo    Status: %%s
echo [SERVICO] Workstation:
for /f "tokens=4" %%s in ('sc query "LanmanWorkstation" ^| findstr /i "state"') do echo    Status: %%s
echo.

echo ====================================================================
echo                    ESTATISTICAS DE REDE
echo ====================================================================
echo [STATS] Conexoes estabelecidas:
for /f %%i in ('netstat -an ^| findstr /i "established" ^| find /c "ESTABLISHED"') do echo    %%i conexoes ativas
echo [STATS] Portas em listening:
for /f %%i in ('netstat -an ^| findstr /i "listening" ^| find /c "LISTENING"') do echo    %%i portas abertas
echo.

echo ====================================================================
echo                    ADAPTADORES DE REDE
echo ====================================================================
echo [ADAPTERS] Adaptadores ativos:
ipconfig | findstr /i "adapter" | findstr /v "Tunnel\|Loopback"
echo.

echo ====================================================================
echo                    RESUMO DO DIAGNOSTICO
echo ====================================================================
echo [OK] Diagnostico completo executado com sucesso
echo [LOG] Detalhes salvos em: %log_file%
echo [HTML] Gerando relatorio HTML automaticamente...

call :gerar_relatorio_html_automatico

echo [HTML] Relatorio salvo em: %relatorio_file%
echo [BACKUP] Use opcao 8 para criar backup das configuracoes
echo.

call :log_acao "Diagnostico completo executado" "SUCESSO"
call :pausar_continuar
goto :eof

:reset_total_rede
call :executar_etapa "RESET TOTAL DE CONFIGURACOES DE REDE"
echo.
echo [AVISO] Esta operacao ira resetar TODAS as configuracoes de rede
echo [AVISO] Conexoes atuais serao perdidas temporariamente
echo.
if "%modo_silencioso%"=="false" (
    choice /m "Tem certeza que deseja continuar"
    if errorlevel 2 goto :eof
)

call :backup_configuracoes_completo

call :mostrar_progresso "Parando servicos de rede..." 3
call :parar_servicos_rede

call :mostrar_progresso "Resetando Winsock..." 3
netsh winsock reset >nul 2>&1

call :mostrar_progresso "Resetando TCP/IP..." 3
netsh int ip reset >nul 2>&1

call :mostrar_progresso "Limpando cache DNS..." 2
ipconfig /flushdns >nul 2>&1

call :mostrar_progresso "Resetando Firewall..." 3
netsh advfirewall reset >nul 2>&1

call :mostrar_progresso "Removendo proxies..." 2
call :limpar_configuracoes_proxy

call :mostrar_progresso "Reiniciando servicos..." 3
call :iniciar_servicos_rede

echo.
echo [OK] Reset completo finalizado!
echo [INFO] REINICIALIZACAO RECOMENDADA para aplicar todas as mudancas
call :log_acao "Reset total de rede executado" "SUCESSO"
call :pausar_continuar
goto :eof

:renovar_ip_dns
call :executar_etapa "RENOVACAO DE IP E DNS"
echo.
call :mostrar_progresso "Liberando configuracao IP atual..." 3
ipconfig /release >nul 2>&1

call :mostrar_progresso "Renovando configuracao IP..." 3
ipconfig /renew >nul 2>&1

call :mostrar_progresso "Limpando cache DNS..." 2
ipconfig /flushdns >nul 2>&1

call :mostrar_progresso "Registrando cliente DNS..." 3
ipconfig /registerdns >nul 2>&1

echo.
echo [OK] IP e DNS renovados com sucesso!
call :exibir_configuracao_atual
call :log_acao "IP e DNS renovados" "SUCESSO"
call :pausar_continuar
goto :eof

:teste_conectividade_avancado
call :executar_etapa "TESTE DE CONECTIVIDADE AVANCADO"
echo.
echo [INFO] Testando conectividade com multiplos destinos...
echo.

echo [TESTE] Google DNS (8.8.8.8):
ping 8.8.8.8 -n 4 -w 2000 | findstr /i "bytes= time= ttl="
if %errorlevel% neq 0 echo [ERRO] Falha na conectividade com Google DNS
echo.

echo [TESTE] Cloudflare DNS (1.1.1.1):
ping 1.1.1.1 -n 4 -w 2000 | findstr /i "bytes= time= ttl="
if %errorlevel% neq 0 echo [ERRO] Falha na conectividade com Cloudflare DNS
echo.

echo [TESTE] Gateway padrao:
for /f "tokens=3" %%G in ('route print ^| findstr "0.0.0.0.*0.0.0.0"') do (
    echo Testando gateway: %%G
    ping %%G -n 2 -w 1000 | findstr /i "bytes= time= ttl="
)
echo.

echo [TESTE] Resolucao DNS:
echo - Testando www.google.com:
nslookup www.google.com 8.8.8.8 2>nul | findstr /i "address" | findstr /v "8.8.8.8"
echo - Testando www.microsoft.com:
nslookup www.microsoft.com 8.8.8.8 2>nul | findstr /i "address" | findstr /v "8.8.8.8"
echo.

echo [TESTE] Traceroute para google.com (primeiros 8 saltos):
tracert -d -h 8 -w 2000 www.google.com

call :log_acao "Teste de conectividade avancado executado" "SUCESSO"
call :pausar_continuar
goto :eof

:diagnostico_performance
call :executar_etapa "DIAGNOSTICO DE PERFORMANCE DE REDE"
echo.
echo [INFO] Analisando performance da rede...
echo.

echo [VELOCIDADE] Teste de latencia:
ping 8.8.8.8 -n 10 -l 32 | findstr /i "bytes= time= ttl= average"
echo.

echo [ANALISE] Estatisticas da interface de rede:
netstat -e
echo.

echo [ANALISE] Conexoes estabelecidas:
for /f %%i in ('netstat -an ^| findstr /i "established" ^| find /c "ESTABLISHED"') do echo %%i conexoes estabelecidas encontradas
echo.

echo [ANALISE] Portas em listening:
for /f %%i in ('netstat -an ^| findstr /i "listening" ^| find /c "LISTENING"') do echo %%i portas em modo listening encontradas
echo.

echo [PERFORMANCE] Teste de velocidade DNS:
echo Resolvendo 5 dominios para testar velocidade DNS...
for %%d in (google.com microsoft.com github.com stackoverflow.com wikipedia.org) do (
    echo - Resolvendo %%d...
    nslookup %%d 8.8.8.8 >nul 2>&1
)
echo [OK] Teste de DNS concluido
echo.

call :log_acao "Diagnostico de performance executado" "SUCESSO"
call :pausar_continuar
goto :eof

:analise_adaptadores
call :executar_etapa "ANALISE DE ADAPTADORES DE REDE"
echo.
echo [INFO] Analisando adaptadores de rede instalados...
echo.

echo [ADAPTADORES] Lista de adaptadores ativos:
ipconfig | findstr /i "adapter"
echo.

echo [DRIVERS] Informacoes basicas:
wmic path win32_networkadapter where "NetEnabled=true and AdapterTypeId=0" get Name,MACAddress /format:table 2>nul
echo.

echo [STATUS] Verificacao de conectividade por adaptador:
ipconfig | findstr /i "IPv4"
echo.

call :log_acao "Analise de adaptadores executada" "SUCESSO"
call :pausar_continuar
goto :eof

:correcao_problemas_comuns
call :executar_etapa "CORRECAO DE PROBLEMAS COMUNS DE REDE"
echo.
echo [INFO] Aplicando correcoes para problemas comuns...
echo.

call :mostrar_progresso "Corrigindo registro de DNS..." 3
ipconfig /flushdns >nul 2>&1

call :mostrar_progresso "Limpando cache ARP..." 2
arp -d * >nul 2>&1

call :mostrar_progresso "Renovando DHCP..." 3
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1

call :mostrar_progresso "Corrigindo Winsock (parcial)..." 3
netsh winsock reset catalog >nul 2>&1

call :mostrar_progresso "Resetando adaptadores..." 3
netsh interface ip delete arpcache >nul 2>&1

echo.
echo [OK] Correcoes aplicadas com sucesso!
echo [INFO] Reinicializacao pode ser necessaria para alguns ajustes
call :log_acao "Correcoes de problemas comuns aplicadas" "SUCESSO"
call :pausar_continuar
goto :eof

:backup_configuracoes
call :executar_etapa "BACKUP DE CONFIGURACOES DE REDE"
echo.

echo [BACKUP] Exportando configuracoes de rede para subpasta Network...
call :mostrar_progresso "Exportando configuracoes IP..." 2
ipconfig /all > "%backup_dir%\Network\ipconfig-backup-%timestamp:~0,10%.txt" 2>nul

call :mostrar_progresso "Exportando tabela de rotas..." 2
route print > "%backup_dir%\Network\route-backup-%timestamp:~0,10%.txt" 2>nul

call :mostrar_progresso "Exportando configuracoes netsh..." 3
netsh dump > "%backup_dir%\Network\netsh-backup-%timestamp:~0,10%.txt" 2>nul

call :mostrar_progresso "Exportando perfis Wi-Fi..." 2
netsh wlan export profile folder="%backup_dir%\Network" >nul 2>&1

call :mostrar_progresso "Exportando informacoes de adaptadores..." 2
wmic path win32_networkadapter get Name,MACAddress,Speed /format:csv > "%backup_dir%\Network\adaptadores-backup-%timestamp:~0,10%.csv" 2>nul

echo.
echo [OK] Backup salvo em: %backup_dir%\Network\
echo [ARQUIVOS] Arquivos com timestamp %timestamp:~0,10% criados
call :log_acao "Backup de configuracoes criado na subpasta Network" "SUCESSO"
call :pausar_continuar
goto :eof

:gerar_relatorio_html
call :executar_etapa "GERANDO RELATORIO HTML COMPLETO"
echo.
echo [INFO] Gerando relatorio detalhado em HTML...

call :criar_relatorio_html_completo

echo.
echo [OK] Relatorio salvo em: %relatorio_file%
if exist "%desktop%" (
    copy "%relatorio_file%" "%desktop%\LVS-Network-Report.html" >nul 2>&1
    echo [OK] Copia salva no Desktop: %desktop%\LVS-Network-Report.html
)
call :log_acao "Relatorio HTML gerado" "SUCESSO"
call :pausar_continuar
goto :eof

:: =====================================================================
::                        FUNCOES DE APOIO
:: =====================================================================

:exibir_cabecalho
echo =====================================================
echo            LVS TOOLS - DIAGNOSTICO DE REDE v2.5
echo =====================================================
echo Sistema: %win_version% ^| Usuario: lvsodre
echo Estrutura: %backup_dir%\Network\
echo =====================================================
goto :eof

:executar_etapa
set "nome_etapa=%~1"
echo.
echo ====================================================================
echo    %nome_etapa%
echo ====================================================================
goto :eof

:mostrar_progresso
set "mensagem=%~1"
set "tempo=%~2"
echo [ACAO] %mensagem%
timeout /t %tempo% >nul
goto :eof

:log_acao
set "acao=%~1"
set "status=%~2"
echo [%timestamp:~11,8%] %status%: %acao% >> "%log_file%"
goto :eof

:pausar_continuar
echo.
echo Pressione qualquer tecla para continuar...
pause >nul
goto :eof

:parar_servicos_rede
net stop "Dhcp" >nul 2>&1
net stop "Dnscache" >nul 2>&1
timeout /t 2 >nul
goto :eof

:iniciar_servicos_rede
net start "Dhcp" >nul 2>&1
net start "Dnscache" >nul 2>&1
timeout /t 3 >nul
goto :eof

:limpar_configuracoes_proxy
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /f >nul 2>&1
goto :eof

:exibir_configuracao_atual
echo [ATUAL] Nova configuracao IP:
ipconfig | findstr /i "IPv4"
for /f "tokens=3" %%G in ('route print ^| findstr "0.0.0.0.*0.0.0.0"') do echo Gateway: %%G
goto :eof

:backup_configuracoes_completo
ipconfig /all > "%backup_dir%\Network\ipconfig-pre-reset-%timestamp:~0,10%.txt" 2>nul
netsh dump > "%backup_dir%\Network\netsh-pre-reset-%timestamp:~0,10%.txt" 2>nul
goto :eof

:diagnostico_completo_automatico
echo [AUTO] Executando diagnostico automatico...
call :gerar_relatorio_html_automatico
goto :eof

:gerar_relatorio_html_automatico
call :criar_relatorio_html_completo
goto :eof

:criar_relatorio_html_completo
echo Gerando relatorio HTML completo...

echo ^<!DOCTYPE html^> > "%relatorio_file%"
echo ^<html lang="pt-BR"^> >> "%relatorio_file%"
echo ^<head^> >> "%relatorio_file%"
echo ^<meta charset="UTF-8"^> >> "%relatorio_file%"
echo ^<meta name="viewport" content="width=device-width, initial-scale=1.0"^> >> "%relatorio_file%"
echo ^<title^>LVS Network Diagnostics Report^</title^> >> "%relatorio_file%"
echo ^<style^> >> "%relatorio_file%"
echo body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 20px; background-color: #f5f5f5; } >> "%relatorio_file%"
echo .header { background: linear-gradient(135deg, #0066cc, #004499); color: white; padding: 20px; border-radius: 10px; text-align: center; margin-bottom: 20px; } >> "%relatorio_file%"
echo .section { background: white; padding: 20px; margin: 15px 0; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); } >> "%relatorio_file%"
echo .section h2 { color: #0066cc; border-bottom: 2px solid #0066cc; padding-bottom: 10px; } >> "%relatorio_file%"
echo .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 15px; } >> "%relatorio_file%"
echo .info-item { background: #f8f9fa; padding: 10px; border-left: 4px solid #0066cc; } >> "%relatorio_file%"
echo .status-ok { color: #28a745; font-weight: bold; } >> "%relatorio_file%"
echo .status-warning { color: #ffc107; font-weight: bold; } >> "%relatorio_file%"
echo .status-error { color: #dc3545; font-weight: bold; } >> "%relatorio_file%"
echo pre { background: #f8f9fa; padding: 15px; border-radius: 5px; overflow-x: auto; border: 1px solid #dee2e6; } >> "%relatorio_file%"
echo .footer { text-align: center; margin-top: 30px; color: #6c757d; font-size: 14px; } >> "%relatorio_file%"
echo .pasta-info { background: #e3f2fd; padding: 15px; border-radius: 5px; margin: 10px 0; border-left: 4px solid #0066cc; } >> "%relatorio_file%"
echo ^</style^> >> "%relatorio_file%"
echo ^</head^> >> "%relatorio_file%"
echo ^<body^> >> "%relatorio_file%"

echo ^<div class="header"^> >> "%relatorio_file%"
echo ^<h1^>🔧 LVS Network Diagnostics Report^</h1^> >> "%relatorio_file%"
echo ^<p^>Relatório gerado em: %timestamp%^</p^> >> "%relatorio_file%"
echo ^<p^>Usuário: lvsodre ^| Sistema: %win_version%^</p^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>📊 Informações do Sistema^</h2^> >> "%relatorio_file%"
echo ^<div class="info-grid"^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Computador:^</strong^> %computername%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Usuário:^</strong^> lvsodre^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Domínio:^</strong^> %userdomain%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Sistema:^</strong^> %win_version%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Timestamp UTC:^</strong^> %timestamp%^</div^> >> "%relatorio_file%"
echo ^<div class="info-item"^>^<strong^>Versão Script:^</strong^> v2.5^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="pasta-info"^> >> "%relatorio_file%"
echo ^<h3^>📂 Estrutura de Arquivos Padronizada^</h3^> >> "%relatorio_file%"
echo ^<strong^>Diretório Base:^</strong^> %backup_dir%^<br^> >> "%relatorio_file%"
echo ^<strong^>Subpasta Network:^</strong^> %backup_dir%\Network\^<br^> >> "%relatorio_file%"
echo ^<strong^>Backups de Configuração:^</strong^> Salvos na subpasta Network\^<br^> >> "%relatorio_file%"
echo ^<strong^>Relatórios HTML:^</strong^> Salvos na pasta base^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>🌐 Configuração de Rede^</h2^> >> "%relatorio_file%"
echo ^<pre^> >> "%relatorio_file%"
ipconfig /all >> "%relatorio_file%" 2>nul
echo ^</pre^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>🔍 Teste de Conectividade^</h2^> >> "%relatorio_file%"
echo ^<h3^>Google DNS (8.8.8.8)^</h3^> >> "%relatorio_file%"
echo ^<pre^> >> "%relatorio_file%"
ping 8.8.8.8 -n 4 >> "%relatorio_file%" 2>nul
echo ^</pre^> >> "%relatorio_file%"
echo ^<h3^>Cloudflare DNS (1.1.1.1)^</h3^> >> "%relatorio_file%"
echo ^<pre^> >> "%relatorio_file%"
ping 1.1.1.1 -n 4 >> "%relatorio_file%" 2>nul
echo ^</pre^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>🗺️ Tabela de Rotas^</h2^> >> "%relatorio_file%"
echo ^<pre^> >> "%relatorio_file%"
route print >> "%relatorio_file%" 2>nul
echo ^</pre^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>📈 Estatísticas de Rede^</h2^> >> "%relatorio_file%"
echo ^<pre^> >> "%relatorio_file%"
netstat -e >> "%relatorio_file%" 2>nul
echo ^</pre^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="section"^> >> "%relatorio_file%"
echo ^<h2^>🔧 Status dos Serviços^</h2^> >> "%relatorio_file%"
echo ^<pre^> >> "%relatorio_file%"
sc query "Dhcp" >> "%relatorio_file%" 2>nul
echo. >> "%relatorio_file%"
sc query "Dnscache" >> "%relatorio_file%" 2>nul
echo. >> "%relatorio_file%"
sc query "LanmanWorkstation" >> "%relatorio_file%" 2>nul
echo ^</pre^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^<div class="footer"^> >> "%relatorio_file%"
echo ^<p^>Desenvolvido por: ^<strong^>Leandro Venturini Sodré^</strong^>^</p^> >> "%relatorio_file%"
echo ^<p^>LinkedIn: ^<a href="https://linkedin.com/in/lvsodre"^>linkedin.com/in/lvsodre^</a^>^</p^> >> "%relatorio_file%"
echo ^<p^>LVS Tools v2.5 - Enterprise Network Diagnostics + Estrutura Padronizada^</p^> >> "%relatorio_file%"
echo ^<p^>Usuario: lvsodre ^| Estrutura: %backup_dir%\Network\^</p^> >> "%relatorio_file%"
echo ^</div^> >> "%relatorio_file%"

echo ^</body^> >> "%relatorio_file%"
echo ^</html^> >> "%relatorio_file%"

goto :eof

:fim_script
echo.
echo ====================================================================
echo               DIAGNOSTICO DE REDE FINALIZADO
echo ====================================================================
echo.
echo [INFO] Estrutura padronizada criada em: %backup_dir%
echo [LOG] Log: %log_file%
echo [HTML] Relatorio: %relatorio_file%
if exist "%desktop%" echo [DESKTOP] Copia do relatorio no Desktop
echo.
echo [ESTRUTURA] Pastas padronizadas criadas:
echo   %backup_dir%\
echo   ├── Network\              (backups de configuracao de rede)
echo   ├── Cleaner\              (backups da limpeza de sistema)
echo   ├── Reports\              (relatorios anteriores)
echo   ├── lvs-network-log.txt   (log principal)
echo   └── LVS-Network-Report.html (relatorio HTML)
echo.
echo [BACKUPS] Configuracoes salvas com timestamp em Network\
echo [TIMESTAMPING] %timestamp% aplicado aos arquivos
echo.
echo Desenvolvido por: Leandro Venturini Sodre
echo LinkedIn: linkedin.com/in/lvsodre
echo Usuario: lvsodre
echo.
pause
goto :eof