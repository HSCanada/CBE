Operation =1
Option =0
Where ="(((BRS_Customer.ShipTo) Is Null)) OR (((BRS_TransactionDW_Ext.SalesOrderNumber) "
    "Is Null)) OR (((BRS_Item.Item) Is Null)) OR (((BRS_ItemSupplier.Supplier) Is Nul"
    "l))"
Begin InputTables
    Name ="itegration_comm_free_goods_redeem"
    Name ="BRS_TransactionDW_Ext"
    Name ="BRS_ItemSupplier"
    Name ="BRS_Customer"
    Name ="BRS_Item"
End
Begin OutputColumns
    Expression ="itegration_comm_free_goods_redeem.ID"
    Expression ="itegration_comm_free_goods_redeem.CalMonth"
    Expression ="itegration_comm_free_goods_redeem.Supplier"
    Expression ="BRS_ItemSupplier.Supplier"
    Expression ="itegration_comm_free_goods_redeem.ShipTo"
    Expression ="BRS_Customer.ShipTo"
    Expression ="itegration_comm_free_goods_redeem.PracticeName"
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber"
    Expression ="BRS_TransactionDW_Ext.SalesOrderNumber"
    Expression ="itegration_comm_free_goods_redeem.Item"
    Expression ="BRS_Item.Item"
    Expression ="itegration_comm_free_goods_redeem.ItemDescription"
    Expression ="itegration_comm_free_goods_redeem.ExtFileCostCadAmt"
    Expression ="itegration_comm_free_goods_redeem.SourceCode"
    Expression ="itegration_comm_free_goods_redeem.ID"
End
Begin Joins
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="BRS_TransactionDW_Ext"
    Expression ="itegration_comm_free_goods_redeem.SalesOrderNumber = BRS_TransactionDW_Ext.Sales"
        "OrderNumber"
    Flag =2
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="BRS_ItemSupplier"
    Expression ="itegration_comm_free_goods_redeem.Supplier = BRS_ItemSupplier.Supplier"
    Flag =2
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="BRS_Customer"
    Expression ="itegration_comm_free_goods_redeem.ShipTo = BRS_Customer.ShipTo"
    Flag =2
    LeftTable ="itegration_comm_free_goods_redeem"
    RightTable ="BRS_Item"
    Expression ="itegration_comm_free_goods_redeem.Item = BRS_Item.Item"
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
        dbText "Name" ="itegration_comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ShipTo"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2775"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.PracticeName"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3690"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ExtFileCostCadAmt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="itegration_comm_free_goods_redeem.ItemDescription"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_ItemSupplier.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_TransactionDW_Ext.SalesOrderNumber"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Expr1000"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Item.Item"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
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
    Bottom =448
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =71
        Top =60
        Right =353
        Bottom =319
        Top =0
        Name ="itegration_comm_free_goods_redeem"
        Name =""
    End
    Begin
        Left =754
        Top =209
        Right =978
        Bottom =433
        Top =0
        Name ="BRS_TransactionDW_Ext"
        Name =""
    End
    Begin
        Left =795
        Top =65
        Right =939
        Bottom =209
        Top =0
        Name ="BRS_ItemSupplier"
        Name =""
    End
    Begin
        Left =534
        Top =-12
        Right =678
        Bottom =132
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =482
        Top =314
        Right =626
        Bottom =458
        Top =0
        Name ="BRS_Item"
        Name =""
    End
End
