# 🔧 常用命令参考

## 🚀 快速开始

### 环境管理
```bash
# 重新加载 zsh 配置
source ~/.zshrc

# 查看当前 shell
echo $SHELL

# 查看环境变量
env | grep -i path

# 查看已安装的包
brew list
```

## 📁 文件和目录操作

### 基础命令
```bash
# 列出文件（带颜色和详细信息）
ll                  # 详细列表
la                  # 包含隐藏文件
l                   # 简单列表

# 目录导航
cd                  # 回到主目录
cd -                # 返回上一个目录
..                  # 上一级目录
...                 # 上两级目录
....                # 上三级目录

# 创建目录并进入
mkcd my-project     # 等同于 mkdir my-project && cd my-project

# 查看目录树结构
tree                # 显示目录树
tree -L 2           # 只显示 2 层
tree -a             # 包含隐藏文件
```

### 文件操作
```bash
# 查找文件
find . -name "*.js"           # 查找 JS 文件
find . -type f -size +1M      # 查找大于 1MB 的文件

# 文件内容搜索
grep -r "search_term" .       # 递归搜索
grep -i "case_insensitive" .  # 忽略大小写

# 文件解压（使用自定义函数）
extract file.zip              # 自动识别格式解压
extract file.tar.gz
extract file.rar
```

## 🔀 Git 操作

### 基础命令（已配置别名）
```bash
# Git 状态和基础操作
gs                  # git status
ga .                # git add .
ga filename         # git add filename
gc "message"        # git commit -m "message"
gp                  # git push
gl                  # git pull
gd                  # git diff

# 分支操作
gb                  # git branch（查看分支）
gb new-branch       # git branch new-branch（创建分支）
gco main            # git checkout main
gco -b feature      # git checkout -b feature

# 日志查看
glog                # 图形化日志显示
git log --oneline   # 单行日志
```

### 高级操作
```bash
# 初始化新项目
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:username/repo.git
git push -u origin main

# 克隆项目
git clone git@github.com:username/repo.git

# 回退操作
git reset --soft HEAD~1     # 软回退（保留更改）
git reset --hard HEAD~1     # 硬回退（丢弃更改）

# 查看远程仓库
git remote -v
git remote show origin
```

## 📦 包管理 (Homebrew)

### 软件安装
```bash
# 搜索软件
brew search package-name

# 安装命令行工具
brew install package-name

# 安装图形应用
brew install --cask app-name

# 查看软件信息
brew info package-name

# 列出已安装软件
brew list                   # 命令行工具
brew list --cask           # 图形应用
```

### 系统维护
```bash
# 更新 Homebrew
brew update

# 升级所有软件
brew upgrade

# 清理旧版本
brew cleanup

# 检查系统
brew doctor

# 卸载软件
brew uninstall package-name
```

## 🔧 开发工具

### Node.js
```bash
# 查看版本
node --version
npm --version

# 项目初始化
npm init                    # 交互式初始化
npm init -y                 # 使用默认配置

# 包管理
npm install package-name    # 本地安装
npm install -g package-name # 全局安装
npm install --save-dev pkg  # 开发依赖

# 运行脚本
npm run dev
npm start
npm test
```

### Python
```bash
# 查看版本
python3 --version
pip3 --version

# 虚拟环境
python3 -m venv venv        # 创建虚拟环境
source venv/bin/activate    # 激活虚拟环境
deactivate                  # 退出虚拟环境

# 包管理
pip3 install package-name
pip3 install -r requirements.txt
pip3 freeze > requirements.txt
```

### Go
```bash
# 查看版本
go version

# 项目初始化
go mod init project-name

# 构建和运行
go build
go run main.go
go test
```

### Rust
```bash
# 查看版本
rustc --version
cargo --version

# 项目管理
cargo new project-name      # 创建新项目
cargo build                 # 构建项目
cargo run                   # 运行项目
cargo test                  # 运行测试
```

## 🖥️ 系统监控

### 系统信息
```bash
# 系统监控
htop                        # 交互式进程监控
top                         # 基础进程监控
ps aux                      # 查看所有进程

# 磁盘使用
df -h                       # 磁盘空间
du -h                       # 目录大小
du -sh .                    # 当前目录大小

# 网络
ping -c 5 google.com        # 网络连接测试
netstat -tulanp             # 网络端口
```

### 进程管理
```bash
# 查找进程
ps aux | grep process-name

# 杀死进程（使用自定义函数）
killp process-name          # 按名称杀死进程

# 后台运行
command &                   # 后台运行
nohup command &             # 忽略挂起信号
```

## 🌐 网络工具

### 下载和传输
```bash
# 下载文件
wget https://example.com/file.zip
curl -O https://example.com/file.zip
curl -L https://example.com/redirect-url

# 快速 HTTP 服务器
server                      # 在当前目录启动服务器 (端口 8000)
server 3000                 # 指定端口启动
```

### SSH 连接
```bash
# SSH 连接
ssh user@hostname
ssh -i ~/.ssh/key user@hostname

# SSH 密钥管理
ssh-keygen -t ed25519 -C "email@example.com"
ssh-add ~/.ssh/id_ed25519
ssh-copy-id user@hostname

# 测试 GitHub 连接
ssh -T git@github.com
```

## 🎨 主题和配置

### 主题切换
```bash
# 切换 zsh 主题
./scripts/set-theme.sh pure      # Pure 主题
./scripts/set-theme.sh p10k      # Powerlevel10k 主题
./scripts/set-theme.sh spaceship # Spaceship 主题

# Powerlevel10k 配置
p10k configure              # 交互式配置
```

### 配置管理
```bash
# 备份配置
cp ~/.zshrc ~/.zshrc.backup

# 重新应用配置
source ~/.zshrc

# 查看别名
alias                       # 查看所有别名
which command-name          # 查看命令路径
```

## 🔍 查找和搜索

### 文件搜索
```bash
# 按名称查找
find . -name "*.log"
find /path -iname "*config*"   # 忽略大小写

# 按类型查找
find . -type f              # 文件
find . -type d              # 目录

# 按大小查找
find . -size +100M          # 大于 100MB
find . -size -1k            # 小于 1KB
```

### 内容搜索
```bash
# 文本搜索
grep -r "search_term" .
grep -n "line_number" file.txt
grep -E "regex_pattern" file.txt

# JSON 处理
cat data.json | jq .        # 美化 JSON
cat data.json | jq '.key'   # 提取特定字段
```

## 💡 实用技巧

### 命令组合
```bash
# 管道操作
ls -la | grep "pattern"
cat file.txt | head -10
ps aux | grep node | grep -v grep

# 命令替换
echo "Today is $(date)"
cd $(pwd)

# 条件执行
command1 && command2        # command1 成功才执行 command2
command1 || command2        # command1 失败才执行 command2
```

### 快捷键
```bash
Ctrl + C                    # 中断当前命令
Ctrl + D                    # 退出当前 shell
Ctrl + Z                    # 暂停当前进程
Ctrl + R                    # 搜索命令历史
Ctrl + A                    # 光标移到行首
Ctrl + E                    # 光标移到行尾
Ctrl + L                    # 清屏
```

### 历史命令
```bash
history                     # 查看命令历史
!!                          # 重复上一个命令
!n                          # 重复第 n 个历史命令
!string                     # 重复最近以 string 开头的命令
```

---

> 💡 **提示**: 大多数命令支持 `--help` 参数来查看详细用法，例如 `git --help` 或 `brew --help`。