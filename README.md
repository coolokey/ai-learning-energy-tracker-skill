# 🏅 學習能量軌跡 AI 助教系統產生器 (`ai-learning-energy-tracker` Skill)

一套專為 **Antigravity / AI Coding Agent** 設計的標準化技能套件（Skill），可協助各級國中小／高中快速建立、客製化、測試與部署具備 **Gemini 2.5 Pro / Flash 雙軌五維度素養即時評量（探究筆記 ╳ 藝術創作）**、**訂正重交躍升閉環**、**58mm 實體創客胸章工作坊（A4 1:1 六宮格 300DPI 刀模印刷單 ＆ 特級榮譽證書）**、**極光成果星空多維度篩選 ＆ 360° 3D 胸章互動鑑賞**、**首頁 1~6 章完整並排教師手冊**，以及 **跨科自訂 Rubrics 規準與 10 秒一鍵匯出 Google Docs 全班成果冊** 的校園智慧學習歷程網站。

---

## ✨ 套件核心特色

* **📱 學生端免登入極簡收件 ＋ 二進位檔頭防偽 ＋ 訂正重交閉環**：
  * 免記帳號密碼，手機掃碼填寫班級、座號、姓名即可隨拍即傳（支援 1~4 張多頁學習單自動垂直拼接與 PDF）。
  * 後端檢驗二進位 Magic Bytes 檔頭防偽，核發唯一 **UUID v4 電子收據**；學生勾選 **「✨ 這是訂正重交作品（挑戰更高分）」** 可自動調出前次評語比對，立即呈現 **「🚀 訂正大進步 +N 分」** 激勵回饋。
* **🧠 Gemini 2.5 Pro 雙軌五維度素養雷達 ＋ 跨科自訂 Rubrics**：
  * 自動判別 **探究筆記**（主題聚焦、探究深度、資料條理、反思洞見、視覺呈現）或 **藝術創作**（主題語意 35%、結構重心 20%、色彩表現 15%、光影層次 15%、筆觸細節 15%，含三分構圖線／重心熱區／主調色票疊圖診斷）。
  * 支援國、英、數、自、社、跨領域、藝術等 8 大領域視角，教師可於後台自訂各作業專屬 Rubrics 規準並動態注入 AI 提示詞。
* **🏅 58mm 實體創客胸章工作坊 ＋ A4 1:1 六宮格刀模單 ＋ 特級認證證書**：
  * 達標（預設 85 分或經教師核准）即解鎖 **58mm 胸章圓形取景工作坊**，內建 **70mm 外出血圈／58mm 折邊圈／50mm 安全圈** 三規同心圓與雙層留白防切字保護。
  * 支援匯出單張 300DPI 印刷檔、**A4 1:1 原寸六宮格刀模印刷單（含 50mm 實體比例檢核尺）** 與 **A4 橫式特級認證證書**，印出後直接送入學校 58mm 胸章機壓製成學生別在書包上的實體金屬榮譽胸章。
* **🌌 極光成果星空（多維度篩選整理 ＆ 360° 3D 胸章鑑賞）＋ 個人能量軌跡**：
  * 學生憑本人任一張收據 UUID 即可查閱整學期 **個人學習能量軌跡折線圖、累計躍升光環與最近三次五維雷達疊圖**。
  * 公開「成果星空」提供 **班級、作業項目、作品類型、關鍵字、排序方式** 五維度檢索整理與姓名去識別化保護，點擊卡片可開啟 **360° 3D 立體金屬胸章互動鑑賞**。
* **👩‍🏫 首頁 1~6 章並排教師手冊 ＋ 教師後台批次審核 ＋ 10 秒匯出 Google Docs 成果冊**：
  * 首頁內建 **一至六章完整單排並陳（6 欄 Grid）教師使用手冊**，支援一鍵展開全部章節與紙本列印。
  * 後台提供 **全班五維學力診斷雷達與共同盲點分析**、單筆調分、勾選作品 **一鍵批次審查通過（達標核發胸章）**，以及 **10 秒自動排版匯出 Google Docs 全班學習能量成果冊**。
  * Google 試算表內建 `能量軌跡總表`（22 欄）、`星空藝廊`（9 欄）與 `系統設定`（3 欄），老師直接在試算表 `B2` 貼上 `GEMINI_API_KEY` 即可啟用，零伺服器維護成本。

