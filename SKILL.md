---
name: ai-learning-energy-tracker
description: >-
  學校「學習能量軌跡 AI 助教（自主學習探究 ╳ 藝術創作雙軌五維評量、訂正重交躍升閉環、58mm 實體創客胸章與成果冊一鍵匯出系統）」產生與部署技能。當使用者要求「製作學習能量軌跡系統」、「建立自主學習上傳與 AI 評量網站」、「套用學習能量軌跡 AI 助教範本到新學校」或「客製化／部署 GAS + Gemini 學習歷程與創客胸章系統」時啟動。
---

# 學校學習能量軌跡 AI 助教系統建立指南 (`ai-learning-energy-tracker`)

本 Skill 提供完整的「**Google Apps Script + Google Sheets 三分頁資料庫 + Google Drive 自動歸檔 + Gemini 2.5 Pro / Flash 多模態雙軌五維素養評量 + 58mm 實體創客胸章工作坊 + 極光成果星空藝廊 + 一鍵匯出 Google Docs 成果冊**」標準製作流程與可複用黃金範本（內含 33 項後端單元測試與 DOM 完整性自動化檢核）。

---

## 觸發條件

當使用者提出以下需求之一時啟用本 Skill：
* 要求「為某某學校建立學習能量軌跡 AI 助教」、「製作自主學習探究與藝術創作 AI 上傳評量網站」或「複製／客製這套學習能量軌跡系統」。
* 要求新增、擴充、除錯或重新部署現有 `Code.gs` / `index.html` 的功能（如免登入二進位防偽收件、訂正重交進步比對、雙軌五維素養雷達、58mm 胸章 A4 1:1 六宮格 300DPI 刀模印刷單、A4 橫式認證證書、極光成果星空多維度篩選、360° 3D 胸章互動鑑賞、1~6 章教師手冊、跨科自訂 Rubrics 規準或 Google Docs 成果冊匯出）。

---

## 執行流程（五階段標準製作流程）

### 階段一：需求盤點（與使用者確認必要參數）

啟動新專案前，先向使用者確認以下參數（若為擴充既有專案則先檢查現有 `Code.gs` 與 `.clasp.json`）：
1. **學校全銜與簡稱**：例如 `桃園市立○○國民中學` / `○○國中`。
2. **預設作業項目與跨科評分規準（Rubrics）**：
   * 預設作業清單（`DEFAULT_ASSIGNMENTS_`）：例如 `自主學習探究,藝術創作挑戰`（可於網頁後台「作業項目與評分規準」或試算表 `系統設定` 分頁隨時增刪、改名並自動同步舊紀錄）。
   * 支援 8 大學科領域視角：跨領域自主學習、國語文、英語文、數學、自然科學、社會領域、藝術與美感（一般畫作）、58mm 創客胸章設計。
3. **胸章核發門檻與審核機制**：
   * 達標分數門檻（`BADGE_THRESHOLD`）：預設 `85` 分（可於後台調整為 50~100 分，或由導師於後台單筆調分核發）。
   * 核發模式（`BADGE_APPROVAL`）：預設 `auto`（達標即解鎖 58mm 胸章工作坊）或 `teacher`（須經導師後台審核通過後才解鎖）。
4. **Google 雲端硬碟與試算表自動化配置**：
   * 系統首次執行時會自動在部署者 Google Drive 建立專屬收件資料夾（預設 `學習能量軌跡AI收件空間`）與三分頁試算表（預設 `學習能量軌跡AI彙整總表`，含 `能量軌跡總表`、`星空藝廊`、`系統設定`）。
   * 老師只需在試算表 `系統設定` 分頁的 `B2` 儲存格貼上 `GEMINI_API_KEY`，無須修改程式碼即可啟用 AI 評量；預設後台管理密碼為 `admin888`。

---

### 階段二：一鍵建立專案骨架 (`scripts/scaffold.ps1`)

執行本 Skill 附帶的 [scaffold.ps1](./scripts/scaffold.ps1) 將已驗證的黃金範本複製至目標資料夾，並自動替換學校全銜、簡稱、胸章門檻與預設 GAS 部署網址：

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\MAO YU REN\.gemini\config\skills\ai-learning-energy-tracker\scripts\scaffold.ps1" `
  -TargetDir "<專案目標路徑>" `
  -SchoolFullName "<學校全銜>" `
  -SchoolShortName "<學校簡稱>" `
  -BadgeThreshold 85 `
  -GasWebappUrl "https://script.google.com/macros/s/<DEPLOYMENT_ID>/exec"
