# Gemini Help Me

Um aplicativo de console feito para te ajudar gerando texto no seu terminal

## Começando

### Pré-requisitos

*   .NET 9.0 SDK
*   Chave de API do Gemini

### Configurando a Chave de API

Para usar este aplicativo, você precisa de uma chave de API do Gemini. Você pode obter uma no [Google AI Studio](https://aistudio.google.com/app/apikey).

Depois de ter sua chave, você precisa adicioná-la às suas variáveis de ambiente para que a aplicação possa usá-la.

**Linux/macOS:**

Adicione a seguinte linha ao seu arquivo de configuração do shell (por exemplo, `~/.zshrc`, `~/.bashrc` ou `~/.profile`):

```bash
export GEMINI_API_KEY="SUA_CHAVE_API_AQUI"
```

Lembre-se de recarregar a configuração do seu shell (ex: `source ~/.zshrc`) ou abrir um novo terminal para que as alterações entrem em vigor.

**Windows:**

Você pode definir a variável de ambiente através do PowerShell com o seguinte comando:
```powershell
[System.Environment]::SetEnvironmentVariable('GEMINI_API_KEY', 'SUA_CHAVE_API_AQUI', [System.EnvironmentVariableTarget]::User)
```
Reinicie o PowerShell ou o seu terminal para aplicar as alterações.

### Construindo e Executando (Manual)

1.  Clone o repositório.
2.  Construa o projeto:
    ```bash
    dotnet build
    ```
3.  Execute a aplicação:
    ```bash
    dotnet run
    ```
4.  **(Opcional)** Para facilitar o uso, você pode adicionar o executável ao seu PATH. Isso permitirá que você chame `gemini-help-me` de qualquer diretório no seu terminal.

## Uso

Você pode interagir com o `gemini-help-me` diretamente do seu terminal, usando `pipes` para enviar prompts e redirecionar a saída.

### Exemplos de Uso

**1. Criar um arquivo de configuração:**

Este exemplo cria um arquivo de configuração para o gerenciador de janelas i3, salvando a saída diretamente no local correto.

*Linux/macOS:*
```bash
echo "crie um arquivo de configuracao do i3, me retorne somente o conteudo do arquivo" | gemini-help-me > ~/.config/i3/config
```

**2. Gerar um script:**

Peça ao Gemini para escrever um script e salve-o em um arquivo.

```bash
echo "crie um script em bash para fazer backup de um diretorio" | gemini-help-me > backup.sh
```

**3. Criar notas rápidas:**

Crie um arquivo de texto com anotações sobre um tópico específico.

```bash
echo "faça um resumo sobre a história da computação em 5 pontos principais" | gemini-help-me > notas_computacao.txt
```

**4. Resolver problemas de programação:**

Obtenha ajuda para entender e depurar um erro.

```bash
echo "Estou recebendo o erro 'NullReferenceException' em C#, o que geralmente causa isso e como posso resolver?" | gemini-help-me
```
