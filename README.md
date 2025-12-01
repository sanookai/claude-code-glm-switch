# Claude Code Switch GLM - Windows Edition

## คู่มือติดตั้งสำหรับ Windows (PowerShell)

---

### สมัคร GLM ลดเพิ่ม 10%! จากโปร 50% และ BFD

**ลิงก์สมัคร (รับส่วนลด 10%)**: https://z.ai/subscribe?ic=HD0SBVP0OA

---

ไฟล์ config นี้ช่วยให้คุณสลับใช้งาน Claude Code ได้ 3 โหมด:

| โหมด | คำอธิบาย |
|------|----------|
| **GLM** | ใช้ GLM ผ่าน proxy API |
| **Subscription** | ใช้ Claude แท้ผ่าน Max Plan |
| **API** | ใช้ Claude แท้ผ่าน API Key |

---

## ไฟล์ที่ต้องใช้

```
claude-code-switch-glm/
├── readme-windows.md                 ← คู่มือนี้
└── claude-code-switch-glm-windows.ps1  ← ไฟล์ config สำหรับ Windows
```

---

## ขั้นตอนที่ 1: ตั้งค่า API Keys

### **สำคัญ: ต้องใส่ API Key ก่อนติดตั้ง**

เปิดไฟล์ `claude-code-switch-glm-windows.ps1` ด้วย Notepad หรือ VS Code แล้วแก้ไข:

---

### สำหรับ GLM

หาบรรทัดนี้:
```powershell
$env:ANTHROPIC_AUTH_TOKEN = "ใส่-GLM-TOKEN-ของคุณ-ตรงนี้"
```

เปลี่ยนเป็น GLM Token ของคุณ:
```powershell
$env:ANTHROPIC_AUTH_TOKEN = "abc123xyz456..."
```

**วิธีหา GLM Token:**
1. สมัคร GLM ที่: https://z.ai/subscribe?ic=HD0SBVP0OA (ลดเพิ่ม 10%!)
2. เข้าไปที่เว็บ GLM หลังสมัครเสร็จ
3. ไปที่หน้า API Keys หรือ Settings
4. คัดลอก Token มาใส่

---

### สำหรับ Claude API

หาบรรทัดนี้:
```powershell
$env:ANTHROPIC_API_KEY = "YOUR-ANTHROPIC-API-KEY-HERE"
```

เปลี่ยนเป็น API Key ของคุณ:
```powershell
$env:ANTHROPIC_API_KEY = "sk-ant-api03-xxxxx..."
```

**วิธีหา Anthropic API Key:**
1. ไปที่ https://console.anthropic.com
2. Login เข้าบัญชี
3. ไปที่ Settings → API Keys
4. กด "Create Key" แล้วคัดลอกมาใส่

---

### สำหรับ Claude Subscription

ไม่ต้องตั้งค่าอะไร! ใช้ account ที่ login ไว้กับ Claude Code ได้เลย

---

## ขั้นตอนที่ 2: ติดตั้งลง PowerShell Profile

### วิธีที่ 1: ใช้คำสั่ง (แนะนำ)

1. เปิด **PowerShell** (กด Windows + X แล้วเลือก Windows PowerShell)

2. ตรวจสอบว่ามี Profile หรือยัง:
   ```powershell
   Test-Path $PROFILE
   ```

3. ถ้าได้ `False` ให้สร้าง Profile ก่อน:
   ```powershell
   New-Item -Path $PROFILE -Type File -Force
   ```

4. เปิด Profile ด้วย Notepad:
   ```powershell
   notepad $PROFILE
   ```

5. เพิ่มบรรทัดนี้ลงไปในไฟล์ (เปลี่ยน path ให้ตรงกับที่เก็บไฟล์):
   ```powershell
   . "C:\path\to\claude-code-switch-glm-windows.ps1"
   ```

   ตัวอย่าง:
   ```powershell
   . "C:\Users\YourName\Downloads\claude-code-switch-glm\claude-code-switch-glm-windows.ps1"
   ```

6. บันทึกและปิด Notepad

7. โหลด Profile ใหม่:
   ```powershell
   . $PROFILE
   ```

8. ทดสอบ:
   ```powershell
   ccc
   ```

---

