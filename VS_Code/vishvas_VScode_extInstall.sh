#!/bin/bash
# Install all extensions from the extensions.txt file

while read -r vs_CodeExtensions; do
  code --install-extension "$extension"
done <  vs_CodeExtensions.txt
#!/bin/bash
# Install all VS Code extensions from the vs_CodeExtensions.txt file
# This script will read each extension from the file and install it using 'code --install-extension'

EXTENSIONS_FILE="vs_CodeExtensions.txt"

# Check if the file exists
if [[ ! -f "$EXTENSIONS_FILE" ]]; then
    echo "Error: $EXTENSIONS_FILE not found!"
    exit 1
fi

# Read and install each extension from the file
while read -r vs_CodeExtensions; do
    if [[ ! -z "$vs_CodeExtensions" ]]; then
        echo "Installing extension: $vs_CodeExtensions"
        code --install-extension "$vs_CodeExtensions"
        
        if [[ $? -eq 0 ]]; then
            echo "Successfully installed: $vs_CodeExtensions"
        else
            echo "Failed to install: $vs_CodeExtensions"
        fi
    fi
done < "$EXTENSIONS_FILE"

echo "Extension installation process completed."