```

* 若需深入了解 Google 試算表 3 大分頁欄位規格（22 欄主表）、二進位檔頭防偽、訂正重交比對演算法、雙軌五維規準與 58mm 胸章三規同心圓刀模規格，請閱讀 [architecture.md](./references/architecture.md)。

---

### 階段三：客製化調整要點

依學校或學科需求微調目標資料夾內的檔案：
1. **在地文化主題與創作靈感題庫 (`index.html`)**：
   * `index.html` 的 `ART_THEMES` 內建 13 組創作主題（含在地文化、校園生活、自然生態、奇幻想像與 58mm 胸章設計）。為新學校建置時，可將 `'local'` 分類下的示範主題改為該校所在鄉鎮之特色地標與文化踏查主題。
2. **雙軌五維度素養規準與跨科 Prompt 注入 (`Code.gs`)**：
   * **探究筆記五維度**（各 0~20 分，合計 100 分）：`focus`（主題聚焦）、`depth`（探究深度）、`structure`（資料條理）、`insight`（反思洞見）、`presentation`（視覺呈現）。
   * **藝術創作五維度**（加權合計 100 分）：`themeScore`（主題語意 35%）、`compScore`（結構重心 20%）、`colorScore`（色彩表現 15%）、`lightScore`（光影層次 15%）、`detailScore`（筆觸細節 15%）。
   * 老師於後台設定之各作業專屬 Rubrics（`ASSIGNMENT_RULES`）會由 `buildAnalysisPrompt_()` 動態注入 Gemini System Prompt，並支援「勾選訂正重交」時自動比對前次分數與評語。
3. **58mm 實體創客胸章與雙層留白防切字保護 (`index.html`)**：
   * 保留 `renderBadgeCanvas()` 的三規同心圓規格：**外圈 70mm 裁切出血圓、中圈 58mm 成品折邊圓、內圈 50mm 視覺安全圓**，以及自動內縮雙層留白文字排版（防止胸章機壓製包邊時切到學生姓名或分數）。
   * 保留單張 300DPI 印刷單、**A4 1:1 原寸六宮格刀模印刷單**（含 50mm 實體比例檢核尺）與 **A4 橫式特級認證證書**。
4. **首頁 1~6 章完整單排並陳教師手冊与極光成果星空 (`index.html`)**：
   * 維持 `.tm-nav` 的 `grid-template-columns: repeat(6, 1fr)` 六欄單排並陳設計，確保一至六章教學指引標籤一覽無遺。
   * 維持「成果星空」的多維度篩選列（班級、作業項目、作品類型、關鍵字搜尋、排序切換）與 360° 3D 立體金屬胸章互動視窗，以及教師後台的「一鍵整理修復星空藝廊 (`cleanAndRepairGallery`)」功能。

---

### 階段四：自動化測試與 DOM 完整性驗證

**每次修改程式碼或產生新專案後，必須執行以下雙重驗證，不可跳過：**

1. **後端業務邏輯、防偽資安與回歸測試（33 項應全數通過）**：
   ```powershell
   cd "<專案目標路徑>"
   node tests/backend.test.cjs
   ```
   檢查包含：JPEG/PNG/PDF 二進位 Magic Bytes 檔頭防偽、10MB 大小限制、UUID 冪等防重複、每日配額鎖定、個人能量軌跡憑收據驗證查詢、老師調分與胸章解鎖、作業改名自動同步歷史資料、星空藝廊自動去重修復、自訂 Rubrics 注入與 Google Docs 成果冊匯出等 33 項測試皆為 PASS。

2. **前端 DOM ID 與 JS 參照完整性檢核 + Playwright 實機檢查**：
   ```powershell
   cd "<專案目標路徑>"
   node tests/check_ids.cjs
   ```
   確認所有 `$('...')` 參照之 DOM ID 100% 存在且無語法錯誤；並以 Playwright 驗證桌面（`1360x765`）與手機（`390x844`）載入無 `pageerror`，且教師手冊 1~6 章標籤完整單排呈現。

---

### 階段五：部署 Google Apps Script 與 GitHub Pages

1. **部署 Google Apps Script Web App**：
   ```powershell
   cd "<專案目標路徑>"
   clasp create --type webapp --title "<學校簡稱>-學習能量軌跡AI助教"
   clasp push -f
   clasp deploy --description "Initial production release"
   ```
   取得輸出中的 Deployment ID 後，將 `index.html` 內的 `GAS_BACKEND_URL` 更新為 `https://script.google.com/macros/s/<DEPLOYMENT_ID>/exec`，再執行一次 `clasp push -f`。

2. **發布至 GitHub Pages（雙棲部署）**：
   將專案推送至 GitHub 儲存庫並啟用 GitHub Pages（`main` 分支根目錄），學生與教師即可透過高速靜態網址（`https://<帳號>.github.io/<儲存庫>/`）或 GAS `/exec` 網址無縫使用。

3. **部署後線上健康實測**：
   以 `Invoke-RestMethod "<GAS_EXEC_URL>?api=1&action=getPublicConfig"` 驗證回應 `success: true`，且公開設定絕不外洩 `GEMINI_API_KEY` 或管理密碼，即完成交付。
