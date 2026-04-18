<div align="center">

<img src="https://img.shields.io/badge/Zig-0.16.0-F7A41D?style=for-the-badge&logo=zig&logoColor=white" alt="Zig Version"/>
<img src="https://img.shields.io/badge/Telegram_Bot_API-9.6-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white" alt="Telegram Bot API"/>
<img src="https://img.shields.io/badge/Status-Usable_(80%25)-yellow?style=for-the-badge" alt="Status Usable 80%"/>
<img src="https://img.shields.io/badge/License-MIT-green?style=for-the-badge" alt="License MIT"/>

# ✈🤖⚡ ziogram

**A high-performance, strictly-typed framework for the [Telegram Bot API](https://core.telegram.org/bots/api), engineered in [Zig](https://ziglang.org).**

*Zero-overhead abstractions. Compile-time safety. No compromises.*

</div>

---

> [!NOTE]
> **Status: ~80% complete — usable, but not yet feature-complete**
> 
> The library is ready to use for most bot development tasks. All Telegram object types and enums are fully implemented, and ~90% of API methods are covered. The remaining gaps are webhook support and a file download helper — `getFile` returns file metadata, but downloading the actual bytes from Telegram servers is not yet supported.

> [!WARNING]
> Not recommended for production-critical environments. Since Zig has not yet reached v1.0.0, API stability and backward compatibility are subject to change. This library is provided "as is" without warranty of any kind. Use at your own discretion.

---

## 🧠 Core Philosophy

**ziogram** provides a zero-overhead abstraction layer designed for building scalable, memory-efficient Telegram bots. By leveraging modern systems programming, it ensures maximum performance without sacrificing developer experience.

The name represents the synergy of its foundational technologies:

| Letter | Stands for | Description |
|--------|-----------|-------------|
| **z** | **Zig** | A general-purpose language and toolchain for robust, optimal, reusable software |
| **io** | **Standard I/O** | Zig's cross-platform `std.Io` interface abstracting filesystem, networking, async/concurrent tasks, timers, randomness, and more |
| **gram** | **Telegram Bot API** | An HTTP-based interface for building Telegram bots |

---

## 🏗 Technical Architecture

### Comptime-First Design
Every API method is a plain Zig struct with two comptime constants — `ReturnType` and `api_method` — that drive the generic `Bot.call` dispatcher with zero runtime overhead.

```zig
pub const GetMe = struct {
    pub const ReturnType = User;
    pub const api_method = "getMe";
};
```

### Native Networking
Built on `std.http.Client` and `std.Io` for thread-safe, hardware-optimized I/O. `std.Io` provides a unified interface for networking, filesystem, async/concurrent tasks (`Group`, `Future`, `Select`), timers, and randomness. Requests are automatically dispatched as `GET` or `POST` based on payload presence.

### Smart Serialization
Uses `std.json` with `ArenaAllocator` strategies. Struct fields are reflected at comptime — optional fields are omitted from the JSON output automatically (`emit_null_optional_fields = false`).

### Multipart File Uploads
`InputFile` is a tagged union supporting filesystem paths, in-memory buffers, `file_id`, and URLs. Files are transparently streamed as `multipart/form-data` — the same `sendPhoto` call works for all input types.

### Structured Error Handling
All Telegram API errors map to typed `ZiogramError` variants. Rate limits, group migrations, decode failures, and HTTP errors each produce a `DetailedError` with a human-readable message and a link to the relevant Telegram docs page.

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
zig fetch --save git+https://codeberg.org/atcoun/ziogram.git
```

**3. Open your project's `build.zig` and add ziogram to your executable**

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

// after
const exe = b.addExecutable(.{
    .name = "project",
    .root_module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "project", .module = mod },
            .{ .name = "ziogram", .module = b.dependency("ziogram", .{
                .target = target,
                .optimize = optimize,
            }).module("ziogram") },
        },
    }),
});
```

---

## 🚀 Quick Start

### Initialization

`Bot` is created from a token and a `ClientSession`. The session owns the HTTP client and the allocator.

```zig
const std = @import("std");
const ziogram = @import("ziogram");

const ClientSession = ziogram.ClientSession;
const Bot = ziogram.Bot;

pub fn main(init: std.process.Init) !void {
    const token = "YOUR_BOT_TOKEN";

    var session = try ClientSession.init(init.gpa, init.io, null);
    defer session.deinit();

    var bot = try Bot.init(token, session, null);
    defer bot.deinit();

    const allocator = init.arena.allocator();

    const me = try bot.getMe(allocator);
    const info = try std.json.Stringify.valueAlloc(allocator, me, .{
        .whitespace = .indent_4,
        .emit_null_optional_fields = false,
    });
    std.log.info("{s}", .{info});
}
```

> [!TIP]
> Use an `ArenaAllocator` per update/request — all returned slices and structs are allocated into it and freed in one shot. In a loop, prefer `arena.reset(.retain_capacity)` over `deinit` + `init` to reuse the allocated buffer across iterations.

```zig
var arena = std.heap.ArenaAllocator.init(gpa);
defer arena.deinit();

var offset: i32 = 0;

while (true) {
    const allocator = arena.allocator();

    const updates = try bot.getUpdates(allocator, .{ .offset = offset });
    
    for (updates) |update| {
        // process update...
        offset = update.update_id + 1;
        
        _ = arena.reset(.retain_capacity);
    }
}
```

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

### Long Polling Loop

```zig
const std = @import("std");
const ziogram = @import("ziogram");

const ClientSession = ziogram.ClientSession;
const Bot = ziogram.Bot;

const types = ziogram.types;
const Message = types.Message;
const CallbackQuery = types.CallbackQuery;
const Update = types.Update;

pub fn main(init: std.process.Init) !void {
    const arena = init.arena;
    const gpa = init.gpa;
    const io = init.io;

    const token = "YOUR_BOT_TOKEN";

    const session = try ClientSession.init(gpa, init.io, null);
    defer session.deinit();

    const bot = try Bot.init(token, session, .{ .parse_mode = .HTML });
    defer bot.deinit();

    var group = std.Io.Group.init;
    defer group.await(io) catch {};

    {
        const allocator = arena.allocator();
        _ = try bot.deleteWebhook(allocator, .{ .drop_pending_updates = true });
        const me = try bot.getMe(allocator);
        if (me.username) |username| std.log.info("Authorized as @{s}", .{username});
    }

    var offset: i32 = 0;
    
    while (true) {
        const allocator = arena.allocator();

        const updates = bot.getUpdates(allocator, .{
            .offset = offset,
            .timeout = 60,
            .allowed_updates = &.{
                .message,
            },
        }) catch |err| {
            std.log.warn("Network error in getUpdates: {any}. Retrying in 10 seconds...", .{err});
            const delay = std.Io.Duration.fromSeconds(10);
            try io.sleep(delay, .awake);
            continue;
        };

        for (updates) |update| {
            try group.concurrent(io, handle_update, .{ gpa, bot, update });
            offset = update.update_id + 1;
        }

        try group.await(io);

        _ = arena.reset(.retain_capacity);
    }
}

pub fn handle_update(gpa: std.mem.Allocator, bot: Bot, update: Update) !void {
    var arena = std.heap.ArenaAllocator.init(gpa);
    defer arena.deinit();

    const allocator = arena.allocator();

    if (update.message) |message| {
        handle_message(allocator, bot, message) catch |err| {
            std.log.err("Error [handle_message]: {any}", .{err});
        };
    }
}

pub fn handle_message(allocator: std.mem.Allocator, bot: Bot, message: Message) !void {
    _ = bot.sendMessage(allocator, .{
        .chat_id = .{ .id = message.chat.id },
        .text = "Hello from <b>ziogram</b>! ⚡",
    }) catch |err| {
        std.log.err("Error [sendMessage]: {any}", .{err});
        return err;
    };
}
```

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
// (Telegram servers will download the file from the URL or reuse the file_id)
_ = try bot.sendPhoto(allocator, .{
    .chat_id = .{ .id = 1234567890 }, // or .{ .username = "@username" }
    .photo = .{ .url = "https://example.com" }, // or .file_id = "..."
});

// Upload a file from an in-memory buffer
_ = try bot.sendPhoto(allocator, .{
    .chat_id = .{ .id = 1234567890 }, // or .{ .username = "@username" }
    .photo = .fromBuffer(io, allocator, buffer),
});
```

---

### Bot Options

Set once on `Bot.init` — applied to every method call that supports the field, unless overridden per-call.

```zig
var bot = try Bot.init(token, session, .{
    .parse_mode               = .MarkdownV2,
    .disable_notification     = true,
    .protect_content          = true,
    .link_preview_is_disabled = true,
});
```

---

### Using a Local Bot API Server

```zig
const local_api = try ziogram.TelegramAPI.fromBase(init.gpa, "http://localhost:8081");

var session = try ClientSession.init(init.gpa, init.io, null);
session.base.api = local_api;
```

For path mapping between the local server and your filesystem:

```zig
local_api.wrap_local_file = .{ .simple = .{
    .server_path = "/var/lib/telegram-bot-api/",
    .local_path  = "/mnt/bot-storage/",
}};
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

## 🗂 Project Structure

```
ziogram/
├── src/
│   ├── client/
│   │   ├── session/
│   │   │   ├── base.zig          # BaseSession: JSON serialization, response validation
│   │   │   └── http_client.zig   # ClientSession: HTTP transport, multipart upload
│   │   ├── bot.zig               # Bot: high-level API method wrappers
│   │   ├── bot_options.zig       # BotOptions: per-bot options
│   │   └── telegram_api.zig      # TelegramAPI: URL templates, local server support
│   ├── enums/
│   ├── methods/                  # One file per Bot API method
│   ├── types/                    # Telegram object types
│   ├── enums.zig
│   ├── errors.zig                # ZiogramError + DetailedError builders
│   ├── root.zig
│   └── types.zig
├── build.zig
├── build.zig.zon
├── LICENSE
└── README.md
```

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
- [ ] Webhook support
- [x] `getFile` — returns file metadata (`File` object with `file_path`)
- [ ] File download helper — `fileUrl` is built into `TelegramAPI` but `ClientSession` has no `downloadFile` method yet

### API Methods (~90% complete)
- [x] `sendDocument`, `sendVideo`, `sendAudio`, `sendVoice`
- [x] `editMessageText`, `deleteMessage`, `copyMessage`
- [x] `setChatTitle`, `banChatMember`, admin methods
- [x] Inline Mode (`InlineQueryResult*`)
- [x] Payments API
- [x] Stories, Business API, Gifts, Stars, Stickers, Games, Passport, and more

---

## 🤝 Contributing

Contributions are welcome! Since this is an early-stage project, feel free to:

1. Open an **issue** to discuss a feature, bug, or design question
2. Submit a **pull request** for fixes or new method implementations

Adding a new method? Follow the existing pattern:
- One struct in `src/methods/` with `ReturnType` and `api_method`
- One wrapper function in `src/client/bot.zig`

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

---

<div align="center">

Built with ❤️ and ⚡ by [atcoun](https://codeberg.org/atcoun) · [Codeberg](https://codeberg.org/atcoun/ziogram)

</div>
