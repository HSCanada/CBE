Operation =1
Option =0
Where ="(((comm_free_goods_redeem.CalMonth)>=202001) AND ((comm_free_goods_redeem.salesp"
    "erson_cd) Is Null)) OR (((comm_free_goods_redeem.CalMonth)>=202001) AND ((comm_f"
    "ree_goods_redeem.comm_group_cd) Is Null)) OR (((comm_free_goods_redeem.comm_grou"
    "p_cd)=\"\"))"
Begin InputTables
    Name ="comm_free_goods_redeem"
    Name ="comm_customer_master"
End
Begin OutputColumns
    Expression ="comm_free_goods_redeem.CalMonth"
    Expression ="comm_free_goods_redeem.ShipTo"
    Expression ="comm_free_goods_redeem.PracticeName"
    Expression ="comm_free_goods_redeem.Item"
    Expression ="comm_free_goods_redeem.ItemDescription"
    Expression ="comm_free_goods_redeem.ExtFileCostCadAmt"
    Alias ="Fix_salesperson_cd"
    Expression ="comm_free_goods_redeem.salesperson_cd"
    Alias ="FIX_comm_group_cd"
    Expression ="comm_free_goods_redeem.comm_group_cd"
    Expression ="comm_customer_master.salesperson_cd"
    Expression ="comm_customer_master.customer_nm"
    Expression ="comm_free_goods_redeem.SourceCode"
    Expression ="comm_free_goods_redeem.comm_group_cd"
End
Begin Joins
    LeftTable ="comm_free_goods_redeem"
    RightTable ="comm_customer_master"
    Expression ="comm_free_goods_redeem.ShipTo = comm_customer_master.hsi_shipto_id"
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
        dbText "Name" ="Fix_salesperson_cd"
        dbInteger "ColumnWidth" ="2385"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="FIX_comm_group_cd"
        dbInteger "ColumnWidth" ="2520"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.comm_group_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.PracticeName"
        dbInteger "ColumnWidth" ="2415"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ItemDescription"
        dbInteger "ColumnWidth" ="3270"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_master.customer_nm"
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
    Bottom =349
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =55
        Top =33
        Right =484
        Bottom =266
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
    Begin
        Left =532
        Top =12
        Right =829
        Bottom =269
        Top =0
        Name ="comm_customer_master"
        Name =""
    End
End
