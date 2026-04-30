
#!/bin/bash
git clone https://github.com/marcelnagm/games-raspi3.git
# Configurações de Caminho
ARQUIVO_GAMES="path.games"
DIR_REPO=$(pwd)
APPS_DIR="$HOME/.local/share/applications"

echo "--- 🕹️ Iniciando Setup de Jogos DOSBox ---"

# 1. Instalação do DOSBox
if ! command -v dosbox &> /dev/null; then
    echo "Instalando DOSBox..."
    sudo apt update && sudo apt install -y dosbox
else
    echo "✔ DOSBox já instalado."
fi

# 2. Criar diretório de atalhos se não existir
mkdir -p "$APPS_DIR"

# 3. Processar o arquivo path.games
if [ ! -f "$ARQUIVO_GAMES" ]; then
    echo "❌ Erro: Arquivo $ARQUIVO_GAMES não encontrado no diretório atual!"
    exit 1
fi

echo "Criando atalhos no menu..."

# Lendo linha por linha
while IFS=';' read -r comando nome_exibicao; do
    # Remove aspas extras do nome de exibição
    nome_exibicao=$(echo "$nome_exibicao" | tr -d '"')
    
    # Gerar nome de arquivo seguro (ex: gta.desktop)
    nome_arquivo=$(echo "$nome_exibicao" | tr '[:upper:]' '[:lower:]' | tr -d ' ' | tr -dc '[:alnum:]')
    arquivo_desktop="$APPS_DIR/dosbox_$nome_arquivo.desktop"

    # Ajustar o comando para usar o caminho absoluto do repositório
    # Substitui './' pelo caminho absoluto do diretório do script
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
    echo "✔ Atalho criado: $nome_exibicao"

done < "$ARQUIVO_GAMES"

echo "--- ✅ Setup Concluído! Os jogos estão em Menu -> Jogos ---"
