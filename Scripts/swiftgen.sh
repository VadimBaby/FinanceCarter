# Type a script or drag a script file from your workspace to insert its path.
export PATH="$PATH:/opt/homebrew/bin"
if which swiftgen >& /dev/null; then
  swiftgen
else
  echo "warning: SwiftGen not installed, download from https://github.com/SwiftGen/SwiftGen"
fi
