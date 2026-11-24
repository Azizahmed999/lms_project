# ============================================================
# SCD Labs 01-06 - ALL-IN-ONE runner (local part)
# Student: Aziz Ahmed, Roll 24BSSW044, SEC321L, Instructor: Madina Ali
#
# HOW TO RUN:
#   1. Copy this file INSIDE the lms_project folder (next to pom.xml).
#   2. Open PowerShell in that folder.
#   3. Run:  powershell -ExecutionPolicy Bypass -File .\do_all_labs.ps1
#
# WHAT IT DOES (all REAL, on this laptop):
#   Lab 01: version checks, mvn compile, HelloWorld, Colors (Jansi)
#   Lab 01/02: Checkstyle clean -> 2 intentional mistakes -> fail -> fix -> clean
#   Lab 02: AreaCalculator, PriceUtils runs
#   Lab 03: ReportUtil, Main (LibraryUtils) runs
#   Lab 04: DivisionDemo, BookIssueDemo, DebuggingDemo, AppLogger (fresh app.log)
#   Lab 05: git init, 3+ commits, feature branch + merge, git log
#   Lab 06: REAL git merge conflict (2 branches, same line), markers saved,
#           resolution, merge completed, final verification
# WHAT IT DOES NOT DO:
#   No GitHub push / no pull request (that step needs your GitHub login -
#   it is done afterwards in Chrome). No passwords or tokens are used.
# OUTPUT:
#   An "evidence" folder inside lms_project + a zip on your Desktop:
#   SCD_Evidence_Labs_Local.zip  -> send that zip back to Muse.
# ============================================================

$ErrorActionPreference = "Continue"
Set-Location -Path $PSScriptRoot

$Evidence = Join-Path $PSScriptRoot "evidence"
New-Item -ItemType Directory -Force -Path $Evidence | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Evidence "Lab01") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Evidence "Lab02") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Evidence "Lab03") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Evidence "Lab04") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Evidence "Lab05") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Evidence "Lab06") | Out-Null

$TranscriptFile = Join-Path $Evidence "full_run_log.txt"
try { Start-Transcript -Path $TranscriptFile -Force | Out-Null } catch { }

function Show-Header($text) {
    Write-Host ""
    Write-Host "============================================================"
    Write-Host $text
    Write-Host "============================================================"
}

function Save-Text($path, $text) {
    $text | Out-File -FilePath $path -Encoding utf8
}

Show-Header "SCD LABS - ALL-IN-ONE RUN - Aziz Ahmed 24BSSW044 - $(Get-Date)"

# ------------------------------------------------------------
# LAB 01 - Task 1: environment verification
# ------------------------------------------------------------
Show-Header "LAB 01 Task 1: java -version"
java -version
Show-Header "LAB 01 Task 1: mvn -version"
mvn -version
Show-Header "LAB 01 Task 1: git --version"
git --version
Show-Header "LAB 01 Task 1: code --version (VS Code)"
code --version

# ------------------------------------------------------------
# Compile everything (Labs 01-04 code)
# ------------------------------------------------------------
Show-Header "BUILD: mvn compile"
mvn compile
if ($LASTEXITCODE -ne 0) {
    Write-Host "!!! mvn compile FAILED - stopping. Send the evidence zip back as-is."
    try { Stop-Transcript | Out-Null } catch { }
    exit 1
}

$CP = "target\classes"
$CPJ = "target\classes;lib\jansi-2.4.1.jar"

# ------------------------------------------------------------
# LAB 01 - Task 1: HelloWorld
# ------------------------------------------------------------
Show-Header "LAB 01 Task 1: HelloWorld"
java -cp $CP com.hitms.lms.HelloWorld

# ------------------------------------------------------------
# LAB 01 - Task 3: Colors (Jansi green output)
# NOTE: colour only shows on screen - the text is logged here.
# ------------------------------------------------------------
Show-Header "LAB 01 Task 3: Colors (green output with Jansi)"
java -cp $CPJ com.hitms.lms.Colors

# ------------------------------------------------------------
# LAB 02 runs
# ------------------------------------------------------------
Show-Header "LAB 02 Task 1: AreaCalculator"
java -cp $CP com.hitms.lms.AreaCalculator
Show-Header "LAB 02 Task 2: PriceUtils (Javadoc class)"
java -cp $CP com.hitms.lms.PriceUtils

# ------------------------------------------------------------
# LAB 03 runs
# ------------------------------------------------------------
Show-Header "LAB 03 Task 1: ReportUtil (method decomposition)"
java -cp $CP com.hitms.lms.ReportUtil
Show-Header "LAB 03 Task 2: Main using LibraryUtils (util package)"
java -cp $CP com.hitms.lms.Main

