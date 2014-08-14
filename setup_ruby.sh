#!/bin/bash -e

RUBY_VERSION="2.1.2"
GEM="$HOME/.rbenv/shims/gem"

rbenv install --skip-existing $RUBY_VERSION
rbenv global $RUBY_VERSION
