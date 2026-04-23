---
name: Feature Request
about: Suggest a new Telegram API method or library feature
title: '[FEAT] '
labels: enhancement
assignees: ''
---

## Summary

Short description of what you want added.

## Motivation

Why is this needed? What does it enable?

## Telegram Bot API Reference

Link to the relevant method in the [Telegram Bot API docs](https://core.telegram.org/bots/api):

## Proposed Method Struct

```zig
// src/methods/send_foo.zig
pub const Result = bool; // or a concrete type
pub const method_name = "sendFoo";

chat_id: types.ChatId,
foo: ?[]const u8 = null,
```

## Additional Context

Any other notes.
