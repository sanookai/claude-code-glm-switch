# ========================================
# Claude Code Switch GLM  (Windows PowerShell)
# ========================================
# โดย Sanook Ai
# 🌐 https://sanookai.com

# ========================================
# สลับใช้งาน Claude Code ได้ 3 โหมด:
# - GLM (ผ่าน proxy API)
# - Claude Subscription (Max Plan)
# - Claude API
# ========================================

# --- GLM Config ---
function glm_on {
    $env:ANTHROPIC_AUTH_TOKEN = "Change-Your-GLM-Token-Here"
    $env:ANTHROPIC_BASE_URL = "https://api.z.ai/api/anthropic"
    $env:API_TIMEOUT_MS = "3000000"
    $env:CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1"
    $env:ANTHROPIC_DEFAULT_HAIKU_MODEL = "glm-4.5-air"
    $env:ANTHROPIC_DEFAULT_SONNET_MODEL = "glm-4.6"
    $env:ANTHROPIC_DEFAULT_OPUS_MODEL = "glm-4.6"
    Remove-Item Env:\ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
    Write-Host "[OK] Switched to GLM"
}

# --- Claude Official (Subscription/Max Plan) ---
function claude_sub {
    Remove-Item Env:\ANTHROPIC_AUTH_TOKEN -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_BASE_URL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_API_KEY -ErrorAction SilentlyContinue
    Remove-Item Env:\API_TIMEOUT_MS -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_DEFAULT_HAIKU_MODEL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_DEFAULT_SONNET_MODEL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_DEFAULT_OPUS_MODEL -ErrorAction SilentlyContinue
    Remove-Item Env:\CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC -ErrorAction SilentlyContinue
    Write-Host "[OK] Switched to Claude Subscription"
}

# --- Claude API ---
function claude_api {
    Remove-Item Env:\ANTHROPIC_AUTH_TOKEN -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_BASE_URL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_DEFAULT_HAIKU_MODEL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_DEFAULT_SONNET_MODEL -ErrorAction SilentlyContinue
    Remove-Item Env:\ANTHROPIC_DEFAULT_OPUS_MODEL -ErrorAction SilentlyContinue
    Remove-Item Env:\CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC -ErrorAction SilentlyContinue
    $env:ANTHROPIC_API_KEY = "YOUR-ANTHROPIC-API-KEY-HERE"
    Write-Host "[OK] Switched to Claude API"
}

# ========================================
# Alias ลัดเรียกใช้งาน
# ========================================

# cc  = Claude ปกติ + skip permissions
function cc {
    claude --dangerously-skip-permissions $args
}

# ccg = สลับเป็น GLM แล้วเปิด Claude
function ccg {
    glm_on
    claude --dangerously-skip-permissions $args
}

# ccs = สลับเป็น Claude Subscription แล้วเปิด
function ccs {
    claude_sub
    claude --dangerously-skip-permissions $args
}

# cca = สลับเป็น Claude API แล้วเปิด
function cca {
    claude_api
    claude --dangerously-skip-permissions $args
}

# ========================================
# คำสั่งเช็คสถานะ
# ========================================

function claude_status {
    Write-Host "Current Claude Config:"
    Write-Host "----------------------------"
    if ($env:ANTHROPIC_AUTH_TOKEN) {
        Write-Host "Mode: GLM"
        Write-Host "Base URL: $env:ANTHROPIC_BASE_URL"
        Write-Host "Sonnet Model: $env:ANTHROPIC_DEFAULT_SONNET_MODEL"
    }
    elseif ($env:ANTHROPIC_API_KEY) {
        Write-Host "Mode: Claude API"
        $apiKey = $env:ANTHROPIC_API_KEY
        if ($apiKey.Length -gt 15) {
            Write-Host "API Key: $($apiKey.Substring(0, 15))..."
        }
        else {
            Write-Host "API Key: $apiKey"
        }
    }
    else {
        Write-Host "Mode: Claude Subscription"
    }
    Write-Host "----------------------------"
    Write-Host "Powered by Sanook Ai"
}

Set-Alias -Name ccc -Value claude_status

