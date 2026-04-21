# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| latest (`main`) | ✅ |

## Reporting a Vulnerability

**Please do not report security vulnerabilities via public GitHub Issues.**

Report it through GitHub's private disclosure:

1. Go to the [Security tab](https://github.com/atcoun/ziogram/security)
2. Click **"Report a vulnerability"**

Please include:

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

I will review the report and respond as soon as possible. Confirmed issues will be patched at the earliest opportunity.

## Scope

This policy covers the ziogram library code itself (`src/`). Issues with the Telegram Bot API should be reported to [Telegram](https://telegram.org/support).

## Notes

- Bot tokens in code examples are placeholders (`"YOUR_BOT_TOKEN"`) — never commit real tokens
- When using webhooks, always set `secret_token` in `setWebhook` to prevent unauthorized requests
- Avoid logging raw `content` from `makeDecodeError` in production — it may contain sensitive update data
