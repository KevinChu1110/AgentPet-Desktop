# AgentPet Desktop 👾

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Donate-orange?style=flat-square&logo=buy-me-a-coffee)](https://buymeacoffee.com/guanrung11n)

[繁體中文](#繁體中文) | [English](#english)

---

## 繁體中文

**AgentPet Desktop** 是一款專為開發者設計的選單列電子雞。它能與您的 AI CLI 工具連動，每當您與 AI 互動，您的寵物就會獲得經驗值並進化！

### ✨ 核心特色
- **選單列陪伴**：寵物直接駐留在 macOS 選單列，隨時觀察狀態。
- **CLI 雙向連動**：指令執行完後寵物會直接在終端機回饋台詞。
- **進化系統**：從蛋 (Egg) 成長為完全體 (Adult)。
- **GitHub 勳章**：一鍵複製動態等級勳章，展示在您的 GitHub Profile。

### 🚀 終端機連動設定 (常用 AI 工具)
在您的 `~/.zshrc` 或 `~/.bashrc` 加入以下代碼，即可全面支援主流 AI 工具：

```bash
# AgentPet 餵食函式
function _pet_feed() {
    local context=$1
    REPLY=$(curl -s "http://localhost:8088/feed?context=${context}")
    echo -e "\n$REPLY"
}

# 支援 Gemini CLI
function gemini() {
    command gemini "$@"
    _pet_feed "success"
}

# 支援 Claude Code
function claude() {
    command claude "$@"
    _pet_feed "success"
}

# 支援 GitHub Copilot CLI
function gh() {
    if [[ "$1" == "copilot" ]]; then
        command gh "$@"
        _pet_feed "success"
    else
        command gh "$@"
    fi
}

# 支援 Ollama (本地模型)
function ollama() {
    command ollama "$@"
    if [[ "$1" == "run" ]]; then
        _pet_feed "success"
    fi
}
```

### ☕️ 支持開發者
如果您喜歡這個專案，歡迎請我喝杯咖啡！
👉 [Buy Me a Coffee](https://buymeacoffee.com/guanrung11n)

---

## English

**AgentPet Desktop** is a menu bar Tamagotchi for developers. It supports major AI CLI tools like Gemini, Claude Code, GitHub Copilot, and Ollama.

### 🚀 Common AI CLI Hooks
Add these to your shell config (`~/.zshrc` or `~/.bashrc`):

```bash
function _pet_feed() {
    REPLY=$(curl -s "http://localhost:8088/feed?context=success")
    echo -e "\n$REPLY"
}

alias gemini='gemini && _pet_feed'
alias claude='claude && _pet_feed'
# Works with any AI command!
```

---

## License
MIT License. Created with ❤️ by [KevinChu1110](https://github.com/KevinChu1110)
