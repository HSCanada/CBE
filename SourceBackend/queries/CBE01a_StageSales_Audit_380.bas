Operation =1
Option =0
Where ="(((comm_transaction_F555115_audit.FiscalMonth)=202011))"
Begin InputTables
    Name ="comm_transaction_F555115_audit"
End
Begin OutputColumns
    Expression ="comm_transaction_F555115_audit.FiscalMonth"
    Expression ="comm_transaction_F555115_audit.source_cd"
    Expression ="comm_transaction_F555115_audit.SalesDivision"
    Expression ="comm_transaction_F555115_audit.AdjOwner"
    Alias ="380_sales"
    Expression ="comm_transaction_F555115_audit.summarized_transaction_amt"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE01a_StageSales_Audit_380].[SalesDivision] DESC"
Begin
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.AdjOwner"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.SalesDivision"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_F555115_audit.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="380_sales"
        dbInteger "ColumnWidth" ="3165"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =-254
    Top =41
    Right =1268
    Bottom =936
    Left =-1
    Top =-1
    Right =1498
    Bottom =301
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =136
        Top =105
        Right =428
        Bottom =335
        Top =0
        Name ="comm_transaction_F555115_audit"
        Name =""
    End
End