# ------------------------------------------------------------
# LAB 04 runs
# ------------------------------------------------------------
Show-Header "LAB 04 Task 1: DivisionDemo (exception handling)"
java -cp $CP com.hitms.lms.DivisionDemo
Show-Header "LAB 04 Task 2: BookIssueDemo (custom BookUnavailableException)"
java -cp $CP com.hitms.lms.BookIssueDemo
Show-Header "LAB 04 Task 3: DebuggingDemo (findMax fixed for negatives)"
java -cp $CP com.hitms.lms.DebuggingDemo
Show-Header "LAB 04 Task 4: AppLogger (logging to app.log)"
if (Test-Path "app.log") { Remove-Item "app.log" -Force }
java -cp $CP com.hitms.lms.util.AppLogger
if (Test-Path "app.log") {
    Write-Host "app.log was created on this laptop. Contents:"
    Get-Content "app.log"
    Copy-Item "app.log" (Join-Path $Evidence "Lab04\app.log") -Force
} else {
    Write-Host "!!! app.log was NOT created - note this in the evidence."
}

# ------------------------------------------------------------
# LAB 01 Task 4 + LAB 02 Task 3: Checkstyle cycle
# clean -> add 2 mistakes -> FAIL -> remove mistakes -> clean
# ------------------------------------------------------------
$HelloFile = Join-Path $PSScriptRoot "src\main\java\com\hitms\lms\HelloWorld.java"
$HelloBackup = Join-Path $Evidence "Lab01\HelloWorld.java.clean_backup"
Copy-Item $HelloFile $HelloBackup -Force

Show-Header "CHECKSTYLE RUN 1: clean code (expect 0 violations, BUILD SUCCESS)"
mvn checkstyle:check

Show-Header "CHECKSTYLE RUN 2: adding 2 intentional mistakes"
$code = Get-Content $HelloFile -Raw
$code = $code.Replace("package com.hitms.lms;", "package com.hitms.lms;`r`n`r`nimport java.util.ArrayList;")
$code = $code + "`r`n    // This is a very long line intentionally added for Lab 01 Task 4 to cross the one hundred and twenty character Checkstyle limit easily`r`n"
Set-Content -Path $HelloFile -Value $code -Encoding utf8
Write-Host "Mistakes added: (1) unused import java.util.ArrayList  (2) line longer than 120 characters"
Get-Content $HelloFile
mvn checkstyle:check
Write-Host "Checkstyle exit code with mistakes: $LASTEXITCODE (non-zero / BUILD FAILURE is EXPECTED here)"

Show-Header "CHECKSTYLE RUN 3: mistakes removed (expect 0 violations, BUILD SUCCESS)"
Copy-Item $HelloBackup $HelloFile -Force
mvn checkstyle:check