---

## 🛠️ 五階段標準製作流程

1. **階段一：需求盤點**：確認學校全銜／簡稱、預設作業清單、胸章核發門檻（預設 85 分）與核發模式（自動或教師審核）。
2. **階段二：一鍵建立專案骨架 (`scripts/scaffold.ps1`)**：複製經過驗證的 `Code.gs`、`index.html`、`appsscript.json` 與測試套件至目標資料夾，自動替換校名與參數。
3. **階段三：在地文化主題與跨科規準客製**：調整 `index.html` 的在地文化創作主題與後台跨科 Rubrics 預設值。
4. **階段四：雙重自動化測試驗證**：執行 `node tests/backend.test.cjs`（33 項後端業務與資安防偽測試）與 `node tests/check_ids.cjs`（前端 DOM ID 完整性檢核）。
5. **階段五：GAS Web App 與 GitHub Pages 雙棲部署**：透過 `clasp push` / `clasp deploy` 發布後端 API，並同步部署至 GitHub Pages 提供高速靜態入口。

---

## 📁 檔案結構

```text
ai-learning-energy-tracker/
├── SKILL.md                      # AI Agent 五階段執行 SOP（盤點 → 建置 → 客製 → 測試 → 部署）
├── README.md                     # 本說明文件
├── .gitignore                    # Git 忽略設定
├── references/
│   └── architecture.md           # 試算表 3 大分頁規格、雙軌五維規準、58mm 三規刀模與資安架構
├── scripts/
│   └── scaffold.ps1              # 一鍵建置新學校「學習能量軌跡 AI 助教」專案腳本
└── resources/
    └── template/                 # 乾淨且通過完整測試的黃金程式碼範本
        ├── Code.gs               # Google Apps Script 後端程式（1,880 行）
        ├── index.html            # 單頁式響應式前端（支援 GitHub Pages 與 GAS 雙棲）
        ├── appsscript.json       # GAS 權限與 V8 執行設定
        ├── .claspignore          # clasp 上傳白名單
        ├── .nojekyll             # GitHub Pages 靜態部署標記
        └── tests/
            ├── backend.test.cjs  # 33 項後端業務邏輯、二進位防偽與回歸測試
            └── check_ids.cjs     # 前端 DOM ID 與 JS 參照完整性檢核腳本
```

---

## 🚀 安裝本 Skill

### 方法一：安裝至個人全域 Skills（推薦，所有專案皆可喚起）

```powershell
git clone https://github.com/coolokey/ai-learning-energy-tracker-skill.git "$HOME\.gemini\config\skills\ai-learning-energy-tracker"
```

### 方法二：僅安裝至單一專案工作區

```powershell
git clone https://github.com/coolokey/ai-learning-energy-tracker-skill.git ".\.agents\skills\ai-learning-energy-tracker"
```

---

## 💡 使用方式

### 方式 A：在 Antigravity 對話中直接下指令

> 「請幫我用 `ai-learning-energy-tracker` 技能，為『桃園市立○○國民中學』建立一套學習能量軌跡 AI 助教系統。」

### 方式 B：手動執行腳手架腳本建立新專案

```powershell
powershell -ExecutionPolicy Bypass -File "$HOME\.gemini\config\skills\ai-learning-energy-tracker\scripts\scaffold.ps1" `
  -TargetDir "D:\my-learning-energy-tracker" `
  -SchoolFullName "桃園市立○○國民中學" `
  -SchoolShortName "○○國中" `
  -BadgeThreshold 85 `
  -GasWebappUrl "https://script.google.com/macros/s/<您的 DEPLOYMENT_ID>/exec"
```

建置完成後即可執行雙重自動化驗證與部署：

```powershell
cd D:\my-learning-energy-tracker
node tests/backend.test.cjs
node tests/check_ids.cjs
clasp push -f
clasp deploy --description "Initial release"
```

---

## 📄 授權與實作參考

* 實戰範例系統參考：[learning-energy-tracker](https://github.com/coolokey/learning-energy-tracker)（線上展示：https://coolokey.github.io/learning-energy-tracker/）
* 採用開源授權供各級學校推動自主學習、跨領域探究與教學行政雙減量自由複用與客製。
