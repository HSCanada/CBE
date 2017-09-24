Operation =1
Option =0
Having ="(((comm_transaction.salesperson_key_id)=\"ADAM.JONES\") AND ((comm_transaction.s"
    "ource_cd)<>\"PAYROLL\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="comm_transaction"
End
Begin OutputColumns
    Alias ="Sales Type"
    Expression ="IIf([salesperson_key_id]=\"internal\",\"INT\",IIf([salesperson_key_id]=\"\",\"UN"
        "ASSIGNED\",\"SALES\"))"
    Expression ="comm_transaction.hsi_shipto_div_cd"
    Expression ="comm_transaction.salesperson_key_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.source_cd"
    Alias ="SumOftransaction_amt"
    Expression ="Sum(comm_transaction.transaction_amt)"
End
Begin Joins
    LeftTable ="comm_configure"
    RightTable ="comm_transaction"
    Expression ="comm_configure.current_fiscal_yearmo_num = comm_transaction.fiscal_yearmo_num"
    Flag =1
End
Begin Groups
    Expression ="IIf([salesperson_key_id]=\"internal\",\"INT\",IIf([salesperson_key_id]=\"\",\"UN"
        "ASSIGNED\",\"SALES\"))"
    GroupLevel =0
    Expression ="comm_transaction.hsi_shipto_div_cd"
    GroupLevel =0
    Expression ="comm_transaction.salesperson_key_id"
    GroupLevel =0
    Expression ="comm_transaction.item_comm_group_cd"
    GroupLevel =0
    Expression ="comm_transaction.source_cd"
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
        dbText "Name" ="Sales Type"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1590"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_key_id"
        dbInteger "ColumnWidth" ="2475"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="SumOftransaction_amt"
        dbInteger "ColumnWidth" ="2550"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2085"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1161
    Bottom =999
    Left =-1
    Top =-1
    Right =1137
    Bottom =540
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
        Right =765
        Bottom =454
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
