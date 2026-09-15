#!/usr/bin/env bash
# Install Humanizer as a Claude Code skill.
#
# Usage:
#   ./install.sh                   # install to ~/.claude/skills/humanizer (user-wide)
#   ./install.sh --project         # install to ./.claude/skills/humanizer (current project)
#   ./install.sh --target /path    # install to /path/.claude/skills/humanizer

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SCRIPT_DIR}/SKILL.md"
REFERENCES_DIR="${SCRIPT_DIR}/references"

if [[ ! -f "${SOURCE}" ]]; then
    echo "Error: SKILL.md not found at ${SOURCE}" >&2
    exit 1
fi
if [[ ! -d "${REFERENCES_DIR}" ]]; then
    echo "Error: references/ directory not found at ${REFERENCES_DIR}" >&2
    exit 1
fi

TARGET_BASE="${HOME}"
case "${1:-}" in
    --project)
        TARGET_BASE="$(pwd)"
        ;;
    --target)
        if [[ -z "${2:-}" ]]; then
            echo "Error: --target requires a path" >&2
            exit 1
        fi
        TARGET_BASE="$2"
        ;;
    "")
        ;;
    *)
        echo "Unknown argument: $1" >&2
        echo "Usage: $0 [--project | --target /path]" >&2
        exit 1
        ;;
esac

DEST_DIR="${TARGET_BASE}/.claude/skills/humanizer"
DEST_FILE="${DEST_DIR}/SKILL.md"

mkdir -p "${DEST_DIR}"

if [[ -f "${DEST_FILE}" ]]; then
    BACKUP="${DEST_FILE}.backup.$(date +%Y%m%d-%H%M%S)"
    cp "${DEST_FILE}" "${BACKUP}"
    echo "Existing skill backed up to ${BACKUP}"
fi

cp "${SOURCE}" "${DEST_FILE}"
# Copy contents into stable destinations so repeat installs do not nest folders.
for resource in references examples docs; do
    mkdir -p "${DEST_DIR}/${resource}"
    cp -R "${SCRIPT_DIR}/${resource}/." "${DEST_DIR}/${resource}/"
done
cp "${SCRIPT_DIR}/ATTRIBUTION.md" "${DEST_DIR}/ATTRIBUTION.md"

echo ""
echo "Humanizer installed to ${DEST_DIR}"
echo "  - SKILL.md (core)"
echo "  - references/ (progressive-disclosure files: patterns, channels, voice calibration)"
echo ""
echo "  - examples/ and docs/ (voice setup and worked examples)"
echo "Try it:"
echo "  In Claude Code, type:  /humanizer"
echo "  Or:                    humanize this draft"
echo ""
echo "First-run setup (optional):"
echo "  humanizer setup"
echo ""
