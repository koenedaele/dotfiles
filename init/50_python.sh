# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Install python packages.
packages=(
  virtualenvwrapper
)

if (( ${#packages[@]} > 0 )); then
  e_header "Installing Python packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    pip install --upgrade "$package"
  done
fi
