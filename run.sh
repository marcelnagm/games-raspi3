#!/bin/bash

# Caminho para o arquivo de dados
DATA_FILE="./path.games"

# Verifica se o arquivo existe
if [ ! -f "$DATA_FILE" ]; then
    echo "Erro: O arquivo $DATA_FILE não foi encontrado."
    exit 1
fi

# Arrays para armazenar comandos e títulos
mapfile -t lines < "$DATA_FILE"
commands=()
titles=()
count=0

# Processa o arquivo e preenche os arrays
for line in "${lines[@]}"; do
    # Ignora linhas vazias
    [[ -z "$line" ]] && continue
    
    # Divide a linha no caractere ';'
    cmd=$(echo "$line" | cut -d';' -f1)
    title=$(echo "$line" | cut -d';' -f2 | tr -d '"') # Remove as aspas do título
    
    commands+=("$cmd")
    titles+=("$title")
    ((count++))
done

# Loop do Menu Interativo
while true; do
    clear
    echo "========================================"
    echo "           MENU DE JOGOS DOSBOX         "
    echo "========================================"
    
    # Exibe as opções dinamicamente
    for ((i=0; i<count; i++)); do
        printf "[%2d] %s\n" $((i+1)) "${titles[i]}"
    done
    echo "[ 0] Sair"
    echo "========================================"
    
    read -p "Selecione uma opção (0-$count): " choice
    
    # Validação da entrada
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 0 ] && [ "$choice" -le "$count" ]; then
        if [ "$choice" -eq 0 ]; then
            echo "Saindo..."
            break
        fi
        
        # Ajusta o índice (base 0) e executa o comando correspondente
        index=$((choice - 1))
        echo "Iniciando ${titles[index]}..."
        
        # Executa o comando armazenado
        eval "${commands[index]}"
        
        read -p "Pressione [Enter] para voltar ao menu..."
    else
        echo "Opção inválida! Tente novamente."
        sleep 1
    fi
done	
