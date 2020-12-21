Operation =1
Option =0
Where ="(((comm_free_goods_redeem.CalMonth)=201901))"
Begin InputTables
    Name ="comm_free_goods_redeem"
End
Begin OutputColumns
    Expression ="comm_free_goods_redeem.CalMonth"
    Expression ="comm_free_goods_redeem.salesperson_ess_cd"
    Expression ="comm_free_goods_redeem.FiscalMonth_actual"
    Expression ="comm_free_goods_redeem.ExtFileCostCadAmt"
    Expression ="comm_free_goods_redeem.ID_legacy"
    Expression ="comm_free_goods_redeem.comm_group_cd"
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
dbMemo "OrderBy" ="[qryFG-Summary-ESS].[comm_group_cd]"
Begin
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ID_legacy"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.FiscalMonth_actual"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1445
    Bottom =853
    Left =-1
    Top =-1
    Right =1421
    Bottom =415
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =661
        Top =65
        Right =1087
        Bottom =334
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
End
