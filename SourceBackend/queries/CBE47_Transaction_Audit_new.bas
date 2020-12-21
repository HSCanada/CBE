Operation =1
Option =0
Begin InputTables
    Name ="FSC_Backend"
End
Begin OutputColumns
    Alias ="SumOftest_cm_sales"
    Expression ="Sum(FSC_Backend.test_cm_sales)"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="SumOftest_cm_sales"
        dbInteger "ColumnWidth" ="2400"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =44
    Top =93
    Right =1505
    Bottom =817
    Left =-1
    Top =-1
    Right =1437
    Bottom =463
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =73
        Top =76
        Right =490
        Bottom =436
        Top =0
        Name ="FSC_Backend"
        Name =""
    End
End
