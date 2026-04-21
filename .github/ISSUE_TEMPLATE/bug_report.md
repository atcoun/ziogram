---
name: Bug Report
about: Report a bug or unexpected behavior in ziogram
title: '[BUG] '
labels: bug
assignees: ''
---

## Description

A clear description of the bug.

## Minimal Reproducible Example

```zig
const std = @import("std");
const ziogram = @import("ziogram");

pub fn main(init: std.process.Init) !void {
    // minimal code that reproduces the issue
}
```

## Expected Behavior

What did you expect to happen?

## Actual Behavior

What actually happened? Paste the full error output, including any `ZiogramError` log lines:

```
ziogram error: ...
```

## Environment

- Zig version (`zig version`):
- ziogram commit:
- OS:

## Additional Context

Any other relevant details (network setup, local Bot API server, proxy, etc.).
