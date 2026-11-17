param(
  [Parameter(Mandatory = $true)]
  [string]$TargetDir,

  [string]$SchoolFullName = "桃園市立大溪國民中學",
  [string]$SchoolShortName = "大溪國中",
  [int]$BadgeThreshold = 85,
  [string]$GasWebappUrl = "https://script.google.com/macros/s/REPLACE_WITH_YOUR_DEPLOYMENT_ID/exec"
)

$ErrorActionPreference = "Stop"
$TemplateDir = Join-Path $PSScriptRoot "..\resources\template"

if (-not (Test-Path $TemplateDir)) {
  throw "找不到範本目錄：$TemplateDir"
}

New-Item -ItemType Directory -Force -Path (Join-Path $TargetDir "tests") | Out-Null
Copy-Item (Join-Path $TemplateDir "Code.gs") $TargetDir -Force
Copy-Item (Join-Path $TemplateDir "index.html") $TargetDir -Force
Copy-Item (Join-Path $TemplateDir "appsscript.json") $TargetDir -Force
Copy-Item (Join-Path $TemplateDir ".claspignore") $TargetDir -Force
Copy-Item (Join-Path $TemplateDir ".nojekyll") $TargetDir -Force
Copy-Item (Join-Path $TemplateDir "tests\backend.test.cjs") (Join-Path $TargetDir "tests") -Force
Copy-Item (Join-Path $TemplateDir "tests\check_ids.cjs") (Join-Path $TargetDir "tests") -Force

$Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

# 1. 更新 Code.gs 學校全銜、簡稱與胸章門檻
$codePath = Join-Path $TargetDir "Code.gs"
$code = [System.IO.File]::ReadAllText($codePath, [System.Text.Encoding]::UTF8)
$code = $code.Replace("桃園市立大溪國民中學", $SchoolFullName)
$code = $code.Replace("大溪國中", $SchoolShortName)
if ($BadgeThreshold -ge 50 -and $BadgeThreshold -le 100 -and $BadgeThreshold -ne 85) {
  $code = $code.Replace("var BADGE_THRESHOLD_ = 85;", "var BADGE_THRESHOLD_ = $BadgeThreshold;")
  $code = $code.Replace("['BADGE_THRESHOLD', '85',", "['BADGE_THRESHOLD', '$BadgeThreshold',")
}
[System.IO.File]::WriteAllText($codePath, $code, $Utf8NoBom)

# 2. 更新 index.html 學校全銜、簡稱與 GAS_BACKEND_URL
$htmlPath = Join-Path $TargetDir "index.html"
$html = [System.IO.File]::ReadAllText($htmlPath, [System.Text.Encoding]::UTF8)
$html = $html.Replace("桃園市立大溪國民中學", $SchoolFullName)
$html = $html.Replace("大溪國中", $SchoolShortName)
if ($GasWebappUrl -and $GasWebappUrl -ne "https://script.google.com/macros/s/REPLACE_WITH_YOUR_DEPLOYMENT_ID/exec") {
  $html = [regex]::Replace($html, "const GAS_BACKEND_URL = 'https://script\.google\.com/macros/s/[^']+/exec';", "const GAS_BACKEND_URL = '$GasWebappUrl';")
}
[System.IO.File]::WriteAllText($htmlPath, $html, $Utf8NoBom)

# 3. 同步更新測試腳本斷言
$testPath = Join-Path $TargetDir "tests\backend.test.cjs"
$testJs = [System.IO.File]::ReadAllText($testPath, [System.Text.Encoding]::UTF8)
$testJs = $testJs.Replace("桃園市立大溪國民中學", $SchoolFullName)
$testJs = $testJs.Replace("大溪國中", $SchoolShortName)
if ($BadgeThreshold -ge 50 -and $BadgeThreshold -le 100 -and $BadgeThreshold -ne 85) {
  $testJs = $testJs.Replace("assert.equal(cfg.badgeThreshold, 85);", "assert.equal(cfg.badgeThreshold, $BadgeThreshold);")
  $testJs = $testJs.Replace("/85/", "/$BadgeThreshold/")
}
[System.IO.File]::WriteAllText($testPath, $testJs, $Utf8NoBom)

Write-Output "SCAFFOLD_OK: $TargetDir ($SchoolFullName / $SchoolShortName, BadgeThreshold=$BadgeThreshold)"
