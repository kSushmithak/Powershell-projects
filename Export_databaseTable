#taking the copy of the database table to the perticular path
#Exporting a tables to the particular path
 
cls
$SrcServer = "AZSU-D-DTL1-700"
$SrcDatabase = "MessageTracker"
$tables = @("MappingType", "Entity", "SystemEntity")
$Schema = "EntityMapping"
 
foreach ($table in $tables) {
$data = Read-SQLTableData -ServerInstance $SrcServer -DatabaseName $SrcDatabase -SchemaName $Schema -TableName $table
 
   # Export data to CSV
   $csvPath = "\\vfipffil005\EMT_Projects\Sushmitha Kumarshetty\$table.csv"
   $data | Export-Csv -Path $csvPath -NoTypeInformation
}
 
write-host Exported table data successfully
