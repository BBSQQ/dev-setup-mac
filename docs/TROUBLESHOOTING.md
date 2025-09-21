# 🔧 故障排除指南

## 🚨 常见问题和解决方案

### 1. Homebrew 相关问题

#### 问题：Homebrew 安装失败
```bash
Error: Failed to connect to github.com
```

**解决方案：**
```bash
# 使用国内镜像安装
/bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"

# 或者配置代理
export https_proxy=http://proxy:port
export http_proxy=http://proxy:port
```

#### 问题：brew 命令找不到
```bash
zsh: command not found: brew
```

**解决方案：**
```bash
# 手动添加到 PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc  # Apple Silicon
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc     # Intel Mac
source ~/.zshrc
```

#### 问题：权限错误
```bash
Permission denied (publickey)
```

**解决方案：**
```bash
# 修复 Homebrew 权限
sudo chown -R $(whoami) $(brew --prefix)/*
```

### 2. Git 和 GitHub 问题

#### 问题：SSH 连接 GitHub 失败
```bash
Permission denied (publickey)
```

**解决方案：**
```bash
# 1. 检查 SSH 密钥
ls -la ~/.ssh/

# 2. 重新生成密钥
ssh-keygen -t ed25519 -C "your_email@example.com"

# 3. 添加到 SSH 代理
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# 4. 测试连接
ssh -T git@github.com
```

#### 问题：Git 推送失败
```bash
fatal: unable to access 'https://github.com/...': Failed to connect
```

**解决方案：**
```bash
# 使用 SSH 而不是 HTTPS
git remote set-url origin git@github.com:username/repo.git

# 或配置 Git 代理
git config --global http.proxy http://proxy:port
```

#### 问题：Git 用户信息未配置
```bash
Please tell me who you are
```

**解决方案：**
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### 3. Zsh 和终端问题

#### 问题：自动补全不工作
**解决方案：**
```bash
# 重新编译补全系统
rm -f ~/.zcompdump*
autoload -U compinit && compinit

# 重新加载配置
source ~/.zshrc
```

#### 问题：历史建议不显示
**解决方案：**
```bash
# 检查插件是否正确加载
ls ~/.zsh-plugins/zsh-autosuggestions/

# 重新安装插件
rm -rf ~/.zsh-plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh-plugins/zsh-autosuggestions

# 重新加载
source ~/.zshrc
```

#### 问题：主题显示异常
**解决方案：**
```bash
# 1. 确保安装了 Nerd Font
brew install --cask font-meslo-lg-nerd-font

# 2. 在 iTerm2 中设置字体
# Preferences → Profiles → Text → Font → MesloLGS Nerd Font

# 3. 重新安装主题
rm -rf ~/.zsh-themes/pure
git clone https://github.com/sindresorhus/pure.git ~/.zsh-themes/pure
```

#### 问题：语法高亮不工作
**解决方案：**
```bash
# 检查插件路径
ls ~/.zsh-plugins/zsh-syntax-highlighting/

# 重新安装
rm -rf ~/.zsh-plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-plugins/zsh-syntax-highlighting

# 确保在 .zshrc 末尾加载
echo "source ~/.zsh-plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
```

### 4. iTerm2 问题

#### 问题：字体显示异常
**解决方案：**
```bash
# 1. 安装 Nerd Font
brew install --cask font-meslo-lg-nerd-font

# 2. iTerm2 设置：
# Preferences → Profiles → Text
# Font: MesloLGS Nerd Font
# Size: 14-16
```

#### 问题：颜色主题不正确
**解决方案：**
```bash
# 1. 重新导入主题
# iTerm2 → Preferences → Profiles → Colors
# Color Presets... → Import...
# 选择 ~/.iterm2/themes/ 中的主题文件

# 2. 检查主题文件
ls ~/.iterm2/themes/
```

#### 问题：透明度设置无效
**解决方案：**
```bash
# iTerm2 → Preferences → Profiles → Window
# Transparency: 10-20%
# Blur: Enable
```

### 5. 开发工具问题

