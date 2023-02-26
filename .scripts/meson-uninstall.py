#!/usr/bin/env python3
# PLACE THIS INTO BUILD DIR
# NOTE: This is only useful until Meson 0.38.0 which includes an `uninstall` target.

import argparse
from contextlib import suppress
from os import path, remove

parser = argparse.ArgumentParser()
parser.add_argument('--dry-run', action='store_true')
parser.add_argument('directory', type=str, default='.', nargs='?')
args = parser.parse_args()

log_file = path.join(args.directory, 'meson-logs', 'install-log.txt')

with open(log_file) as f:
    for line in f:
        line = line.strip()
        if line.startswith('#'):
            continue

        if args.dry_run:
            print('Would delete:', line)
        else:
            print('Deleting:', line)
            with suppress(FileNotFoundError):
                remove(line)

print('Note that empty directories and post-install script created files maybe left over')
