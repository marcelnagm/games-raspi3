#!/bin/bash

# Configurações de Caminho
ARQUIVO_GAMES="path.games"
APPS_DIR="$HOME/.local/share/applications"

echo "--- 🧹 Iniciando Desinstalação do Games-RasPi3 ---"

# 1. Remoção dos Lançadores (.desktop)
echo "Removendo atalhos do menu do sistema..."
if [ -d "$APPS_DIR" ]; then
    # Remove apenas os arquivos criados pelo setup do ecossistema
    rm -f "$APPS_DIR"/dosbox_*.desktop
    echo "✔ Menu de jogos limpo com sucesso."
else
    echo "⚠ Diretório de aplicações do usuário não encontrado."
fi

# 2. Remoção das Pastas de Dados dos Jogos
# O script lê o arquivo path.games para identificar e apagar estritamente as pastas listadas
if [ -f "$ARQUIVO_GAMES" ]; then
    echo "Identificando e removendo diretórios dos jogos..."
    
    while IFS=';' read -r comando nome_exibicao; do
        # Ignorar linhas vazias ou comentários
        [ -z "$comando" ] && continue
        [[ "$comando" =~ ^# ]] && continue

        # Expressão regular para capturar o caminho relativo (ex: ./gta, ./doom) dentro do comando mount
        pasta_jogo=$(echo "$comando" | grep -oE '\./[a-zA-Z0-9_-]+' | head -n 1)

        # Validação de segurança: só remove se o diretório realmente existir localmente
        if [ ! -z "$pasta_jogo" ] && [ -d "$pasta_jogo" ]; then
            echo "🗑️  Removendo dados locais: $pasta_jogo"
            rm -rf "$pasta_jogo"
        fi
    done < "$ARQUIVO_GAMES"
else
    echo "⚠ Arquivo $ARQUIVO_GAMES não encontrado. Pulando remoção das pastas locais."
fi

echo "--- ✅ Processo Concluído! Sistema Limpo ---"
echo "Para remover completamente o repositório, saia desta pasta e execute: rm -rf games"
