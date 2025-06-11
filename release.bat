@echo off
:: Set default release type to patch if not provided
set RELEASE_TYPE=%1
if "%RELEASE_TYPE%"=="" set RELEASE_TYPE=patch

echo Preparing %RELEASE_TYPE% release...

:: Run tests
echo Running tests...
call npm test

:: Run linting
echo Running linting...
call npm run lint

:: Create new version
echo Creating new version...
call npm run release:%RELEASE_TYPE%

:: Get the new version from package.json using node
for /f "tokens=*" %%i in ('node -p "require('./package.json').version"') do set VERSION=%%i
echo Version %VERSION% created.

:: Push changes and tags
echo Pushing changes and tags...
git push --follow-tags origin master

echo Release %VERSION% completed successfully!
echo Changelog has been updated.
echo A new Git tag v%VERSION% has been created.
echo Changes have been pushed to the repository.
