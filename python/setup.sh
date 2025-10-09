#!/bin/bash

set -euo pipefail

GREEN="\033[0;32m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RED="\033[0;31m"
NC="\033[0m"

info() { echo -e "${BLUE}ℹ${NC} $1"; }
success() { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1"; }

FORMULA="python@3.11"

if ! command -v brew >/dev/null 2>&1; then
  error "Homebrew is required but not installed. Run ../homebrew/install.sh first."
  exit 1
fi

info "Ensuring ${FORMULA} is installed via Homebrew"
if brew list --versions "${FORMULA}" >/dev/null 2>&1; then
  success "${FORMULA} already installed"
else
  brew install "${FORMULA}"
  success "Installed ${FORMULA}"
fi

PY_PREFIX="$(brew --prefix "${FORMULA}")"
PY_BIN="${PY_PREFIX}/bin/python3.11"

if [[ ! -x "${PY_BIN}" ]]; then
  error "Expected Python binary not found at ${PY_BIN}"
  exit 1
fi

info "Preparing Python tooling (${PY_BIN})"
"${PY_BIN}" -m ensurepip --upgrade >/dev/null 2>&1 || warn "ensurepip reported a warning"
"${PY_BIN}" -m pip install --upgrade pip setuptools wheel >/dev/null
success "Upgraded pip, setuptools, and wheel for Node build compatibility"

info "Verifying distutils availability"
if "${PY_BIN}" -c "import distutils.command.build" >/dev/null 2>&1; then
  success "distutils modules available (via setuptools)"
else
  warn "distutils modules could not be imported. Node builds may still fail."
fi

info "Configuring JavaScript package managers to use ${PY_BIN}"
if command -v npm >/dev/null 2>&1; then
  if npm config set python "${PY_BIN}" >/dev/null 2>&1; then
    success "npm configured to use ${PY_BIN}"
  else
    warn "Unable to update npm python config automatically"
  fi
else
  warn "npm not detected; configure later with: npm config set python ${PY_BIN}"
fi

if command -v yarn >/dev/null 2>&1; then
  if yarn config set python "${PY_BIN}" >/dev/null 2>&1; then
    success "yarn configured to use ${PY_BIN}"
  else
    warn "Unable to update yarn python config automatically"
  fi
fi

if command -v pnpm >/dev/null 2>&1; then
  if pnpm config set python-path "${PY_BIN}" >/dev/null 2>&1; then
    success "pnpm configured to use ${PY_BIN}"
  else
    warn "Unable to update pnpm python config automatically"
  fi
fi

ZSHRC="${HOME}/.zshrc"
MARKER_START="# >>> dotfiles python setup >>>"
MARKER_END="# <<< dotfiles python setup <<<"

if [[ -f "${ZSHRC}" ]] && grep -q "${MARKER_START}" "${ZSHRC}"; then
  info "Python environment block already present in ${ZSHRC}"
else
  info "Appending Python environment block to ${ZSHRC}"
  {
    echo ""
    echo "${MARKER_START}"
    echo "# Prefer Homebrew's Python 3.11 for Node native module builds"
    echo "export PATH=\"${PY_PREFIX}/bin:\$PATH\""
    echo "export PYTHON=\"${PY_BIN}\""
    echo "export npm_config_python=\"${PY_BIN}\""
    echo "export NODE_GYP_FORCE_PYTHON=\"${PY_BIN}\""
    echo "${MARKER_END}"
  } >> "${ZSHRC}"
  success "Python environment variables added to ${ZSHRC}"
fi

cat <<EOF

${GREEN}Python build tooling is ready!${NC}
- Active Python: ${PY_BIN}
- Update current shell by running: source ~/.zshrc
- Reinstall native Node modules (e.g. canvas) to pick up the new configuration
EOF
