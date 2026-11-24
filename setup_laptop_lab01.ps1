# Laptop setup — SCD Labs 1-6, Lab 01 starter
# Run in PowerShell from inside the unzipped lms_project folder.
# It only CHECKS versions and builds - it never asks for passwords or tokens.
Write-Host "=== Lab 01 laptop check: Aziz Ahmed 24BSSW044 ==="
java -version
mvn -version
git --version
code --version
Write-Host ""
Write-Host "=== Maven compile (downloads Jansi + Checkstyle on first run) ==="
mvn compile
Write-Host ""
Write-Host "=== Checkstyle (uses config/checkstyle.xml) ==="
mvn checkstyle:check
Write-Host ""
Write-Host "=== Run HelloWorld ==="
mvn exec:java -Dexec.mainClass="com.hitms.lms.HelloWorld"
Write-Host ""
Write-Host "Done. Take screenshots of each step above for Lab 01."
Write-Host "Then: git init, git add ., git commit -m 'Initial commit: add LMS Maven project and gitignore'"
