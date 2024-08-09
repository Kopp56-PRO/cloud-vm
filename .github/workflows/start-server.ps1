# Define the path to serve
$path = "C:\"

# Create a simple HTTP server
Start-Job -ScriptBlock {
    param ($path)
    $listener = New-Object System.Net.HttpListener
    $listener.Prefixes.Add("http://+:8080/")
    $listener.Start()
    Write-Host "Listening on http://localhost:8080"
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $response = $context.Response
        $response.ContentType = "text/html"
        $response.ContentEncoding = [System.Text.Encoding]::UTF8
        $response.Headers.Add("Cache-Control", "no-cache")
        $file = Join-Path -Path $path -ChildPath $context.Request.Url.LocalPath.TrimStart('/')
        if (Test-Path $file) {
            $response.StatusCode = 200
            $response.OutputStream.Write([System.IO.File]::ReadAllBytes($file), 0, [System.IO.File]::ReadAllBytes($file).Length)
        } else {
            $response.StatusCode = 404
            $response.OutputStream.Write([System.Text.Encoding]::UTF8.GetBytes("<h1>404 Not Found</h1>"), 0, [System.Text.Encoding]::UTF8.GetBytes("<h1>404 Not Found</h1>").Length)
        }
        $response.Close()
    }
} -ArgumentList $path
