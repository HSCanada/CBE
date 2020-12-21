Operation =1
Option =0
Where ="(((comm_transaction.fiscal_yearmo_num)>=\"201911\") AND ((comm_transaction.item_"
    "comm_group_cd) In (\"SPMFGS\",\"SPMFGE\",\"FRESND\",\"FRESEQ\")) AND ((comm_tran"
    "saction.salesperson_cd)=\"WZ1PB\") AND ((comm_transaction.source_cd)=\"IMPORT\")"
    ")"
Begin InputTables
    Name ="comm_transaction"
End
Begin OutputColumns
    Expression ="comm_transaction.fiscal_yearmo_num"
    Expression ="comm_transaction.gp_ext_amt"
    Expression ="comm_transaction.record_id"
    Expression ="comm_transaction.item_comm_group_cd"
    Expression ="comm_transaction.salesperson_cd"
    Expression ="comm_transaction.source_cd"
    Expression ="comm_transaction.transaction_txt"
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
dbMemo "OrderBy" ="[qryFG-Detail-FSC-adhoc].[item_comm_group_cd], [qryFG-Detail-FSC-adhoc].[fiscal_"
    "yearmo_num]"
Begin
    Begin
        dbText "Name" ="comm_transaction.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.gp_ext_amt"
        dbInteger "ColumnWidth" ="1515"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.transaction_txt"
        dbInteger "ColumnWidth" ="2370"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-30
    Right =1531
    Bottom =825
    Left =-1
    Top =-1
    Right =1507
    Bottom =445
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =40
        Top =51
        Right =634
        Bottom =518
        Top =0
        Name ="comm_transaction"
        Name =""
    End
End
