set quiet := true

[private]
default:
    just --choose --unsorted

install:
    pip install -r configs/requirements.txt
    pip install --upgrade pip

update-deps:
    pip-review --auto

update-shared-requirements-in:
    pip list --not-required --format=freeze > configs/requirements.in

update-shared-requirements-txt:
    pip-compile --output-file=configs/requirements.txt configs/requirements.in > /dev/null

autoupdate-shared-precommit-config:
    pre-commit autoupdate --config="shared/.pre-commit-config.yaml"

checks:
    pre-commit run

checks-autoupgrade:
    pre-commit autoupgrade

checks-docs:
    pre-commit run codespell
    pre-commit run mdformat
    pre-commit run yamlfix

destroy-venv:
    deactivate || true
    rm -rf .venv
    rm -rf venv

rebase:
    git fetch --all
    git rebase -i origin/master

reload-shell:
    exec $SHELL
