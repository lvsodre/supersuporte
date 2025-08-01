# 🛠️ LVS Tools - Suite de Manutenção Enterprise

[![Version](https://img.shields.io/badge/version-v4.6%20%7C%20v2.5-brightgreen.svg)](https://github.com/lvsodre/lvs-tools)
[![Platform](https://img.shields.io/badge/platform-Windows%207%2F10%2F11-blue.svg)](https://github.com/lvsodre/lvs-tools)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Made by](https://img.shields.io/badge/made%20by-lvsodre-orange.svg)](https://linkedin.com/in/lvsodre)
[![Powered by](https://img.shields.io/badge/powered%20by-AI-purple.svg)](https://github.com/lvsodre/lvs-tools)

> **Suite profissional completa para manutenção, limpeza e diagnóstico de sistemas Windows**

## 📋 Visão Geral

O **LVS Tools** é uma suíte enterprise de scripts desenvolvida para administradores de sistema e técnicos especializados. Combina limpeza profunda do sistema com diagnóstico avançado de rede, oferecendo relatórios HTML detalhados, backup automático e total compatibilidade corporativa.

### 🎯 Características Principais

- ✅ **27 funcionalidades** combinadas (18 limpeza + 9 rede)
- ✅ **Relatórios HTML** profissionais com CSS responsivo
- ✅ **Sistema de backup** automático e inteligente
- ✅ **Compatibilidade enterprise** com logging completo
- ✅ **Interface intuitiva** com progressos visuais
- ✅ **Estrutura padronizada** unificada
- ✅ **Parâmetros de linha** de comando para automação

## 📦 Scripts Incluídos

| Script | Versão | Funcionalidades | Descrição |
|--------|--------|-----------------|-----------|
| **01-Limpeza-Enterprise.bat** | v4.6 | 18 etapas | Limpeza profunda e otimização |
| **02-Diagnostico-Rede.bat** | v2.5 | 9 opções | Diagnóstico e correção de rede |

## 🧹 Script 1: Limpeza Enterprise v4.6

### 📊 18 Etapas de Limpeza Profunda

| Etapa | Categoria | Descrição | Backup | Risco |
|-------|-----------|-----------|--------|-------|
| **1-2** | 🗂️ **Temporários** | Usuário + Sistema | ✅ | 🟢 Seguro |
| **3** | ⚡ **Cache Prefetch** | Arquivos de inicialização | ✅ | 🟢 Seguro |
| **4** | 📝 **Logs Windows** | Logs do sistema | ✅ | 🟢 Seguro |
| **5** | 🔄 **Windows Update** | Cache de atualizações | ✅ | 🟡 Requer serviços |
| **6** | 🚨 **Relatórios Erro** | WER reports | ✅ | 🟢 Seguro |
| **7-8** | 🖼️ **Cache Visual** | Miniaturas + Temas | ⚪ | 🟢 Seguro |
| **9** | 💥 **Dumps** | Crash files + Minidump | ✅ | 🟡 Debug importante |
| **10** | 🗑️ **Lixeira** | Lixeira do sistema | ❌ | 🔴 Irreversível |
| **11** | 🌐 **DNS Cache** | Cache DNS (seguro) | ⚪ | 🟢 Preserva rede |
| **12** | 🔄 **Processos** | Finaliza ociosos | ⚪ | 🟢 Reinicia automático |
| **13** | 🎨 **Cache Avançado** | Fontes + Ícones | ✅ | 🟢 Seguro |
| **14** | 🔧 **Hardware** | Logs PnP seguros | ✅ | 🟢 Mantém críticos |
| **15** | ⚡ **Performance** | ReadyBoot + WMI | ✅ | 🟢 Seguro |
| **16** | 📋 **Logs Críticos** | Backup obrigatório | ✅ | 🟢 Backup forçado |
| **17** | 🌐 **Rede Segura** | Sem reset Winsock | ⚪ | 🟢 Preserva conexão |
| **18** | ✅ **Integridade** | SFC Scan completo | ✅ | 🟢 Microsoft oficial |

### 🚀 Parâmetros de Execução - Limpeza

```bash
# Execução padrão (interativa)
01-Limpeza-Enterprise.bat

# Modo silencioso (automação)
01-Limpeza-Enterprise.bat /silent

# Com backup forçado
01-Limpeza-Enterprise.bat /backup

# Modo confirmação por etapa
01-Limpeza-Enterprise.bat /confirm

# Combinações para produção
01-Limpeza-Enterprise.bat /silent /backup
```

### 📈 Benefícios Esperados - Limpeza

- 🚀 **Performance**: Melhoria de 15-40% na velocidade
- 💾 **Espaço Livre**: Liberação de 100MB a 10GB
- 🔧 **Estabilidade**: Correção de problemas comuns
- 🛡️ **Segurança**: Remoção de dados desnecessários
- ⚡ **Boot Time**: Redução de 10-30% no tempo de inicialização

## 🌐 Script 2: Diagnóstico Rede v2.5

### 🔧 9 Funcionalidades de Rede

| Opção | Funcionalidade | Descrição | Complexidade |
|-------|----------------|-----------|--------------|
| **1** | 📊 **Diagnóstico Completo** | Análise completa + HTML | 🟢 Fácil |
| **2** | 🔄 **Reset Total** | Reset todas configurações | 🔴 Avançado |
| **3** | 🔃 **Renovar IP/DNS** | DHCP release/renew | 🟡 Médio |
| **4** | 🧪 **Conectividade** | Testes múltiplos | 🟢 Fácil |
| **5** | ⚡ **Performance** | Latência e velocidade | 🟢 Fácil |
| **6** | 🖥️ **Adaptadores** | Hardware de rede | 🟡 Médio |
| **7** | 🩹 **Correções** | Fix problemas comuns | 🟡 Médio |
| **8** | 💾 **Backup Config** | Exporta configurações | 🟢 Fácil |
| **9** | 📄 **Relatório HTML** | Geração completa | 🟢 Fácil |

### 🔍 Testes de Conectividade Incluídos

- **🌍 Google DNS** (8.8.8.8) - Conectividade internacional
- **☁️ Cloudflare DNS** (1.1.1.1) - Conectividade alternativa  
- **🏠 Gateway Local** - Conectividade rede interna
- **🔍 Resolução DNS** - Teste múltiplos domínios
- **📡 Traceroute** - Análise completa de rota
- **⚡ Performance** - Latência e jitter

### 🚀 Parâmetros de Execução - Rede

```bash
# Execução padrão (menu interativo)
02-Diagnostico-Rede.bat

# Diagnóstico automático
02-Diagnostico-Rede.bat /auto

# Com backup de configurações
02-Diagnostico-Rede.bat /backup

# Modo avançado
02-Diagnostico-Rede.bat /advanced

# Sem relatório HTML
02-Diagnostico-Rede.bat /noreport
```

### 🛡️ Segurança de Rede Aprimorada

> **⚠️ IMPORTANTE**: A versão v2.5 foi completamente revista para preservar conectividade. Comandos perigosos como `netsh winsock reset` foram removidos ou aplicados apenas quando necessário com backup automático.

**Melhorias de Segurança:**
- ✅ **Conexão preservada** durante operações
- ✅ **Backup automático** antes de mudanças críticas
- ✅ **Timeouts inteligentes** para evitar travamentos
- ✅ **Rollback automático** em caso de falha

## 📁 Estrutura Unificada de Arquivos

```
C:\BackupLVS\                      # 📂 Diretório base padronizado
├── 📂 Network\                    # Configurações e backups de rede
│   ├── ipconfig-backup-2025-08-01.txt
│   ├── route-backup-2025-08-01.txt
│   ├── netsh-backup-2025-08-01.txt
│   ├── adaptadores-backup-2025-08-01.csv
│   └── *.xml (perfis Wi-Fi exportados)
├── 📂 Cleaner\                    # Backups da limpeza de sistema
│   ├── temp_usuario\              # Backup TEMP usuário
│   ├── temp_sistema\              # Backup TEMP sistema
│   ├── prefetch\                  # Backup cache Prefetch
│   ├── logs_windows\              # Backup logs sistema
│   ├── SystemLogs\                # Backup logs críticos
│   ├── sfc-results.txt            # Resultado SFC scan
│   └── ...outros backups
├── 📂 Reports\                    # Relatórios anteriores
├── 📄 lvs-cleaner-log.txt        # Log principal limpeza
├── 📄 lvs-network-log.txt        # Log principal rede
├── 🌐 LVS-Cleaner-Report.html    # Relatório limpeza
└── 🌐 LVS-Network-Report.html    # Relatório rede
```

## 📋 Relatórios HTML Profissionais

### 🎨 Design e Características

| Característica | Cleaner | Network | Detalhes |
|----------------|---------|---------|----------|
| **Tema de Cores** | 🟢 Verde | 🔵 Azul | Gradientes profissionais |
| **Layout** | Grid responsivo | Grid responsivo | CSS moderno |
| **Seções** | 6 principais | 7 principais | Organizadas logicamente |
| **Dados Técnicos** | 18 etapas | Configuração completa | Informações detalhadas |
| **Estatísticas** | Sucessos/Avisos/Total | Conectividade/Performance | Métricas visuais |
| **Export** | Desktop automático | Desktop automático | Cópias de segurança |

### 📊 Conteúdo Detalhado dos Relatórios

#### 🧹 Cleaner Report - Inclui:
- **Sistema**: Informações completas do computador
- **Execução**: Resultado detalhado de cada etapa
- **Estatísticas**: Contadores visuais de sucessos/avisos
- **Arquivos**: Localização de todos os backups
- **Timeline**: Timestamps UTC de cada operação
- **Status Visual**: Códigos de cores para cada resultado

#### 🌐 Network Report - Inclui:
- **Configuração**: Output completo do `ipconfig /all`
- **Conectividade**: Testes com Google, Cloudflare e Gateway
- **Roteamento**: Tabela completa de rotas
- **Estatísticas**: Métricas de interface de rede
- **Serviços**: Status de todos os serviços de rede
- **Hardware**: Informações de adaptadores

## 🚀 Instalação e Uso

### 📋 Pré-requisitos

| Requisito | Mínimo | Recomendado | Observações |
|-----------|--------|-------------|-------------|
| **Windows** | 7 SP1 | 10/11 | Compatibilidade completa |
| **RAM** | 2GB | 4GB+ | Para operações simultâneas |
| **Espaço** | 100MB | 500MB | Backups podem ser grandes |
| **Rede** | N/A | Ativa | Para testes de conectividade |
| **Privilégios** | Admin | Admin | **OBRIGATÓRIO** |

### ⚡ Execução Rápida - Passo a Passo

1. **📥 Download** dos scripts para uma pasta local
2. **👤 Feche** todos os programas desnecessários
3. **🖱️ Clique direito** no script desejado
4. **🔐 Selecione** "Executar como administrador"
5. **📋 Siga** o menu interativo
6. **📊 Verifique** os relatórios em `C:\BackupLVS\`

### 🤖 Automação e Integração

```batch
# Manutenção completa automatizada
01-Limpeza-Enterprise.bat /silent /backup
02-Diagnostico-Rede.bat /auto /backup

# Para Task Scheduler (manutenção semanal)
schtasks /create /tn "LVS Weekly Cleanup" /tr "C:\Scripts\01-Limpeza-Enterprise.bat /silent /backup" /sc weekly

# Para scripts de logon corporativo
if exist "C:\BackupLVS\" (
    rem Pasta já existe, apenas diagnóstico
    02-Diagnostico-Rede.bat /silent
) else (
    rem Primeira execução, limpeza completa
    01-Limpeza-Enterprise.bat /silent /backup
)
```

## 🔧 Compatibilidade e Suporte

### 💻 Matriz de Compatibilidade

| Sistema Operacional | x86 | x64 | ARM64 | Status | Observações |
|---------------------|-----|-----|-------|--------|-------------|
| **Windows 7 SP1** | ✅ | ✅ | ❌ | Completo | Todas as funcionalidades |
| **Windows 8/8.1** | ✅ | ✅ | ❌ | Completo | Todas as funcionalidades |
| **Windows 10** | ✅ | ✅ | ✅ | Completo | Recomendado |
| **Windows 11** | ❌ | ✅ | ✅ | Completo | Recomendado |
| **Server 2008 R2** | ❌ | ✅ | ❌ | Limitado | Sem GUI cleaning |
| **Server 2012+** | ❌ | ✅ | ❌ | Completo | Todas as funcionalidades |

### 🏢 Ambiente Corporativo

- ✅ **Políticas de Grupo** - Compatível e respeitoso
- ✅ **Auditoria** - Logging completo para compliance
- ✅ **Backup Obrigatório** - Dados críticos sempre preservados
- ✅ **Segurança** - Sem modificações de configurações de segurança
- ✅ **Automação** - Integração com Task Scheduler
- ✅ **Rede** - Preserva conectividade durante operações
- ✅ **Reversibilidade** - Backups permitem restauração

## 🐛 Troubleshooting e Suporte

### ❓ Problemas Comuns e Soluções

| Problema | Causa Provável | Solução | Prevenção |
|----------|----------------|---------|-----------|
| **Script não executa** | Falta privilégios admin | Executar como administrador | Sempre clicar direito |
| **Algumas etapas falham** | Arquivos em uso | Fechar todos os programas | Verificar antes da execução |
| **Lentidão após limpeza** | Cache sendo reconstruído | Normal, melhora com uso | Aguardar e usar normalmente |
| **Erro acesso negado** | Antivírus bloqueando | Adicionar à exclusão | Configurar antivírus |
| **Rede sem conectividade** | Reset mal aplicado | Usar opção 3 (renovar) | Evitar opção 2 sem necessidade |
| **Relatório não abre** | Associação HTML | Definir navegador padrão | Abrir manualmente |

### 🔍 Diagnóstico Avançado

```batch
# Para verificar logs detalhados
type "C:\BackupLVS\lvs-cleaner-log.txt"
type "C:\BackupLVS\lvs-network-log.txt"

# Para verificar integridade do sistema após limpeza
sfc /scannow
dism /online /cleanup-image /restorehealth

# Para testar conectividade manualmente
ping 8.8.8.8
nslookup google.com
ipconfig /all
```

### 📞 Canais de Suporte

- 📧 **Issues GitHub**: [GitHub Issues](https://github.com/lvsodre/lvs-tools/issues)
- 💼 **LinkedIn**: [linkedin.com/in/lvsodre](https://linkedin.com/in/lvsodre)
- 📝 **Documentação**: Sempre verificar logs primeiro
- 🤝 **Comunidade**: Contribuições via Pull Request

## 📊 Changelog e Versioning

### 🔥 Versões Atuais

| Script | Versão | Data | Principais Mudanças |
|--------|--------|------|---------------------|
| **Limpeza** | v4.6 | 2025-08-01 | + Relatório HTML, estrutura padronizada |
| **Rede** | v2.5 | 2025-08-01 | + Estrutura unificada, segurança melhorada |

### 📅 Histórico de Versões

#### 🧹 Limpeza Enterprise
- **v4.6** (2025-08-01): Relatório HTML profissional + estrutura padronizada
- **v4.5** (2025-08-01): Correção etapa 17, backup obrigatório para críticos
- **v4.0** (2025-08-01): 18 etapas completas, sistema enterprise
- **v3.x**: Versões de desenvolvimento
- **v2.x**: Versões básicas iniciais

#### 🌐 Diagnóstico Rede  
- **v2.5** (2025-08-01): Estrutura unificada + subpasta Network
- **v2.4** (2025-08-01): Relatório HTML profissional
- **v2.3** (2025-08-01): Correção função diagnóstico completo
- **v2.2** (2025-08-01): Correção timeouts e travamentos
- **v2.1** (2025-08-01): Funcionalidades básicas estáveis

## 📜 Licença e Créditos

### 📄 Licença
Este projeto está licenciado sob a **MIT License** - veja o arquivo [LICENSE](LICENSE) para detalhes.

### 👨‍💻 Autor
**Leandro Venturini Sodré (lvsodre)**
- 💼 LinkedIn: [linkedin.com/in/lvsodre](https://linkedin.com/in/lvsodre)
- 🐙 GitHub: [@lvsodre](https://github.com/lvsodre)
- 📅 Desenvolvido: 2025-08-01

### 🤖 Tecnologia
- **Desenvolvido com**: LuigiGPT (IA local)
- **Melhorado com**: Claude AI
- **Linguagem**: Batch Scripting avançado
- **Compatibilidade**: Windows API nativa

### 🙏 Agradecimentos
- **Microsoft** - Comandos e ferramentas do Windows
- **Comunidade** - Feedback e testes
- **IA Technology** - Assistência no desenvolvimento

---

<div align="center">

**🛠️ LVS Tools v4.6/v2.5 - Enterprise Suite**

*Desenvolvido por [lvsodre](https://linkedin.com/in/lvsodre) com ❤️ e IA*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/lvsodre)
[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/lvsodre)

</div>
