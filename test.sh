set -e
set -o pipefail

ERRORS=()

function run_lint
{
    {
        $1 "$2" && echo "[OK]: successfully linted $f"
    } || {
        # add to errors
    ERRORS+=("$f")
    }

}

# find all executables and run `shellcheck`
for f in $(find . -type f -not -ipath '*.git*' -not -name "yubitouch.sh" | grep -v "vim/vim/pack/plugins" | sort -u); do
    if file "$f" | grep --quiet shell; then
        run_lint shellcheck "$f"
    fi
    if file "$f" | grep --quiet "Python script"; then
        run_lint flake8 "$f"
    fi
done

if [ ${#ERRORS[@]} -eq 0 ]; then
    echo "Linting passed"
else
    echo "These files failed linting: ${ERRORS[*]}"
    exit 1
fi
