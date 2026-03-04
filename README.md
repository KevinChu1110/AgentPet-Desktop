# AgentPet Desktop 👾

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Donate-orange?style=flat-square&logo=buy-me-a-coffee)](https://buymeacoffee.com/guanrung11n)

[繁體中文](#繁體中文) | [English](#english)

---

## 繁體中文

**AgentPet Desktop** 是一款專為開發者設計的選單列電子雞。它能與您的 CLI 工具（如 `gemini-cli`, `claude-code`）連動，每當您使用 AI 解決問題，您的寵物就會獲得經驗值並進化！

### ✨ 核心特色
- **選單列陪伴**：寵物直接駐留在 macOS 選單列，隨時觀察狀態。
- **CLI 經驗連動**：透過簡單的 Hook，讓指令執行完後寵物即時回饋台詞。
- **進化系統**：從蛋 (Egg) 成長為完全體 (Adult)。
- **GitHub 勳章**：一鍵複製動態等級勳章，展示在您的 GitHub Profile。

### 🚀 終端機連動設定
在您的 `~/.zshrc` 或 `~/.bashrc` 加入以下代碼：

```bash
function gemini() {
    command gemini "$@"
    # 抓取寵物的回覆並印出來
    REPLY=$(curl -s "http://localhost:8088/feed?context=success")
    echo -e "\n$REPLY"
}
```

### ☕️ 支持開發者
如果您喜歡這個專案，歡迎請我喝杯咖啡！
👉 [Buy Me a Coffee](https://buymeacoffee.com/guanrung11n)

---

## English

**AgentPet Desktop** is a menu bar Tamagotchi designed for developers. It integrates with your CLI tools and responds to your work in real-time.

### ✨ Features
- **Menu Bar Companion**: Your pet lives in your macOS menu bar.
- **CLI Real-time Feedback**: Your pet talks back to you in the terminal after commands.
- **Evolution System**: Watch your pet grow based on your productivity.
- **GitHub Badges**: Display your pet's level on your GitHub Profile.

### 🚀 CLI Setup
```bash
function gemini() {
    command gemini "$@"
    REPLY=$(curl -s "http://localhost:8088/feed?context=success")
    echo -e "\n$REPLY"
}
```

### ☕️ Support
👉 [Buy Me a Coffee](https://buymeacoffee.com/guanrung11n)

---

## License
MIT License. Created with ❤️ by [KevinChu1110](https://github.com/KevinChu1110)
