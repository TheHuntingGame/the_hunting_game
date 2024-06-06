Codespaces: flutter run --release -d web-server --web-hostname=0.0.0.0 --web-port=3000

Execute in codespaces (github or elsewhere):
add .devcontainer with devcontainer.json
add .vscode with launch.json
follow code examples on https://github.com/felangel/fluttersaurus (copy .vscode and .devcontainer code/folder)
change "cirrusci/flutter:beta" to "ghcr.io/cirruslabs/flutter:3.22.2" (any flutter version over version 3.0.0 stable)