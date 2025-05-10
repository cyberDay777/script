#!/bin/bash

echo
echo "--------------------------------------"
echo "          lineageos Buildbot          "
echo "                  by                  "
echo "            CyberDay777.              "
echo "--------------------------------------"
echo
#!/bin/bash

# Manifest URL
MANIFEST_URL="https://raw.githubusercontent.com/xiaomi-chenfieng-devs/local_manifests/refs/heads/main/manifest.xml"
MANIFEST_FILE="$HOME/manifest.xml"

# Download manifest
wget -q "$MANIFEST_URL" -O "$MANIFEST_FILE"
if [ ! -f "$MANIFEST_FILE" ]; then
    echo "Failed to download manifest."
    exit 1
fi

echo "Manifest downloaded."

# Build remote map
declare -A remotes
while read -r line; do
    name=$(echo "$line" | grep -o 'name="[^"]*"' | cut -d'"' -f2)
    fetch=$(echo "$line" | grep -o 'fetch="[^"]*"' | cut -d'"' -f2)
    [ -n "$name" ] && [ -n "$fetch" ] && remotes["$name"]="$fetch"
done < <(grep '<remote ' "$MANIFEST_FILE")

# Process each project
grep '<project ' "$MANIFEST_FILE" | while read -r line; do
    name=$(echo "$line" | grep -o 'name="[^"]*"' | cut -d'"' -f2)
    remote=$(echo "$line" | grep -o 'remote="[^"]*"' | cut -d'"' -f2)
    path=$(echo "$line" | grep -o 'path="[^"]*"' | cut -d'"' -f2)

    [ -z "$remote" ] && remote="origin"
    [ -z "$path" ] && path="$name"
    url="${remotes[$remote]}/$name.git"

    echo -e "\nCloning $url -> $path"
    git clone --depth=1 "$url" "$path" &>/dev/null

    if [ -d "$path" ]; then
        echo "✔️ Path exists: $path"
    else
        echo "❌ Clone failed or path missing: $path"
    fi
done

rm -f "$MANIFEST_FILE"

rm -rf hardware/google/pixel/kernel_headers
source build/envsetup.sh
export SELINUX_IGNORE_NEVERALLOWS=true
breakfast chenfeng
make clean
mka bacon
