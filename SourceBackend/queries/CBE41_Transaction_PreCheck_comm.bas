Operation =1
Option =0
Where ="(((comm_transaction_stage.comm_group_cd)<>\"\") AND ((comm_group.comm_group_cd) "
    "Is Null)) OR (((comm_transaction_stage.ess_comm_group_cd)<>\"\") AND ((comm_grou"
    "p_1.comm_group_cd) Is Null))"
Begin InputTables
    Name ="comm_transaction_stage"
    Name ="comm_group"
    Name ="comm_group"
    Alias ="comm_group_1"
End
Begin OutputColumns
    Expression ="comm_transaction_stage.record_id"
    Expression ="comm_transaction_stage.comm_group_cd"
    Expression ="comm_transaction_stage.ess_comm_group_cd"
    Expression ="comm_group.comm_group_cd"
    Expression ="comm_group_1.comm_group_cd"
End
Begin Joins
    LeftTable ="comm_transaction_stage"
    RightTable ="comm_group"
    Expression ="comm_transaction_stage.comm_group_cd = comm_group.comm_group_cd"
    Flag =2
    LeftTable ="comm_transaction_stage"
    RightTable ="comm_group_1"
    Expression ="comm_transaction_stage.ess_comm_group_cd = comm_group_1.comm_group_cd"
    Flag =2
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
        dbText "Name" ="comm_transaction_stage.ess_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_stage.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction_stage.record_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group_1.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1390
    Bottom =937
    Left =-1
    Top =-1
    Right =1366
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =60
        Top =63
        Right =490
        Bottom =444
        Top =0
        Name ="comm_transaction_stage"
        Name =""
    End
    Begin
        Left =560
        Top =51
        Right =739
        Bottom =217
        Top =0
        Name ="comm_group"
        Name =""
    End
    Begin
        Left =618
        Top =281
        Right =762
        Bottom =425
        Top =0
        Name ="comm_group_1"
        Name =""
    End
End
