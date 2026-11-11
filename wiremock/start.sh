#!/usr/bin/env sh
set -eu

version=3.13.2
jar="$(dirname "$0")/wiremock-standalone-$version.jar"
url="https://repo.maven.apache.org/maven2/org/wiremock/wiremock-standalone/$version/wiremock-standalone-$version.jar"

if [ ! -f "$jar" ]; then
  echo "Downloading WireMock Standalone $version..."
  if command -v curl >/dev/null 2>&1; then
    curl -fL "$url" -o "$jar"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$jar" "$url"
  else
    echo "Install curl or wget to download WireMock." >&2
    exit 1
  fi
fi

exec java -jar "$jar" --port 8080 --root-dir "$(dirname "$0")" --verbose
