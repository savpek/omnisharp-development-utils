# Omnisharp-devel-utils

Tools that gives possibility to develop omnisharp-vscode and underlaying omnisharp-roslyn in watcher like manner.

Developing extension side is easy until you have to develop backend side at same time to create and test meaningfull
feature. This utility tool tries to solve that problem.

When targeted binaries or vsvix is updated or built close current vscode session and script automatically re-opens
updated session with latest binaries. Omnisharp-roslyn executables are copied so that locking dll issues are prevented.

## Examples

```powershell
.\RunVscode.ps1 -VscodeWorkspaceFolder c:\github\test-project\ -OmnisharpBinaryFolder C:\\Github\omnisharp-roslyn\bin\Debug\OmniSharp.Stdio.Driver\net472\Omnisharp.exe
```

Starts Vscode and configures it to use omnisharp from defined folder. Doesn't lock original binaries so you can
build it freely during development. To restart vscode simply close it and it will automatically restart.