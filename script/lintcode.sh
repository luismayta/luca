#!/usr/bin/env bash
# -*- coding: utf-8 -*-

# shellcheck source=script/bootstrap.sh
# shellcheck disable=SC1091
[ -r "script/bootstrap.sh" ] && source "script/bootstrap.sh"

pre-commit install -f --install-hooks
pre-commit run --all-files
