Operation =1
Option =0
Begin InputTables
    Name ="zzzItemList"
    Name ="comm_item_master"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="zzzItemList.item_id"
    Expression ="zzzItemList.note_txt"
    Expression ="comm_item_master.item_master_desc"
    Expression ="comm_item_master.comm_group_cd"
    Expression ="BRS_Item.Supplier"
    Expression ="BRS_Item.SubMajorProdClass"
    Expression ="BRS_Item.Est12MoSales"
End
Begin Joins
    LeftTable ="zzzItemList"
    RightTable ="comm_item_master"
    Expression ="zzzItemList.item_id = comm_item_master.item_id"
    Flag =1
    LeftTable ="zzzItemList"
    RightTable ="BRS_Item"
    Expression ="zzzItemList.item_id = BRS_Item.Item"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[Est12MoSales] DESC, [Query1].[SubMajorProdClass]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Item.Est12MoSales"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.SubMajorProdClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItemList.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_item_master.item_master_desc"
        dbInteger "ColumnWidth" ="3255"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzItemList.note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1524
    Bottom =937
    Left =-1
    Top =-1
    Right =1500
    Bottom =617
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =58
        Top =28
        Right =202
        Bottom =172
        Top =0
        Name ="zzzItemList"
        Name =""
    End
    Begin
        Left =245
        Top =139
        Right =593
        Bottom =571
        Top =0
        Name ="comm_item_master"
        Name =""
    End
    Begin
        Left =356
        Top =35
        Right =833
        Bottom =473
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
