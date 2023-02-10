#!/usr/bin/env bash
i3-resurrect restore --layout-only -w "1"
sleep 0.5
i3-resurrect restore --programs-only -w "1"
sleep 0.5
i3-resurrect restore --layout-only -w "2"
sleep 0.5
i3-resurrect restore --programs-only -w "2"
