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

    $files = ls ./;
    $count = 0;
    Write-Host ($count);

    foreach ($file in $files[$RangeStart..$RangeEnd]) {
        #Create a row
        $row = $table.NewRow();
        #Enter data in the row
        $row.FileName = $file.Name; 
        Write-Host ("[$RangeStart, $RangeEnd]Processing " + $file.Name);
        $ocrCmd = "tesseract " + $file.Name +" stdout -psm 6 -l eng";
        $result = bash -c $ocrCmd;
        Write-Host($result );
        $row.Text = $result -join ' ';
        #Add the row to the table
        $table.Rows.Add($row);
        $count = $count+1;
    # if ($count -gt 8) {
        #    break;
    # }
    }

    #Display the table
    $table | format-table -AutoSize 

    #NOTE: Now you can also export this table to a CSV file as shown below.
    $filename =  "../EnglishText_" + $RangeStart+"_"+ $RangeEnd+ ".csv";
    $tabCsv = $table | export-csv $filename -noType -Encoding ASCII;
}


function GetRange() {
    $files = ls ./;
    Write-Host "0.." + ($files.Length-1);
}