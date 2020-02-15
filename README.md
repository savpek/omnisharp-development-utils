# Omnisharp-devel-utils

Tools that gives possibility to develop omnisharp-vscode and underlaying omnisharp-roslyn in watcher like manner.

Developing extension side is easy until you have to develop backend side at same time to create and test meaningfull
feature. This utility tool tries to solve that problem.

When targeted binaries or vsvix is updated or built close current vscode session and script automatically re-opens
updated session with latest binaries. Omnisharp-roslyn executables are copied so that locking dll issues are prevented.
