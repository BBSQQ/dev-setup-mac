#!/bin/bash

# =============================================================================
# GitHub SSH 配置脚本
# =============================================================================

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# 获取用户信息
get_user_info() {
    echo "🔧 配置 GitHub SSH 密钥"
    echo "======================"

    if [[ -z "$GIT_USER_NAME" ]]; then
        read -p "请输入 GitHub 用户名: " GIT_USER_NAME
    fi

    if [[ -z "$GIT_USER_EMAIL" ]]; then
        read -p "请输入 GitHub 邮箱: " GIT_USER_EMAIL
    fi

    log_info "用户名: $GIT_USER_NAME"
    log_info "邮箱: $GIT_USER_EMAIL"
}

# 配置 Git 用户信息
setup_git_user() {
    log_info "配置 Git 用户信息..."

    git config --global user.name "$GIT_USER_NAME"
    git config --global user.email "$GIT_USER_EMAIL"

    log_success "Git 用户信息配置完成"
}

# 生成 SSH 密钥
generate_ssh_key() {
    log_info "检查 SSH 密钥..."

    if [[ -f ~/.ssh/id_ed25519 ]]; then
        log_warning "SSH 密钥已存在，跳过生成"
        return
    fi

    log_info "生成 SSH 密钥..."
    ssh-keygen -t ed25519 -C "$GIT_USER_EMAIL" -f ~/.ssh/id_ed25519 -N ""

    # 设置权限
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_ed25519
    chmod 644 ~/.ssh/id_ed25519.pub

    log_success "SSH 密钥生成完成"
}

# 配置 SSH
setup_ssh() {
    log_info "配置 SSH..."

    # 启动 SSH 代理并添加密钥
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

    # 创建 SSH 配置文件
    cat > ~/.ssh/config << 'EOF'
Host github.com
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_ed25519
    UseKeychain yes
    AddKeysToAgent yes

Host *
    UseKeychain yes
    AddKeysToAgent yes
    IdentitiesOnly yes
EOF

    chmod 600 ~/.ssh/config

    log_success "SSH 配置完成"
}

# 显示公钥
show_public_key() {
    log_info "SSH 公钥内容："
    echo "============================================"
    cat ~/.ssh/id_ed25519.pub
    echo "============================================"

    # 复制到剪贴板
    cat ~/.ssh/id_ed25519.pub | pbcopy
    log_success "公钥已复制到剪贴板"
}

# 测试 GitHub 连接
test_github_connection() {
    log_info "测试 GitHub 连接..."

    if ssh -T git@github.com 2>&1 | grep -q "successfully authenticated"; then
        log_success "GitHub SSH 连接成功！"
    else
        log_warning "GitHub 连接测试失败，请手动验证"
        echo "1. 访问 https://github.com/settings/keys"
        echo "2. 点击 'New SSH key'"
        echo "3. 粘贴上面的公钥内容"
        echo "4. 然后运行: ssh -T git@github.com"
    fi
}

# 主函数
main() {
    get_user_info
    setup_git_user
    generate_ssh_key
    setup_ssh
    show_public_key

    echo ""
    echo "📋 下一步操作："
    echo "1. 访问 GitHub Settings: https://github.com/settings/keys"
    echo "2. 点击 'New SSH key'"
    echo "3. 标题填写: $(hostname)"
    echo "4. 粘贴上面的公钥内容"
    echo "5. 点击 'Add SSH key'"
    echo ""
    echo "🧪 完成后测试连接:"
    echo "ssh -T git@github.com"

    # 询问是否立即测试
    read -p "是否现在测试 GitHub 连接? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        test_github_connection
    fi
}

main "$@"