Operation =1
Option =0
Where ="(((comm_transaction.source_cd)=\"JDE\"))"
Having ="(((comm_transaction.salesperson_key_id)<>\"internal\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.salesperson_key_id"
    Alias ="FirstOfhsi_shipto_id"
    Expression ="First(comm_transaction.hsi_shipto_id)"
    Alias ="SumOftransaction_amt1"
    Expression ="Sum(comm_transaction.transaction_amt)"
    Alias ="CountOfrecord_id"
    Expression ="Count(comm_transaction.record_id)"
    Expression ="comm_transaction.fiscal_yearmo_num"
    Alias ="FirstOfrecord_id"
    Expression ="First(comm_transaction.record_id)"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
Begin Groups
    Expression ="comm_transaction.salesperson_key_id"
    GroupLevel =0
    Expression ="comm_transaction.fiscal_yearmo_num"
    GroupLevel =0
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbText "Description" ="Run Commission Calc first"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="SumOftransaction_amt1"
        dbInteger "ColumnWidth" ="2280"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbInteger "ColumnWidth" ="1860"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="CountOfrecord_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfrecord_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FirstOfhsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =22
    Top =155
    Right =1544
    Bottom =999
    Left =-1
    Top =-1
    Right =1498
    Bottom =302
    Left =0
    Top =0
    ColumnsShown =543
    Begin
        Left =38
        Top =6
        Right =213
        Bottom =143
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =268
        Top =5
        Right =576
        Bottom =247
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
