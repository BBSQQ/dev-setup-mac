#!/bin/bash

# =============================================================================
# macOS 开发环境一键安装脚本
# 作者: bbsqq
# 版本: 1.0
# =============================================================================

set -e  # 遇到错误立即退出

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 日志函数
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# 检查系统
check_system() {
    log_info "检查系统信息..."

    if [[ $(uname) != "Darwin" ]]; then
        log_error "此脚本仅支持 macOS 系统"
        exit 1
    fi

    log_success "系统检查通过: $(sw_vers -productName) $(sw_vers -productVersion)"
}

# 安装 Xcode Command Line Tools
install_xcode_tools() {
    log_info "检查 Xcode Command Line Tools..."

    if ! command -v git &> /dev/null; then
        log_info "安装 Xcode Command Line Tools..."
        xcode-select --install
        log_warning "请在弹出的对话框中完成安装，然后重新运行此脚本"
        exit 1
    fi

    log_success "Xcode Command Line Tools 已安装"
}

# 安装 Homebrew
install_homebrew() {
    log_info "检查 Homebrew..."

    if ! command -v brew &> /dev/null; then
        log_info "安装 Homebrew..."
        /bin/bash -c "$(curl -fsSL https://gitee.com/ineo6/homebrew-install/raw/master/install.sh)"

        # 添加 Homebrew 到 PATH
        if [[ $(uname -m) == "arm64" ]]; then
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
            eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zshrc
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi

    log_success "Homebrew 已安装: $(brew --version | head -1)"
}

# 安装开发工具
install_dev_tools() {
    log_info "安装开发工具..."

    # 基础工具
    brew install git wget curl tree jq htop

    # 编程语言
    brew install node python@3.12 go rust

    # 字体
    brew install --cask font-meslo-lg-nerd-font font-fira-code-nerd-font

    # 应用程序
    brew install --cask visual-studio-code

    log_success "开发工具安装完成"
}

# 下载 iTerm2
install_iterm2() {
    log_info "安装 iTerm2..."

    if [[ ! -d "/Applications/iTerm.app" ]]; then
        log_info "下载 iTerm2..."
        curl -L "https://iterm2.com/downloads/stable/latest" -o /tmp/iTerm2-latest.zip
        unzip -q /tmp/iTerm2-latest.zip -d /tmp/
        mv /tmp/iTerm.app /Applications/
        rm /tmp/iTerm2-latest.zip
        log_success "iTerm2 安装完成"
    else
        log_success "iTerm2 已安装"
    fi
}

# 安装 zsh 插件
install_zsh_plugins() {
    log_info "安装 zsh 插件..."

    mkdir -p ~/.zsh-plugins ~/.zsh-themes

    # 下载插件
    if [[ ! -d ~/.zsh-plugins/zsh-autosuggestions ]]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh-plugins/zsh-autosuggestions
    fi

    if [[ ! -d ~/.zsh-plugins/zsh-completions ]]; then
        git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh-plugins/zsh-completions
    fi

    if [[ ! -d ~/.zsh-plugins/zsh-syntax-highlighting ]]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-plugins/zsh-syntax-highlighting
    fi

    # 下载主题
    if [[ ! -d ~/.zsh-themes/pure ]]; then
        git clone https://github.com/sindresorhus/pure.git ~/.zsh-themes/pure
    fi

    if [[ ! -d ~/.zsh-themes/spaceship ]]; then
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git ~/.zsh-themes/spaceship
    fi

    if [[ ! -d ~/.powerlevel10k ]]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
    fi

    log_success "zsh 插件安装完成"
}

# 配置 zsh
setup_zsh() {
    log_info "配置 zsh..."

    # 备份现有配置
    if [[ -f ~/.zshrc ]]; then
        cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
        log_info "已备份现有 .zshrc 文件"
    fi

    # 应用新配置
    if [[ -f "configs/.zshrc.template" ]]; then
        cp configs/.zshrc.template ~/.zshrc
        log_success "zsh 配置已应用"
    else
        log_warning "未找到 zsh 配置模板，跳过配置"
    fi
}

# 配置 Git
setup_git() {
    log_info "配置 Git..."

    # 基本配置
    git config --global init.defaultBranch main
    git config --global core.editor nano
    git config --global color.ui auto
    git config --global push.default simple
    git config --global pull.rebase false
    git config --global push.autoSetupRemote true
    git config --global core.autocrlf input
    git config --global core.safecrlf false

    # 网络优化
    git config --global http.version HTTP/1.1
    git config --global http.postBuffer 524288000
    git config --global http.lowSpeedLimit 0
    git config --global http.lowSpeedTime 999999

    log_success "Git 配置完成"
}

# 复制主题文件
copy_themes() {
    log_info "复制主题文件..."

    mkdir -p ~/.iterm2/themes

    if [[ -d "themes" ]]; then
        cp themes/*.itermcolors ~/.iterm2/themes/ 2>/dev/null || true
        log_success "iTerm2 主题文件已复制"
    fi
}

# 主函数
main() {
    echo "🚀 开始安装 macOS 开发环境..."
    echo "==============================="

    check_system
    install_xcode_tools
    install_homebrew
    install_dev_tools
    install_iterm2
    install_zsh_plugins
    setup_zsh
    setup_git
    copy_themes

    echo ""
    echo "==============================="
    log_success "🎉 安装完成！"
    echo ""
    echo "📋 下一步操作："
    echo "1. 重启终端或运行: source ~/.zshrc"
    echo "2. 配置 GitHub SSH: ./scripts/setup-github.sh"
    echo "3. 在 iTerm2 中导入主题 (Preferences → Profiles → Colors)"
    echo "4. 设置 iTerm2 字体为 MesloLGS Nerd Font"
    echo ""
    echo "📚 详细文档: README.md"
    echo "🐛 问题反馈: https://github.com/bbsqq/dev-setup/issues"
}

# 运行主函数
main "$@"