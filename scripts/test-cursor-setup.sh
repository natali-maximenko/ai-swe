#!/usr/bin/env bash

set -u

PATH="${HOME}/.local/bin:/usr/local/bin:/opt/homebrew/bin:${PATH}"
export PATH

required_failures=0
warnings=0

section() {
	printf '\n== %s ==\n' "$1"
}

ok() {
	printf '[OK] %s\n' "$1"
}

fail() {
	printf '[FAIL] %s\n' "$1"
	required_failures=$((required_failures + 1))
}

warn() {
	printf '[WARN] %s\n' "$1"
	warnings=$((warnings + 1))
}

note() {
	printf '       %s\n' "$1"
}

compact_output() {
	printf '%s' "$1" |
		tr '\n' ' ' |
		sed 's/[[:space:]][[:space:]]*/ /g; s/^ //; s/ $//' |
		cut -c1-220
}

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

check_command() {
	local severity="$1"
	local label="$2"
	shift 2

	local output
	if output="$("$@" 2>&1)"; then
		ok "$label"
		return 0
	fi

	if [ "$severity" = "required" ]; then
		fail "$label"
	else
		warn "$label"
	fi
	note "$(compact_output "$output")"
	return 1
}

check_port_selector() {
	local output
	local port

	if ! command_exists port-selector; then
		fail "port-selector installed"
		return 1
	fi

	if output="$(port-selector --name setup-check 2>&1)"; then
		port="$(printf '%s\n' "$output" | awk '/^[[:space:]]*[0-9]+[[:space:]]*$/ { gsub(/[[:space:]]/, "", $0); port=$0 } END { print port }')"
		if [ -n "$port" ]; then
			ok "port-selector returns a free port"
			port-selector --forget --name setup-check >/dev/null 2>&1 || true
			return 0
		fi
	fi

	fail "port-selector returns a free port"
	note "$(compact_output "$output")"
	port-selector --forget --name setup-check >/dev/null 2>&1 || true
	return 1
}

check_direnv_port() {
	local output

	if ! command_exists direnv; then
		fail "direnv installed"
		return 1
	fi

	if [ ! -f .envrc ]; then
		fail ".envrc present"
		return 1
	fi

	# shellcheck disable=SC2016
	if ! output="$(direnv exec . sh -lc 'printf "%s" "${PORT:-}"' 2>/dev/null)"; then
		fail "direnv exports numeric PORT"
		return 1
	fi

	if printf '%s' "$output" | tr -d '[:space:]' | grep -Eq '^[0-9]+$'; then
		ok "direnv exports numeric PORT"
		return 0
	fi

	fail "direnv exports numeric PORT"
	note "PORT=${output:-<empty>}"
	return 1
}

section "Core toolchain (required)"
check_command required "mise installed" mise --version
check_command required "direnv installed" direnv version
check_command required "gh installed" gh --version
check_command required "gitleaks installed" gitleaks version
check_command required "jq installed" jq --version
check_port_selector
check_direnv_port

section "Elixir toolchain (required)"
check_command required "erl installed" erl -eval 'erlang:display(erlang:system_info(otp_release)), halt().' -noshell
check_command required "elixir installed" elixir --version
check_command required "mix installed" mix --version

section "Optional tools"
check_command optional "node installed" node --version
check_command optional "cursor-cli installed" cursor --version
check_command optional "tmux installed" tmux -V
check_command optional "zellij installed" zellij --version

printf '\nSummary: %s required failure(s), %s warning(s)\n' "$required_failures" "$warnings"

if [ "$required_failures" -ne 0 ]; then
	exit 1
fi
