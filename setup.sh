#!/bin/bash

# Configurações de Caminho
ARQUIVO_GAMES="path.games"
DIR_REPO=$(pwd)
APPS_DIR="$HOME/.local/share/applications"

echo "--- 🕹️ Iniciando Setup de Jogos DOSBox ---"

# 1. REMOÇÃO DE ATALHOS ANTIGOS
# Remove todos os arquivos .desktop que começam com 'dosbox_' criados por este script
echo "Limpando atalhos antigos da DOSBox..."
rm -f "$APPS_DIR"/dosbox_*.desktop

# 2. Instalação do DOSBox (caso não exista)
if ! command -v dosbox &> /dev/null; then
    echo "Instalando DOSBox..."
    sudo apt update && sudo apt install -y dosbox
else
    echo "✔ DOSBox já instalado."
fi

# 3. Criar diretório de atalhos se não existir
mkdir -p "$APPS_DIR"

# 4. Processar o arquivo path.games
if [ ! -f "$ARQUIVO_GAMES" ]; then
    echo "❌ Erro: Arquivo $ARQUIVO_GAMES não encontrado no diretório atual!"
    exit 1
fi

echo "Recriando atalhos no menu..."

# Lendo linha por linha do arquivo path.games
while IFS=';' read -r comando nome_exibicao; do
    # Ignorar linhas vazias
    [ -z "$comando" ] && continue

    # Limpar o nome de exibição (remover aspas e espaços extras)
    nome_exibicao=$(echo "$nome_exibicao" | tr -d '"' | xargs)
    
    # Gerar nome de arquivo desktop padronizado (sem espaços e minúsculo)
    nome_arquivo=$(echo "$nome_exibicao" | tr '[:upper:]' '[:lower:]' | tr -dc '[:alnum:]')
    arquivo_desktop="$APPS_DIR/dosbox_$nome_arquivo.desktop"

    # Ajustar o comando para usar o caminho absoluto do repositório
    comando_absoluto=$(echo "$comando" | sed "s|\./|$DIR_REPO/|g")

    # Criar o arquivo .desktop
    cat <<EOF > "$arquivo_desktop"
[Desktop Entry]
Name=DOS: $nome_exibicao
Type=Application
Comment=Jogo rodando via DOSBox
Exec=$comando_absoluto -c "exit"
Icon=dosbox
Categories=Game;
Path=$DIR_REPO
Terminal=false
StartupNotify=true
EOF

    chmod +x "$arquivo_desktop"
    echo "✔ Novo atalho criado: $nome_exibicao"

done < "$ARQUIVO_GAMES"

echo "--- ✅ Setup Concluído! O Menu de Jogos foi atualizado ---"
