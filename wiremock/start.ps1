$ErrorActionPreference = 'Stop'

$version = '3.13.2'
$jar = Join-Path $PSScriptRoot "wiremock-standalone-$version.jar"
$url = "https://repo.maven.apache.org/maven2/org/wiremock/wiremock-standalone/$version/wiremock-standalone-$version.jar"

if (-not (Test-Path $jar)) {
    Write-Host "Lade WireMock Standalone $version herunter..."
    Invoke-WebRequest -Uri $url -OutFile $jar
}

java -jar $jar --port 8080 --root-dir $PSScriptRoot --verbose
