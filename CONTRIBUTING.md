# Contributing to ziogram

Thank you for your interest in contributing to **ziogram** — a high-performance Telegram Bot API library for Zig! ⚡

## Table of Contents

- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Adding a New API Method](#adding-a-new-api-method)
- [Running Tests](#running-tests)
- [Code Style](#code-style)
- [Commit Messages](#commit-messages)
- [Pull Requests](#pull-requests)
- [Reporting Bugs](#reporting-bugs)

---

## Getting Started

### Requirements

- [Zig](https://ziglang.org/download/) `0.16.0+` (minimum, see `build.zig.zon`)
- A Telegram Bot Token (from [@BotFather](https://t.me/BotFather)) — only needed to run a real bot, not for tests

### Setup

```sh
git clone https://github.com/atcoun/ziogram.git
cd ziogram
zig build test
```

---

## Project Structure

```
src/
├── client/
│   ├── session/
│   │   ├── base.zig      # BaseSession — HTTP client, JSON serialization, response validation
│   │   └── client.zig    # ClientSession — request dispatching, timeout (via Io.Select), multipart/form-data, connection pool, proxy, file streaming
│   ├── server.zig        # TelegramApi — URL formatting, local server support
│   ├── simple.zig        # SimpleFilesPathWrapper — local file path remapping
│   └── bot.zig           # Bot — public API, call dispatcher, download helpers
├── enums/                # All Telegram enums (ParseMode, ChatType, etc.)
│   └── root.zig
├── methods/              # One .zig file per Telegram API method
│   └── root.zig
├── types/                # All Telegram object types
│   └── root.zig
├── utils/                # Internal helpers (token parsing, etc.)
│   └── token.zig
├── errors.zig            # ZiogramError set + DetailedError constructors
└── root.zig              # Public exports: Bot, ClientSession, types, enums, errors, methods
build.zig                 # Build script — module graph + test steps
build.zig.zon             # Package manifest — version 0.0.0, min Zig 0.0.0
```

### Module dependency graph

```
enums
  └── types
        ├── errors
        └── methods
              └── ziogram (root)
```

---

## Adding a New API Method

> **All methods from the current [Telegram Bot API](https://core.telegram.org/bots/api) are already implemented.**
> This section is for when Telegram releases a new API update and ziogram hasn't added it yet — you can implement it yourself and open a PR without waiting for a maintainer.

Every Telegram API method is a single `.zig` file in `src/methods/`. The generic `Bot.call` dispatcher resolves `Result` and `method_name` at comptime — no registration table needed.

> **Tip:** Keep the [Telegram Bot API reference](https://core.telegram.org/bots/api) open while working.
> Per the official docs:
> - Optional fields may not be returned when irrelevant — which is why all optional fields in ziogram default to `null`
> - Integer fields are `i32` by default unless otherwise noted
> - Fields named `user_id` or `chat_id` are always `i64`

### 1. Create `src/methods/send_foo.zig`

```zig
const types = @import("types");

// Result is the exact return type of the method.
// Common values: bool, types.Message, types.MessageId, types.MessageOrBool, []const u8, i32
pub const Result = bool;
pub const method_name = "sendFoo"; // exact Telegram Bot API method name

// Required fields — no default value
chat_id: types.ChatId, // union(enum) { id: i64, username: []const u8 }

// Optional fields — must default to null
foo: ?[]const u8 = null,
bar: ?i32 = null,
```

> If the method accepts a file, use `types.InputFile` for that field.
> `ClientSession.makeRequest` switches to `multipart/form-data` automatically when an `InputFile` field is present.

**Result type reference:**

| Telegram returns | Zig type |
|---|---|
| `true` on success | `bool` |
| Message object | `types.Message` |
| Message or `true` | `types.MessageOrBool` |
| Message ID only | `types.MessageId` |
| String | `[]const u8` |

### 2. Export in `src/methods/root.zig`

```zig
pub const SendFoo = @import("send_foo.zig");
```

### 3. Add a wrapper to `src/client/bot.zig`

```zig
// bool — method returns true on success
pub fn sendFoo(
    self: *const Bot,
    arena: *std.heap.ArenaAllocator,
    options: struct {
        chat_id: types.ChatId,
        foo: ?[]const u8 = null,
        bar: ?i32 = null,
        request_timeout: ?i32 = null,
    },
) !bool {
    return self.call(
        arena.allocator(),
        methods.SendFoo{
            .chat_id = options.chat_id,
            .foo = options.foo,
            .bar = options.bar,
        },
        options.request_timeout,
    );
}
```

> Note: the wrapper takes an anonymous struct with all method fields plus `request_timeout`.
> Required fields have no default, optional fields default to `null`, `request_timeout` always defaults to `null`.

### 4. Update the README roadmap

Add a `[x]` entry for the new method in the **API Methods** section of `README.md`.

---

## Running Tests

Tests are written directly in the source files they test (at the bottom of each `.zig` file) and require no Telegram token or network connection.

```sh
zig build test
```

The test suite covers:

| File | What is tested |
|------|----------------|
| `src/client/server.zig` | URL generation for production/testing, `toLocal`/`toServer` path mapping, local paths |
| `src/client/simple.zig` | `toLocal`/`toServer` path remapping, unknown path returns as-is |
| `src/errors.zig` | `makeTelegramError`, `makeRetryAfter`, `makeMigrateToChat`, `makeDecodeError` — message content, labels, url generation, extra fields |

When adding a new feature, please add tests for any pure logic (string formatting, struct field logic, etc.) that does not require a network connection.

---

## Code Style

- Formatting is handled automatically by [ZLS](https://github.com/zigtools/zls) on save — no manual `zig fmt` needed if you use an editor with ZLS
- All public declarations must have `///` doc comments
- Optional struct fields must always default to `null`
- Prefer `ArenaAllocator` per request — callers own all returned memory
- Use comptime over runtime reflection wherever possible
- Keep method structs flat — no nesting beyond what the Telegram API requires

---

## Commit Messages

```
<type>: <short description>
```

| Type | When to use |
|------|-------------|
| `feat` | New method or feature |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `refactor` | No behavior change |
| `test` | Tests only |
| `chore` | Build, deps, tooling |

**Examples:**
```
feat: add sendPoll method
fix: handle migrate_to_chat_id in checkResponse
test: add tests for makeRetryAfter with username chat_id
chore: bump version to 0.0.0 in build.zig.zon
```

---

## Pull Requests

- Target the `main` branch
- One feature or fix per PR
- Reference related issues: `Fixes #123`
- Ensure `zig build test` passes before submitting
- Keep the method pattern consistent:
  - struct in `src/methods/`
  - export in `src/methods/root.zig`
  - wrapper in `src/client/bot.zig`

---

## Reporting Bugs

Use the [Bug Report](.github/ISSUE_TEMPLATE/bug_report.md) template and include:

- Zig version (`zig version`)
- ziogram version (from `build.zig.zon`) or commit hash
- Minimal reproducible example
- Full error output including any `ZiogramError` log lines:
  ```
  error: Telegram API Error: Method 'sendMessage' failed (403): ...
  error: Client Error: Failed to decode object ...
  ```

---

## Questions?

Open a [Discussion](https://github.com/atcoun/ziogram/discussions) or an issue with the `question` label.
