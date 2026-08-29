#!/usr/bin/env bash
set -euo pipefail

LW_ENV_FILE="${LW_ENV_FILE:-${HOME}/.config/local-wisper/env}"
if [[ -f "${LW_ENV_FILE}" ]]; then
  # shellcheck disable=SC1090
  source "${LW_ENV_FILE}"
fi

LW_BIN="${LW_BIN:-$(command -v lw || true)}"
LW_BACKEND="${LW_BACKEND:-parakeet}"
LW_MODEL="${LW_MODEL:-}"
LW_COMPUTE_TYPE="${LW_COMPUTE_TYPE:-float16}"
LW_DEVICE="${LW_DEVICE:-cuda}"
LW_SAMPLE_RATE="${LW_SAMPLE_RATE:-16000}"
LW_VAD_FILTER="${LW_VAD_FILTER:-false}"
LW_OUTPUT_MODE="${LW_OUTPUT_MODE:-type}"
LW_POST_PROCESS_MODEL="${LW_POST_PROCESS_MODEL:-}"
LW_POST_PROCESS_TIMEOUT="${LW_POST_PROCESS_TIMEOUT:-20}"
LW_POST_PROCESS_GLOSSARY_FILE="${LW_POST_PROCESS_GLOSSARY_FILE:-}"

if [[ -z "${LW_BIN}" ]]; then
  if command -v notify-send >/dev/null 2>&1; then
    notify-send echo "local wisper: 'lw' is not in PATH, intall it from https://github.com/none23/local-wisper"
  fi
  echo "local wisper: 'lw' is not in PATH, intall it from https://github.com/none23/local-wisper" >&2
  exit 1
fi

args=(
  --backend "${LW_BACKEND}"
  --device "${LW_DEVICE}"
  --sample-rate "${LW_SAMPLE_RATE}"
)

if [[ -n "${LW_MODEL}" ]]; then
  args+=(--model "${LW_MODEL}")
fi

if [[ -n "${LW_COMPUTE_TYPE}" ]]; then
  args+=(--compute-type "${LW_COMPUTE_TYPE}")
fi

if [[ -n "${LW_POST_PROCESS_MODEL}" ]]; then
  args+=(--post-process-model "${LW_POST_PROCESS_MODEL}")
  args+=(--post-process-timeout "${LW_POST_PROCESS_TIMEOUT}")
  if [[ -n "${LW_POST_PROCESS_GLOSSARY_FILE}" ]]; then
    args+=(--post-process-glossary-file "${LW_POST_PROCESS_GLOSSARY_FILE}")
  fi
fi

if [[ "${LW_VAD_FILTER}" == "true" ]]; then
  args+=(--vad-filter)
else
  args+=(--no-vad-filter)
fi

case "${1:-}" in
  sway-stop|sway-toggle)
    if [[ "${LW_OUTPUT_MODE}" == "type" ]]; then
      args+=(--type-output)
    fi
    ;;
esac

exec "${LW_BIN}" "${args[@]}" "$@"