### วิธีที่ 2: ติดตั้งอัตโนมัติด้วยคำสั่งเดียว

```powershell
# เปลี่ยน path ให้ตรงกับที่เก็บไฟล์
$scriptPath = "C:\path\to\claude-code-switch-glm-windows.ps1"
Add-Content -Path $PROFILE -Value "`n. `"$scriptPath`""
. $PROFILE
```

---

## ขั้นตอนที่ 3: วิธีใช้งาน

### คำสั่งลัด

| คำสั่ง | ความหมาย |
|--------|----------|
| `ccg` | สลับเป็น GLM แล้วเปิด Claude |
| `ccs` | สลับเป็น Claude Subscription แล้วเปิด |
| `cca` | สลับเป็น Claude API แล้วเปิด |
| `cc` | เปิด Claude ด้วย config ปัจจุบัน |
| `ccc` | เช็คว่าตอนนี้ใช้ config อะไร |

### ตัวอย่างการใช้งาน

```powershell
# ใช้ GLM
ccg

# ใช้ Claude Subscription (Max Plan)
ccs

# ใช้ Claude API
cca

# เช็คสถานะ
ccc
```

### สลับ config โดยไม่เปิด Claude

```powershell
# สลับเป็น GLM
glm_on

# สลับเป็น Subscription
claude_sub

# สลับเป็น API
claude_api

# แล้วค่อยเปิด Claude เอง
cc
```

---

## หมายเหตุสำคัญ

1. **ทุกคำสั่งจะเปิด Claude พร้อม `--dangerously-skip-permissions`**
   - หมายความว่า Claude จะไม่ถามยืนยันก่อนรันคำสั่ง
   - ใช้ด้วยความระมัดระวัง

2. **API Key เป็นความลับ**
   - อย่าแชร์ไฟล์ PowerShell Profile ให้คนอื่น
   - อย่า commit ขึ้น GitHub

3. **ต้อง login Claude Code ก่อน** (สำหรับ Subscription)
   ```powershell
   claude login
   ```

4. **Execution Policy**
   - ถ้าเจอ error เรื่อง script ไม่สามารถรันได้ ให้รัน:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

---

## แก้ไขปัญหา

### ปัญหา: คำสั่ง ccg, ccs, cca ใช้ไม่ได้

```powershell
. $PROFILE
```

### ปัญหา: Script cannot be loaded because running scripts is disabled

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### ปัญหา: GLM ใช้ไม่ได้

ตรวจสอบว่า:
1. ใส่ Token ถูกต้อง
2. Token ยังไม่หมดอายุ
3. Base URL ถูกต้อง

### ปัญหา: Claude API ใช้ไม่ได้

ตรวจสอบว่า:
1. API Key ขึ้นต้นด้วย `sk-ant-`
2. มี credit ใน account
3. API Key ยังไม่ถูก revoke

### ปัญหา: ต้องการแก้ไข API Key ภายหลัง

```powershell
notepad $PROFILE
# หรือแก้ไขไฟล์ claude-code-switch-glm-windows.ps1 โดยตรง
```

### ปัญหา: ต้องการลบ config ออกทั้งหมด

```powershell
notepad $PROFILE
# ลบบรรทัดที่มี claude-code-switch-glm-windows.ps1 ออก
# บันทึกและปิด แล้วเปิด PowerShell ใหม่
```

---

## สรุป Config แต่ละโหมด

| โหมด | ต้องใช้ | วิธีได้มา |
|------|---------|-----------|
| GLM | `ANTHROPIC_AUTH_TOKEN` | จากเว็บ GLM provider |
| Subscription | Login account | `claude login` |
| API | `ANTHROPIC_API_KEY` | console.anthropic.com |

---

## ลิงก์ที่เป็นประโยชน์

- Anthropic Console: https://console.anthropic.com
- Claude Code Docs: https://docs.anthropic.com/claude-code
- Anthropic API Docs: https://docs.anthropic.com/api

---

## Credits

**Developed by [Sanookai.com](https://sanookai.com)**
**Fork from https://github.com/aiunlocked1412/claude-code-switch-glm-ai-unlocked/**

---
*Claude Code Switch GLM - Windows Edition v1.0*
*Developed by Sanookai.com*
