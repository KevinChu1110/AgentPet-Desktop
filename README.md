# AgentPet Desktop 👾

[繁體中文](#繁體中文) | [English](#english)

---

## 繁體中文

**AgentPet Desktop** 是一款專為開發者設計的選單列電子雞。它能與您的 CLI 工具（如 `gemini-cli`, `claude-code`）連動，每當您使用 AI 解決問題，您的寵物就會獲得經驗值並進化！

### ✨ 核心特色
- **選單列陪伴**：寵物直接駐留在 macOS 選單列，隨時觀察狀態。
- **CLI 經驗連動**：透過簡單的 Hook，讓任何終端機指令都能為寵物增加 EXP。
- **進化系統**：從蛋 (Egg) 慢慢成長為完全體 (Adult)。
- **輕量高效**：使用 Swift 原生開發，佔用極少系統資源。

### 🚀 終端機連動設定
在您的 `~/.zshrc` 或 `~/.bashrc` 加入以下代碼，即可連動 `gemini`：

```bash
function gemini() {
    command gemini "$@"
    # 指令執行完後，自動餵食寵物
    curl -s http://localhost:8088/feed > /dev/null &
}
```

---

## English

**AgentPet Desktop** is a menu bar Tamagotchi designed for developers. It integrates with your CLI tools. Every time you interact with an AI, your pet gains EXP and evolves!

### ✨ Features
- **Menu Bar Companion**: Your pet lives in your macOS menu bar.
- **CLI Integration**: Gains EXP automatically via simple shell hooks.
- **Evolution System**: Watch your pet grow from an Egg to an Adult.
- **Native & Lightweight**: Built with Swift for maximum performance.

### 🚀 CLI Setup
Add this to your `~/.zshrc` or `~/.bashrc` to hook with `gemini-cli`:

```bash
function gemini() {
    command gemini "$@"
    curl -s http://localhost:8088/feed > /dev/null &
}
```

---

## License
MIT License. Created with ❤️ by [KevinChu1110](https://github.com/KevinChu1110)