#### 问题：Node.js 版本冲突
**解决方案：**
```bash
# 使用 n 管理 Node.js 版本
npm install -g n
n latest    # 安装最新版本
n lts       # 安装 LTS 版本
n           # 选择版本
```

#### 问题：Python 版本问题
**解决方案：**
```bash
# 确保使用正确的 Python 版本
which python3
python3 --version

# 创建虚拟环境
python3 -m venv venv
source venv/bin/activate
```

#### 问题：VS Code 无法在终端启动
**解决方案：**
```bash
# 重新安装 VS Code 命令行工具
# VS Code → Command Palette (Cmd+Shift+P)
# "Shell Command: Install 'code' command in PATH"

# 或手动添加到 PATH
echo 'export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"' >> ~/.zshrc
```

### 6. 网络相关问题

#### 问题：下载速度慢
**解决方案：**
```bash
# 使用国内镜像
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles

# Git 配置国内镜像
git config --global url."https://gitee.com/".insteadOf "https://github.com/"
```

#### 问题：SSL 证书错误
**解决方案：**
```bash
# 更新证书
brew install ca-certificates

# Git 跳过 SSL 验证（临时）
git config --global http.sslVerify false
```

### 7. 系统级问题

#### 问题：权限不足
**解决方案：**
```bash
# 检查当前用户权限
groups $(whoami)

# 修复常见权限问题
sudo chown -R $(whoami) ~/.npm
sudo chown -R $(whoami) /usr/local/lib/node_modules
```

#### 问题：磁盘空间不足
**解决方案：**
```bash
# 清理 Homebrew 缓存
brew cleanup --prune=all

# 清理 npm 缓存
npm cache clean --force

# 清理系统缓存
sudo rm -rf ~/Library/Caches/*
```

#### 问题：系统更新后配置失效
**解决方案：**
```bash
# 重新安装 Xcode Command Line Tools
xcode-select --install

# 重新配置 shell
chsh -s /bin/zsh

# 重新应用配置
source ~/.zshrc
```

## 🔍 诊断命令

### 环境检查
```bash
# 检查 shell
echo $SHELL
echo $ZSH_VERSION

# 检查 PATH
echo $PATH | tr ':' '\n'

# 检查已安装工具
which git node python3 brew

# 检查版本
git --version
node --version
python3 --version
brew --version
```

### 网络诊断
```bash
# 测试网络连接
ping -c 3 google.com
ping -c 3 github.com

# 测试 DNS
nslookup github.com

# 测试端口
nc -zv github.com 22
nc -zv github.com 443
```

### 文件权限检查
```bash
# 检查关键文件权限
ls -la ~/.ssh/
ls -la ~/.zshrc
ls -la ~/.gitconfig

# 检查目录权限
ls -la ~/.zsh-plugins/
ls -la ~/.zsh-themes/
```

## 🆘 重置和恢复

### 完全重置 zsh 配置
```bash
# 备份当前配置
cp ~/.zshrc ~/.zshrc.emergency.backup

# 重置为默认配置
cp /etc/zshrc ~/.zshrc

# 重新运行安装脚本
./install.sh
```

### 重置 Git 配置
```bash
# 删除全局配置
rm ~/.gitconfig

# 重新配置
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
git config --global init.defaultBranch main
```

### 重置 SSH 配置
```bash
# 备份并删除 SSH 配置
mv ~/.ssh ~/.ssh.backup
mkdir ~/.ssh
chmod 700 ~/.ssh

# 重新生成密钥
ssh-keygen -t ed25519 -C "your.email@example.com"
```

## 📞 获取帮助

### 社区资源
- [Homebrew Issues](https://github.com/Homebrew/brew/issues)
- [Zsh Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
- [iTerm2 FAQ](https://iterm2.com/faq.html)

### 命令帮助
```bash
# 查看命令帮助
man command-name
command-name --help
brew help
git help
```

### 日志查看
```bash
# 系统日志
tail -f /var/log/system.log

# Homebrew 日志
brew config
brew doctor

# Git 详细输出
GIT_TRACE=1 git command
```

---

> 💡 **提示**: 如果遇到问题，请先运行 `brew doctor` 和检查相关日志，大多数问题都有详细的错误信息可以参考。