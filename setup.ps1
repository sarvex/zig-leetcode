# Remove all files except JS and TS files
Get-ChildItem -Path . -Recurse -File | Where-Object { $_.Extension -notin ".c","cpp",".zig" } | Remove-Item -Force

# Function to process code files
function Process-Files($extension) {
    Get-ChildItem -Path . -Recurse -Filter "*$extension" -File | ForEach-Object {
        $parentDirName = Split-Path (Split-Path $_.Directory -Parent) -Leaf
        $targetDir = Split-Path (Split-Path (Split-Path $_.Directory -Parent) -Parent) -Parent
        $newPath = Join-Path $targetDir "$parentDirName.zig"

        if (-not (Test-Path $newPath)) {
            Move-Item $_.FullName $newPath
        }
    }
}

# Process both file types
Process-Files ".c"
Process-Files ".cpp"
Process-Files ".zig"

Write-Output "Setup completed successfully!"
