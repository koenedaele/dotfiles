# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

cat <<EOF
  Some of these packages require that the Canonical parter repository is
  enabled. Make sure you've edited your /etc/apt/sources.list file.
EOF

sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
sudo add-apt-repository "deb http://repository.spotify.com stable non-free"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 94558F59

sudo apt-get -qq update

# Install APT packages.
packages=(
  chromium-browser
  skype
  spotify-client
  nautilus-dropbox
)

packages=($(setdiff "${packages[*]}" "$(dpkg --get-selections | grep -v deinstall | awk '{print $1}')"))

if (( ${#packages[@]} > 0 )); then
  e_header "Installing APT packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    sudo apt-get -qq install "$package"
  done
fi
