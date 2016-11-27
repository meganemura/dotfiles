#!/bin/sh
set -e

bin/setup-mitamae

# Homebrew does not allow sudo.
case "$(uname)" in
  "Darwin") bin/mitamae local lib/recipe.rb ;;
  *)   sudo bin/mitamae local lib/recipe.rb ;;
esac
