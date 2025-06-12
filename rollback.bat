@echo off
setlocal

rem This script rolls back a release by deleting the Git tag and reverting the release commit.

rem --- Configuration ---
set "REMOTE_NAME=origin"
set "MAIN_BRANCH=main"

rem --- Script ---

rem 1. Check for version argument
set "VERSION=%~1"
if not defined VERSION (
    echo Error: No version specified.
    echo Usage: %~n0 ^<version^>
    echo   ^<version^>: The version to roll back (e.g., v1.2.3).
    exit /b 1
)

rem 2. Check for clean working directory
for /f "tokens=*" %%a in ('git status --porcelain') do (
    echo Error: Working directory is not clean. Please commit or stash your changes.
    exit /b 1
)

echo Fetching latest data from remote...
git fetch %REMOTE_NAME%

rem 3. Verify the tag exists locally and remotely
git tag -l | findstr /B /E /C:"%VERSION%" >nul
if %errorlevel% neq 0 (
    echo Error: Tag %VERSION% does not exist locally.
    exit /b 1
)

git ls-remote --tags %REMOTE_NAME% | findstr /E /C:"refs/tags/%VERSION%" >nul
if %errorlevel% neq 0 (
    echo Error: Tag %VERSION% does not exist on remote '%REMOTE_NAME%'.
    exit /b 1
)

rem 4. Find the release commit
set "VERSION_NUMBER=%VERSION:v=%"
set "COMMIT_HASH="
for /f "delims=" %%a in ('git log --grep="chore(release): %VERSION_NUMBER%" --pretty=format:"%%H" -n 1') do set "COMMIT_HASH=%%a"

if not defined COMMIT_HASH (
    echo Error: Could not find the release commit for version %VERSION%.
    echo Looked for commit with message: 'chore(release): %VERSION_NUMBER%'
    exit /b 1
)

echo Found release commit:
git show --no-patch --pretty=oneline %COMMIT_HASH%

rem 5. Ask for confirmation
echo.
echo You are about to perform the following actions:
echo   1. Delete tag '%VERSION%' from remote '%REMOTE_NAME%'.
echo   2. Delete tag '%VERSION%' locally.
echo   3. Revert commit '%COMMIT_HASH%' on branch '%MAIN_BRANCH%'.
echo   4. Push the revert to '%REMOTE_NAME%/%MAIN_BRANCH%'.
echo.
set /p "CHOICE=Are you sure you want to continue? (y/n) "
if /i not "%CHOICE%"=="y" (
    echo Rollback cancelled.
    exit /b 0
)

rem 6. Delete the remote tag
echo Deleting remote tag %VERSION%...
git push %REMOTE_NAME% --delete %VERSION%

rem 7. Delete the local tag
echo Deleting local tag %VERSION%...
git tag -d %VERSION%

rem 8. Revert the commit
echo Reverting commit %COMMIT_HASH%...
git revert --no-edit %COMMIT_HASH%

rem 9. Push the revert
echo Pushing revert to %REMOTE_NAME%/%MAIN_BRANCH%...
git push %REMOTE_NAME% HEAD:%MAIN_BRANCH%

echo.
echo Rollback of version %VERSION% completed successfully!
echo Please ensure any deployments of %VERSION% are rolled back manually if they were not automated.

endlocal 