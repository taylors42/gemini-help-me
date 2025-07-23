#!/bin/bash
set -e

function print_error() {
  echo "❌ Erro: $1" >&2
  exit 1
}

function print_success() {
  echo "✅ $1"
}

echo "Este script irá adicionar o executável 'gemini-help-me' ao seu PATH."
read -p "Por favor, insira o caminho completo para o executável 'gemini-help-me': " binary_path

if [ ! -f "$binary_path" ]; then
    print_error "O arquivo não foi encontrado em '$binary_path'."
fi

if [ ! -x "$binary_path" ]; then
    echo "O arquivo em '$binary_path' não é executável. Tentando torná-lo executável..."
    chmod +x "$binary_path" || print_error "Não foi possível tornar o arquivo executável. Por favor, execute 'chmod +x $binary_path' manualmente."
    print_success "O arquivo agora é executável."
fi

binary_dir=$(dirname "$binary_path")

shell_name=$(basename "$SHELL")
profile_file=""
if [ "$shell_name" = "zsh" ]; then
    profile_file="$HOME/.zshrc"
elif [ "$shell_name" = "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        profile_file="$HOME/.bashrc"
    else
        profile_file="$HOME/.bash_profile"
    fi
else
    profile_file="$HOME/.profile"
fi

echo "O script irá adicionar o diretório '$binary_dir' ao seu PATH no arquivo '$profile_file'."

if ! grep -q "export PATH=.*$binary_dir" "$profile_file"; then
    echo "Adicionando PATH ao '$profile_file'..."
    echo "" >> "$profile_file"
    echo "# Adicionado pelo script de instalação do gemini-help-me" >> "$profile_file"
    echo "export PATH=\"$PATH:$binary_dir\"" >> "$profile_file"
    print_success "Diretório adicionado ao PATH."
    echo "Por favor, reinicie seu terminal ou execute 'source $profile_file' para aplicar as alterações."
else
    print_success "O diretório já está no seu PATH."
fi

echo "Instalação concluída!"