chcp 65001;
$OutputEncoding = New-Object -typename System.Text.UTF8Encoding;
[Console]::OutputEncoding = $OutputEncoding;

function DoOCR([int]$RangeStart, [int]$RangeEnd) {
    $tabName = "ENGOCR";

    #Create Table object
    $table = New-Object system.Data.DataTable "$tabName";

    #Define Columns
    $col1 = New-Object system.Data.DataColumn FileName,([string]);
    $col2 = New-Object system.Data.DataColumn Text,([string]);
    #Add the Columns
    $table.columns.add($col1);
    $table.columns.add($col2);

    $files = ls ./segments_eng;
    $count = 0;

    foreach ($file in $files[$RangeStart..$RangeEnd]) {
        $count = $count +1;
        #Create a row
        $row = $table.NewRow();
        #Enter data in the row
        $row.FileName = $file.Name; 
        Write-Host ("[$RangeStart, $RangeEnd] ($count of $($RangeEnd-$RangeStart+1)) " + $file.Name);
        # Clean image
        $tmpFile = "./tmp/tmp_"+$RangeStart+"_"+$RangeEnd+".png";
        $cleanCmd = "./textcleaner -u segments_eng/" + $file.Name + " " + $tmpFile;
        bash -c $cleanCmd;
        # Do OCR
        $ocrCmd = "tesseract -psm 6 " + $tmpFile +" stdout ./tesseract.conf";
        $result = bash -c $ocrCmd;
        Write-Host($result );
        $row.Text = $result -join ' ';
        #Add the row to the table
        $table.Rows.Add($row);
    }

    #Display the table
    $table | format-table -AutoSize 

    #NOTE: Now you can also export this table to a CSV file as shown below.
    $filename =  "./EnglishText_" + $RangeStart+"_"+ $RangeEnd+ ".csv";
    $tabCsv = $table | export-csv $filename -noType -Encoding UTF8;
}


function GetRange() {
    $files = ls ./segments_eng;
    return 0, ($files.Length-1);
}

# start powershell "& {Echo $a; Read-Host;}"

function RunJobs() {
    $ranges = GetRange;
    $size = $ranges[1] - $ranges[0] +1; 
    $workers = 10;
    $eachSize = [math]::floor( $size / $workers);
    $lastSize = $size - $eachSize * $workers;
    for ($i = 0; $i -lt $workers; $i++) {
        $start = $ranges[0] + $i*$eachSize;
        $end = $start+$eachSize -1;
        start powershell "& {. ./OCR.ps1; DoOCR $start $end;}";
        
    }
    if ($lastSize -gt 0) {
        $start = $ranges[0]+$eachSize*$workers;
        $end = $ranges[1];
        start powershell "& {. ./OCR.ps1; DoOCR $start $end;}";
    }
}