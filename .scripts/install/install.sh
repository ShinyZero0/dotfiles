#!/usr/bin/env bash

if [[ uname -m == "aarch64" ]]; then
	~/.scripts/install/termux/init.sh
else
	~/.scripts/install/pc/init.sh
fi

mkdir -p ~/.misc/
mkdir -p ~/sources/
cat << EOF > ~/.local/bin/shell
#!/usr/bin/env bash
exec bash
EOF
chmod +x ~/.local/bin/shell
