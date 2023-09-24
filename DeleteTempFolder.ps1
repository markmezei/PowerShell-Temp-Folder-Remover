$AppData = [System.Environment]::GetFolderPath('LocalApplicationData')
$TempFolder = join-path $AppData 'Temp'

if (test-path $TempFolder){
    $beforeSize = (gci $TempFolder -recurse | measure -property Length -sum).Sum
    ri -path $TempFolder\* -recurse -force -errorAction SilentlyContinue
    $afterSize = (gci $TempFolder -recurse | measure -property Length -sum).Sum
    
    $deletedMB = [System.Math]::Round(($beforeSize - $afterSize) / 1MB, 2)
    $deletedGB = [System.Math]::Round(($beforeSize - $afterSize) / 1GB, 2)

    if($deletedGB -gt 0 -or $deletedMB -gt 0){
        echo "Temp folder deleted successfully."
        echo "Freed up $deletedGB GB ($deletedMB MB) of disk space"
    }
    else{
        echo "No disk space was freed up"
    }
}   
else{
    echo "Temp folder not found"
}