using System;
using System.IO;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;

class Program
{
    static async Task Main(string[] args)
    {
        var apiKey = Environment.GetEnvironmentVariable("GEMINI_API_KEY");
        if (string.IsNullOrEmpty(apiKey))
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Por favor, defina a variável de ambiente GEMINI_API_KEY.");
            return;
        }

        if (Console.IsInputRedirected)
        {
            using var reader = new StreamReader(Console.OpenStandardInput(), Console.InputEncoding);
            var inputText = await reader.ReadToEndAsync();
            if (string.IsNullOrWhiteSpace(inputText) is false)
            {
                await MakeGeminiRequest(inputText, apiKey);
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("O texto de entrada está vazio.");
            }
        }
        else
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine("Este programa foi projetado para ser usado com um pipe.");
            Console.ForegroundColor = ConsoleColor.Magenta;
            Console.WriteLine("Exemplo: echo \"Olá\" | gemini-help-me");
            Console.ResetColor();
        }
    }

    private static async Task MakeGeminiRequest(string text, string apiKey)
    {
        var url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

        var payload = new
        {
            contents = new[]
            {
                new
                {
                    parts = new[]
                    {
                        new
                        {
                            text = text
                        }
                    }
                }
            }
        };

        using var httpClient = new HttpClient();
        httpClient.DefaultRequestHeaders.Add("X-goog-api-key", apiKey);
        var jsonPayload = JsonSerializer.Serialize(payload);
        var content = new StringContent(jsonPayload, Encoding.UTF8, "application/json");
        try
        {
            var response = await httpClient.PostAsync(url, content);
            response.EnsureSuccessStatusCode();
            var responseBody = await response.Content.ReadAsStringAsync();

            using var doc = JsonDocument.Parse(responseBody);
            var root = doc.RootElement;
            var candidates = root.GetProperty("candidates");
            var firstCandidate = candidates[0];
            var contentElement = firstCandidate.GetProperty("content");
            var parts = contentElement.GetProperty("parts");
            var firstPart = parts[0];
            var responseText = firstPart.GetProperty("text");
            Console.WriteLine(responseText.GetString());
        }
        catch (HttpRequestException e)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Erro: {e.Message}");
        }
        catch (Exception ex)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Ocorreu um erro inesperado: {ex.Message}");
        }
    }
}
