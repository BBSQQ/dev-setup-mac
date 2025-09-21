# 🚀 macOS 开发环境自动化配置

一键配置完整的 macOS 开发环境，包括终端、编程工具、主题和 GitHub 集成。

## 📋 功能概览

### ✨ 已配置的功能

#### 🖥️ 终端增强
- **iTerm2** - 强大的终端应用
- **Zsh + Pure 主题** - 优雅的命令行界面
- **智能补全** - 命令历史建议、语法高亮、文件补全
- **Nerd Font** - 支持图标的字体

#### 🛠️ 开发工具
- **Homebrew** - 包管理器
- **Git 2.51.0** - 版本控制（已配置用户信息）
- **Node.js v24.8.0** - JavaScript 运行时
- **Python 3.12.11** - Python 解释器
- **Go 1.25.1** - Go 编程语言
- **Rust 1.89.0** - Rust 编程语言
- **Visual Studio Code** - 代码编辑器

#### 🎨 主题和美化
- **iTerm2 颜色主题** - Dracula、One Dark、Solarized Dark
- **Pure zsh 主题** - 极简优雅的提示符
- **语法高亮** - 实时命令验证
- **MesloLGS Nerd Font** - 支持图标的编程字体

#### 🔐 GitHub 集成
- **SSH 密钥配置** - ED25519 算法
- **Git 全局配置** - 用户信息和推送设置
- **SSH 代理** - 自动密钥管理

## 🚀 快速开始

### 全新系统一键安装
```bash
curl -fsSL https://raw.githubusercontent.com/bbsqq/dev-setup/main/install.sh | bash
```

### 手动安装步骤
1. **克隆此仓库**
   ```bash
   git clone https://github.com/bbsqq/dev-setup.git
   cd dev-setup
   ```

2. **运行安装脚本**
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

3. **配置 GitHub SSH**
   ```bash
   ./scripts/setup-github.sh
   ```

## 📁 项目结构

```
dev-setup/
├── README.md                 # 主文档
├── install.sh               # 一键安装脚本
├── scripts/                 # 功能脚本
│   ├── install-homebrew.sh  # Homebrew 安装
│   ├── install-tools.sh     # 开发工具安装
│   ├── setup-zsh.sh         # Zsh 配置
│   ├── setup-themes.sh      # 主题配置
│   └── setup-github.sh      # GitHub SSH 配置
├── configs/                 # 配置文件模板
│   ├── .zshrc.template      # Zsh 配置模板
│   ├── .p10k.zsh.template   # Powerlevel10k 配置
│   ├── ssh-config.template  # SSH 配置模板
│   └── gitconfig.template   # Git 配置模板
├── themes/                  # iTerm2 主题文件
│   ├── Dracula.itermcolors
│   ├── One-Dark.itermcolors
│   └── Solarized-Dark.itermcolors
└── docs/                    # 详细文档
    ├── COMMANDS.md          # 常用命令参考
    ├── THEMES.md            # 主题切换指南
    └── TROUBLESHOOTING.md   # 故障排除
```

## 🎯 已配置的功能详情

### Zsh 增强功能
- ✅ **智能历史** - 10000 条命令历史，去重共享
- ✅ **自动补全** - 文件、命令、Git 分支补全
- ✅ **语法高亮** - 实时命令验证
- ✅ **历史建议** - 基于历史的命令建议
- ✅ **便捷别名** - `ll`, `la`, `gs`, `ga`, `gc` 等

### Git 配置
- ✅ **用户信息** - bbsqq (1491812683@qq.com)
- ✅ **SSH 密钥** - ED25519 算法
- ✅ **默认分支** - main
- ✅ **推送配置** - 自动设置上游分支

### 开发工具版本
| 工具 | 版本 | 描述 |
|------|------|------|
| Homebrew | 4.6.11 | 包管理器 |
| Git | 2.51.0 | 版本控制 |
| Node.js | v24.8.0 | JavaScript 运行时 |
| Python | 3.12.11 | Python 解释器 |
| Go | 1.25.1 | Go 编程语言 |
| Rust | 1.89.0 | Rust 编程语言 |
| VS Code | 1.104.1 | 代码编辑器 |

## 🎨 主题切换

### 切换 zsh 主题
```bash
# Pure 主题（当前）
./scripts/set-theme.sh pure

# Powerlevel10k 主题
./scripts/set-theme.sh p10k

# Spaceship 主题
./scripts/set-theme.sh spaceship
```

### 应用 iTerm2 主题
1. `iTerm2 → Preferences → Profiles → Colors`
2. `Color Presets... → Import...`
3. 选择 `themes/` 目录中的主题文件

## 🔧 自定义配置

### 修改用户信息
```bash
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱"
```

### 添加新的别名
编辑 `~/.zshrc` 文件，在别名部分添加：
```bash
alias myalias='your-command'
```

### 安装额外工具
```bash
# 使用 Homebrew 安装
brew install tool-name

# 使用 Homebrew Cask 安装应用
brew install --cask app-name
```

## 🆘 故障排除

### 常见问题
1. **Homebrew 安装失败** - 检查网络连接，使用国内镜像
2. **SSH 连接 GitHub 失败** - 检查 SSH 密钥是否正确添加
3. **主题显示异常** - 确保安装了 Nerd Font 字体
4. **命令补全不工作** - 重新加载配置 `source ~/.zshrc`

### 重置配置
```bash
# 备份当前配置
cp ~/.zshrc ~/.zshrc.backup

# 重新应用配置
./scripts/setup-zsh.sh
```

## 📚 更多资源

- [Homebrew 官网](https://brew.sh/)
- [Pure zsh 主题](https://github.com/sindresorhus/pure)
- [iTerm2 官网](https://iterm2.com/)
- [Nerd Fonts](https://www.nerdfonts.com/)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request 来改进这个配置！

## 📄 许可证

MIT License

---

> 💡 **提示**: 运行 `source ~/.zshrc` 重新加载配置，或重启终端应用新设置。