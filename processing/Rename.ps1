
function GetNormalizedName ($OldName) {
    $arr = $OldName.Split("._");
    $pageNo = [int]$arr[1];
    $lineNo = [int]$arr[3];
    $pageStr = "{0:D4}" -f $pageNo;
    $lineStr = "{0:D2}" -f $lineNo;
    return "page_"+$pageStr+"_line_"+$lineStr+".png";
}

$files = ls ./;
foreach ($file in $files) {
    $newName = GetNormalizedName($file.Name);
    Write-Host ("Renaming " + $file.Name + " to  "+ $newName);
    Rename-Item $file.Name $newName;
}
