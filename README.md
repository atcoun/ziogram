<div align="center">

<img src="https://img.shields.io/badge/Zig-0.16.0-F7A41D?style=for-the-badge&logo=zig&logoColor=white" alt="Zig Version"/>
<img src="https://img.shields.io/badge/Telegram_Bot_API-9.6-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram Bot API"/>
<img src="https://img.shields.io/badge/Status-Usable_(95%25)-brightgreen?style=for-the-badge" alt="Status Usable 95%"/>
<img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License MIT"/>

# ✈🤖⚡ ziogram

**A high-performance, strictly-typed framework for the [Telegram Bot API](https://core.telegram.org/bots/api), engineered in [Zig](https://ziglang.org).**

*Zero-overhead abstractions. Compile-time safety. No compromises.*

*Tired of runtimes that waste RAM and burn CPU cycles? Your bot deserves better — ziogram runs lean, fast, and predictable from the first line of code.*

<br/>

[📦 Installation](#-installation) • [🚀 Quick Start](#-quick-start) • [📂 Examples](#-examples) • [🖥 Local Bot API](#using-a-local-bot-api-server) • [⚠️ Error Handling](#error-handling)

</div>

---

> [!NOTE]
> **Status: ~95% complete — usable, but not yet feature-complete**
>
> The library is ready to use for most bot development tasks. All Telegram object types, enums, and API methods are fully implemented. File downloading is fully supported via `Bot.download` and `Bot.downloadFile` — see [Downloading a File](#downloading-a-file). Webhook support is also available — see [Examples](#-examples).

> [!WARNING]
> Not recommended for production-critical environments. Since Zig has not yet reached v1.0.0, API stability and backward compatibility are subject to change. This library is provided "as is" without warranty of any kind. Use at your own discretion.

---

## 📦 Installation

### Prerequisites

- Zig 0.16.0+ [(Download here)](https://ziglang.org/download/)
- A valid [Telegram Bot Token](https://t.me/BotFather)

### Steps

**1. Create a new Zig project**

```sh
zig init
```

**2. Fetch and save the dependency**

```sh
zig fetch --save git+https://github.com/atcoun/ziogram.git
```

**3. Open your project's `build.zig` and add ziogram to your executable**

```zig
.{ .name = "ziogram", .module = b.dependency("ziogram", .{
    .target = target,
    .optimize = optimize,
}).module("ziogram") },
```

Find the `b.addExecutable` call and add ziogram to the `.imports` list:

```zig
// before
const exe = b.addExecutable(.{
    .name = "project",
    .root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "project", .module = mod },
        },
    }),
});
```

```zig
// after
const exe = b.addExecutable(.{
    .name = "project",
    .root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "project", .module = mod },
            .{ .name = "ziogram", .module = b.dependency("ziogram", .{ // <-
                .target = target,                                      // <-
                .optimize = optimize,                                  // <-
            }).module("ziogram") },                                    // <-
        },
    }),
});
```

**4. Write your bot in `src/main.zig`** — see [Examples](#-examples) for ready-to-use code

**5. Run**

```sh
zig build run
```

---

## 🚀 Quick Start

### Initialization

`Bot` is created from a token and a `Client`. The session owns the HTTP client and the allocator.

```zig
const std = @import("std");
const ziogram = @import("ziogram");

const Bot = ziogram.Bot;
const Client = ziogram.Client;

pub fn main(init: std.process.Init) !void {
    const token = "YOUR_BOT_TOKEN";

    var client = try Client.init(init.gpa, init.io, .{});
    defer client.deinit();

    var bot = try Bot.init(token, client, null);
    defer bot.deinit();

    const allocator = init.arena.allocator();

    const me = try bot.getMe(allocator, .{});
    const info = try std.json.Stringify.valueAlloc(allocator, me, .{
        .whitespace = .indent_4,
        .emit_null_optional_fields = false,
    });
    std.log.info("{s}", .{info});
}
```

> [!TIP]
> Use an `ArenaAllocator` per update/request — all returned slices and structs are allocated into it and freed in one shot. In a loop, prefer `arena.reset(.retain_capacity)` over `deinit` + `init` to reuse the allocated buffer across iterations.

---

### Sending a Message

```zig
const msg = try bot.sendMessage(allocator, .{
    .chat_id = .{ .id = 123456789 }, // or .{ .username = "@username" }
    .text = "Hello from <b>ziogram</b>! ⚡",
    .parse_mode = .HTML,
});

std.log.info("Sent message id: {d}", .{msg.message_id});
```

> [!NOTE]
> `.{ .username = "@username" }` works for public groups and channels. For private chats, Telegram requires a numeric `user_id` — the bot must have received at least one message from the user first.

---

## 📂 Examples

Ready-to-use examples are available in the [`examples/`](examples/) directory:

| File | Description |
|------|-------------|
| [`echo_bot.zig`](examples/echo_bot.zig) | Long polling — receives updates via `getUpdates` |
| [`echo_bot_webhook.zig`](examples/echo_bot_webhook.zig) | Webhook — listens for incoming HTTPS requests from Telegram |

---

### Sending a Photo

`InputFile` accepts a filesystem path, an in-memory buffer, a `file_id`, or a URL — the transport (multipart vs JSON) is selected automatically.

```zig
// Upload a file from the local filesystem
_ = try bot.sendPhoto(allocator, .{
    .chat_id = .{ .id = 1234567890 }, // or .{ .username = "@username" }
    .photo = .fromPath("media/photo.png"),
    .caption = "Sent via ziogram",
});

// Send a photo using a remote URL or an existing file_id
_ = try bot.sendPhoto(allocator, .{
    .chat_id = .{ .id = 1234567890 },
    .photo = .{ .url = "https://example.com" }, // or .file_id = "..."
});

// Upload a file from an in-memory buffer
const photo_file = try InputFile.fromPathBuffered(session.io, allocator, "media/photo.png");
_ = try bot.sendPhoto(allocator, .{
    .chat_id = .{ .id = 1234567890 },
    .photo = photo_file,
});

// Or wrap an existing in-memory buffer directly:
_ = try bot.sendPhoto(allocator, .{
    .chat_id = .{ .id = 1234567890 },
    .photo = InputFile.fromBuffer(my_buffer, "photo.png"),
});
```

---

### Downloading a File

Two methods are available depending on what you already have.

**`Bot.download`** — high-level helper. Pass a `file_id`; the library calls `getFile` internally and streams the bytes to any `std.Io.Writer`.

```zig
var file = try std.Io.Dir.cwd().createFile(client.io, "photo.jpg", .{});
defer file.close(client.io);

var buf: [65536]u8 = undefined;
var writer = file.writer(client.io, &buf);

try bot.download(allocator, some_file_id, &writer.interface);
```

**`Bot.downloadFile`** — low-level variant. Use it when you already have a `file_path` from a `File` object returned by `getFile`.

```zig
const file_meta = try bot.getFile(allocator, .{ .file_id = some_file_id });
const path = file_meta.file_path orelse return error.TelegramFileTooLarge;

try bot.downloadFile(allocator, path, &writer.interface);
```

---

### Bot Options

Set once on `Bot.init` — applied to every method call that supports the field, unless overridden per-call.

```zig
var bot = try Bot.init(token, client, .{
    .parse_mode               = .MarkdownV2,
    .disable_notification     = true,
    .protect_content          = true,
    .link_preview_is_disabled = true,
});
```

---

### Using a Local Bot API Server

```zig
var api = try TelegramAPI.fromBase(init.gpa, "http://localhost:8081", null);
defer api.deinit(gpa);

var client = try Client.init(init.gpa, init.io, .{ .api = api });
defer client.deinit();
```

For path mapping between the local server and your filesystem:

```zig
var api = try TelegramAPI.fromBase(init.gpa, "http://localhost:8081", .{
    .server_path = "/var/lib/telegram-bot-api/",
    .local_path  = "/mnt/bot-storage/",
});
```

---

### Error Handling

All errors are typed. Telegram-specific errors carry a `DetailedError` with a human-readable message and a docs URL, logged automatically before the error is returned.

```zig
bot.sendMessage(allocator, .{ .chat_id = .{ .id = id }, .text = "hi" }) catch |err| {
    switch (err) {
        error.TelegramForbiddenError => std.log.err("Bot was blocked", .{}),
        error.TelegramRetryAfter     => std.log.err("Rate limited — check logs for retry_after", .{}),
        error.TelegramBadRequest     => std.log.err("Bad request", .{}),
        else                         => return err,
    }
};
```

Full error set:

| Error | Trigger |
|---|---|
| `TelegramBadRequest` | HTTP 400 |
| `TelegramUnauthorizedError` | HTTP 401 — invalid token |
| `TelegramForbiddenError` | HTTP 403 — bot blocked / no access |
| `TelegramNotFound` | HTTP 404 |
| `TelegramConflictError` | HTTP 409 — another polling instance running |
| `TelegramEntityTooLarge` | HTTP 413 — file too big |
| `TelegramServerError` | HTTP 5xx |
| `TelegramRetryAfter` | Flood control — `retry_after` in response parameters |
| `TelegramMigrateToChat` | Group migrated to supergroup |
| `ClientDecodeError` | JSON decode failure |

---

## 🗺 Roadmap

### Core
- [x] `Bot.init` with `BotOptions`
- [x] Generic `Bot.call` dispatcher (comptime method resolution)
- [x] Long polling — `getUpdates`
- [x] `getMe`, `sendMessage`, `sendPhoto`
- [x] `answerCallbackQuery`, `deleteWebhook`
- [x] Multipart file upload (`InputFile` — fs, buffer, file_id, url)
- [x] Local Bot API server support with path mapping
- [x] Structured error handling with `DetailedError`
- [x] All Telegram object types (100% complete)
- [x] Webhook support
- [x] `getFile` — returns file metadata (`File` object with `file_path`)
- [x] File download — `Bot.download` (by `file_id`) and `Bot.downloadFile` (by `file_path`), with local Bot API server support

### API Methods (100% complete)
- [x] `sendDocument`, `sendVideo`, `sendAudio`, `sendVoice`
- [x] `editMessageText`, `deleteMessage`, `copyMessage`
- [x] `setChatTitle`, `banChatMember`, admin methods
- [x] Inline Mode (`InlineQueryResult*`)
- [x] Payments API
- [x] Stories, Business API, Gifts, Stars, Stickers, Games, Passport, and more

---

## 🤝 Contributing

Contributions are welcome! See [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to get started.

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Built with ❤️ and ⚡ by [atcoun](https://github.com/atcoun) · [ziogram](https://github.com/atcoun/ziogram)

*A deaf developer from Ukraine 🇺🇦*

</div>
