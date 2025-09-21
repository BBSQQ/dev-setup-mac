#!/bin/bash

# =============================================================================
# zsh 主题切换脚本
# =============================================================================

set -e

THEME=$1

usage() {
    echo "用法: $0 <theme>"
    echo ""
    echo "可用主题:"
    echo "  pure      - Pure 主题（极简）"
    echo "  p10k      - Powerlevel10k 主题（可配置）"
    echo "  spaceship - Spaceship 主题（丰富）"
    echo ""
    echo "示例:"
    echo "  $0 pure"
    echo "  $0 p10k"
}

backup_zshrc() {
    if [[ -f ~/.zshrc ]]; then
        cp ~/.zshrc ~/.zshrc.backup.$(date +%Y%m%d_%H%M%S)
        echo "✅ 已备份 .zshrc"
    fi
}

set_pure_theme() {
    echo "🎨 设置 Pure 主题..."

    # 替换主题配置部分
    sed -i.bak '/# Pure theme/,/prompt pure/d' ~/.zshrc
    sed -i.bak '/# Powerlevel10k theme/,/source.*powerlevel10k/d' ~/.zshrc
    sed -i.bak '/# Spaceship theme/,/source.*spaceship/d' ~/.zshrc

    # 添加 Pure 主题配置
    cat >> ~/.zshrc << 'EOF'

# Pure theme
fpath+=(~/.zsh-themes/pure)
autoload -U promptinit; promptinit
prompt pure

# Pure theme settings
zstyle :prompt:pure:path color cyan
zstyle :prompt:pure:git:branch color blue
zstyle :prompt:pure:git:action color yellow
zstyle :prompt:pure:git:dirty color magenta
EOF

    echo "✅ Pure 主题配置完成"
}

set_p10k_theme() {
    echo "🎨 设置 Powerlevel10k 主题..."

    # 替换主题配置部分
    sed -i.bak '/# Pure theme/,/zstyle.*magenta/d' ~/.zshrc
    sed -i.bak '/# Spaceship theme/,/source.*spaceship/d' ~/.zshrc

    # 添加 Powerlevel10k 主题配置
    cat >> ~/.zshrc << 'EOF'

# Powerlevel10k theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

    echo "✅ Powerlevel10k 主题配置完成"
    echo "💡 运行 'p10k configure' 来自定义主题"
}

set_spaceship_theme() {
    echo "🎨 设置 Spaceship 主题..."

    # 替换主题配置部分
    sed -i.bak '/# Pure theme/,/zstyle.*magenta/d' ~/.zshrc
    sed -i.bak '/# Powerlevel10k theme/,/source.*\.p10k\.zsh/d' ~/.zshrc

    # 添加 Spaceship 主题配置
    cat >> ~/.zshrc << 'EOF'

# Spaceship theme
source ~/.zsh-themes/spaceship/spaceship.zsh-theme

# Spaceship settings
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  exec_time     # Execution time
  line_sep      # Line break
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
EOF

    echo "✅ Spaceship 主题配置完成"
}

main() {
    if [[ -z "$THEME" ]]; then
        usage
        exit 1
    fi

    backup_zshrc

    case "$THEME" in
        pure)
            set_pure_theme
            ;;
        p10k|powerlevel10k)
            set_p10k_theme
            ;;
        spaceship)
            set_spaceship_theme
            ;;
        *)
            echo "❌ 未知主题: $THEME"
            usage
            exit 1
            ;;
    esac

    echo ""
    echo "🔄 重新加载配置: source ~/.zshrc"
    echo "或重启终端以应用新主题"
}

main "$@"