# ------------------------------------------------------------
# LAB 05 - Git fundamentals (local)
# ------------------------------------------------------------
Show-Header "LAB 05: Git setup"
if (Test-Path ".git") {
    Write-Host "!!! A .git folder already exists in lms_project."
    Write-Host "Git steps for Lab 05/06 are SKIPPED to protect the existing history."
    Write-Host "Send the evidence zip back and tell Muse - a fresh copy will be used for Git labs."
} else {
    $gitName = git config user.name
    if (-not $gitName) {
        $gitName = Read-Host "Type your name for Git commits (e.g. Aziz Ahmed)"
        git config --global user.name "$gitName"
    }
    $gitEmail = git config user.email
    if (-not $gitEmail) {
        $gitEmail = Read-Host "Type your email for Git commits (the one you use on GitHub)"
        git config --global user.email "$gitEmail"
    }
    Write-Host "Git user: $gitName <$gitEmail>"

    # make sure the evidence folder itself is never committed
    $ignore = Get-Content ".gitignore" -Raw
    if ($ignore -notmatch "evidence/") {
        Add-Content ".gitignore" "`r`nevidence/"
    }

    git init -b main
    git status
    git add .
    git commit -m "Initial commit: add LMS Maven project and gitignore"
    git log --oneline

    Show-Header "LAB 05: second commit on main (README progress note)"
    Add-Content "README.md" "`r`n## Labs progress`r`nLabs 01-04 code verified on the laptop (compile, runs, Checkstyle)."
    git add README.md
    git commit -m "Add labs progress note to README"
    git log --oneline

    Show-Header "LAB 05 Task 2: feature branch feature/add-member-lookup"
    git checkout -b feature/add-member-lookup
    $svc = Join-Path $PSScriptRoot "src\main\java\com\hitms\lms\service\LibraryService.java"
    $svcCode = Get-Content $svc -Raw
    $newMethod = @"
    /**
     * Finds a member by name (added on feature/add-member-lookup).
     *
     * @param name member name to find
     * @return the member, or null when the name is unknown
     */
    public Member findMemberByName(String name) {
        if ("Aziz Ahmed".equals(name)) {
            return new Member(1, "Aziz Ahmed");
        }
        return null;
    }
}
"@
    # replace the final closing brace of the class with the new method + brace
    $idx = $svcCode.LastIndexOf("}")
    $svcCode = $svcCode.Substring(0, $idx) + $newMethod + "`r`n"
    Set-Content -Path $svc -Value $svcCode -Encoding utf8
    Get-Content $svc
    mvn compile
    git add src/main/java/com/hitms/lms/service/LibraryService.java
    git commit -m "Add findMemberByName() helper method"
    git checkout main
    git merge feature/add-member-lookup
    Show-Header "LAB 05 Task 3: commit history, status, branches"
    git log --oneline
    git status
    git branch
    Save-Text (Join-Path $Evidence "Lab05\git_log.txt") (git log --oneline --graph --all | Out-String)
    Save-Text (Join-Path $Evidence "Lab05\git_branch.txt") (git branch | Out-String)
    Save-Text (Join-Path $Evidence "Lab05\git_status.txt") (git status | Out-String)

    # --------------------------------------------------------
    # LAB 06 Task 1 (local): REAL merge conflict + resolution
    # --------------------------------------------------------
    Show-Header "LAB 06 Task 1: creating two branches from the same commit"
    $svcRel = "src/main/java/com/hitms/lms/service/LibraryService.java"
    $oldLine = "/** Lab 03/04/05 - book issuing and member lookup for the LMS. */"
    $lineA   = "/** Lab 03/04/05 - book issuing service for the LMS catalogue. */"
    $lineB   = "/** Lab 03/04/05 - member lookup and book issuing service for the LMS. */"
    $lineFix = "/** Lab 03/04/05 - book issuing and member lookup service for the LMS catalogue. */"

    git checkout -b conflict-a
    $c = Get-Content $svc -Raw; $c = $c.Replace($oldLine, $lineA); Set-Content -Path $svc -Value $c -Encoding utf8
    git add $svcRel
    git commit -m "Conflict A: reword LibraryService class comment (catalogue)"

    git checkout main
    git checkout -b conflict-b
    $c = Get-Content $svc -Raw; $c = $c.Replace($oldLine, $lineB); Set-Content -Path $svc -Value $c -Encoding utf8
    git add $svcRel
    git commit -m "Conflict B: reword LibraryService class comment (member lookup)"

    Show-Header "LAB 06 Task 1: merging conflict-b into conflict-a (conflict EXPECTED)"
    git checkout conflict-a
    Save-Text (Join-Path $Evidence "Lab06\before_conflict_state.txt") ("Branch conflict-a, file comment line:" + "`r`n" + (Select-String -Path $svc -Pattern "Lab 03/04/05" | Out-String))
    git merge conflict-b
    Write-Host "Merge exit code: $LASTEXITCODE (non-zero means Git stopped with a real conflict)"
    git status
    Save-Text (Join-Path $Evidence "Lab06\git_status_conflict.txt") (git status | Out-String)
    Copy-Item $svc (Join-Path $Evidence "Lab06\LibraryService_with_conflict_markers.java") -Force
    Write-Host "--- File with Git conflict markers (<<<<<<< ======= >>>>>>>) ---"
    Get-Content $svc

    Show-Header "LAB 06 Task 1: resolving the conflict by hand (combined comment)"
    $c = Get-Content $svc -Raw
    # remove the whole conflict block and put the resolved line in its place
    $pattern = "(?s)<<<<<<< HEAD.*?>>>>>>> conflict-b"
    $c = [regex]::Replace($c, $pattern, $lineFix)
    Set-Content -Path $svc -Value $c -Encoding utf8
    Get-Content $svc
    Copy-Item $svc (Join-Path $Evidence "Lab06\LibraryService_resolved.java") -Force
    git add $svcRel
    git commit -m "Resolve merge conflict in LibraryService comment (combined wording)"
    git checkout main
    git merge conflict-a
    Show-Header "LAB 06: final history after conflict + resolution + merge"
    git log --oneline --graph --all
    git status
    git branch
    Save-Text (Join-Path $Evidence "Lab06\git_log_final.txt") (git log --oneline --graph --all | Out-String)
}

# ------------------------------------------------------------
# Final verification
# ------------------------------------------------------------
Show-Header "FINAL VERIFICATION: mvn compile + Checkstyle clean"
mvn compile
mvn checkstyle:check
Show-Header "DONE - local labs finished"
Write-Host "GitHub push + Pull Request (Lab 05 Task 4 / Lab 06 Task 2) are NOT done yet -"
Write-Host "they need your GitHub login and will be done in Chrome with Muse."
Write-Host "Now send the zip SCD_Evidence_Labs_Local.zip from your Desktop back to Muse."

try { Stop-Transcript | Out-Null } catch { }

# Zip the evidence folder onto the Desktop
$desktop = [Environment]::GetFolderPath("Desktop")
$zipPath = Join-Path $desktop "SCD_Evidence_Labs_Local.zip"
if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
Compress-Archive -Path (Join-Path $Evidence "*") -DestinationPath $zipPath -Force
Write-Host ""
Write-Host "============================================================"
Write-Host "EVIDENCE ZIP CREATED: $zipPath"
Write-Host "Send this one zip file back to Muse in the chat."
Write-Host "============================================================"
