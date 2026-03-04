# AgentPet Desktop 👾

[![Buy Me a Coffee](https://img.shields.io/badge/Buy%20Me%20a%20Coffee-Donate-orange?style=flat-square&logo=buy-me-a-coffee)](https://buymeacoffee.com/guanrung11n)

[繁體中文](#繁體中文) | [English](#english)

---

## 繁體中文

**AgentPet Desktop** 是一款專為開發者設計的選單列電子雞。它能與您的 AI CLI 工具（如 `gemini-cli`, `claude-code`, `ollama`）連動，每當您使用 AI 解決問題，您的寵物就會獲得經驗值、進化，並在矽谷世界中冒險！

### ✨ 核心特色
- **選單列陪伴**：寵物直接駐留在 macOS 選單列，隨時觀察狀態。
- **CLI 雙向連動**：指令執行完後寵物會直接在終端機回饋台詞。
- **進化系統**：從蛋 (Egg) 成長為完全體 (Adult)，外觀會隨等級改變。
- **GitHub 勳章**：一鍵複製動態等級勳章，展示在您的 GitHub Profile。

### 🗺️ 冒險系統 (Adventure System)
您的寵物正帶領您穿越各種充滿挑戰的開發區域：
1. **虛擬森林 (Virtual Forest)**：面對史萊姆級的語法錯誤。
2. **編譯荒漠 (Compiler Desert)**：在缺少括號的風暴中生存。
3. **雲端神殿 (Cloud Temple)**：挑戰分散式架構的試煉。
4. **神經網路海** -> **量子核心**... (持續擴張中)

### 🚀 終端機連動設定
在您的 `~/.zshrc` 或 `~/.bashrc` 加入以下代碼，即可連動主流 AI 工具：

```bash
# AgentPet 餵食核心函式
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

# 支援 Ollama
function ollama() {
    command ollama "$@"
    if [[ "$1" == "run" ]]; then
        _pet_feed "success"
    fi
}
```

---

## English

**AgentPet Desktop** is a menu bar Tamagotchi designed specifically for developers. It integrates with your AI CLI tools (Gemini, Claude, Ollama, etc.). Every time you interact with AI, your pet gains EXP, evolves, and explores the vast digital world!

### ✨ Key Features
- **Menu Bar Companion**: Your pet lives in your macOS menu bar.
- **CLI Real-time Feedback**: Your pet talks back to you in the terminal after each command.
- **Evolution System**: Watch your pet grow from an Egg to a full-grown Dragon.
- **GitHub Badges**: Show off your pet's level on your GitHub Profile.

### 🗺️ Adventure System
Guide your pet through various coding realms:
1. **Virtual Forest**: Fight slime-level syntax errors.
2. **Compiler Desert**: Survive the storms of missing brackets.
3. **Cloud Temple**: Master the trials of distributed architecture.
4. **Neural Ocean** -> **Quantum Core**... and beyond!

### 🚀 CLI Integration Setup
Add the following to your `~/.zshrc` or `~/.bashrc`:

```bash
# AgentPet Core Feeding Function
function _pet_feed() {
    local context=$1
    REPLY=$(curl -s "http://localhost:8088/feed?context=${context}")
    echo -e "\n$REPLY"
}

# Support Gemini CLI
function gemini() {
    command gemini "$@"
    _pet_feed "success"
}

# Support Claude Code
function claude() {
    command claude "$@"
    _pet_feed "success"
}

# Support Ollama
function ollama() {
    command ollama "$@"
    if [[ "$1" == "run" ]]; then
        _pet_feed "success"
    fi
}
```

---

## ☕️ Support
If you love this project, please consider buying me a coffee!
👉 [Buy Me a Coffee](https://buymeacoffee.com/guanrung11n)

---

## License
MIT License. Created with ❤️ by [KevinChu1110](https://github.com/KevinChu1110)
