﻿Operation =4
Option =0
Where ="(((comm_free_goods_redeem.SourceCode)=\"ACT\") AND ((comm_free_goods_redeem.CalM"
    "onth)=[enter fiscal1]))"
Begin InputTables
    Name ="comm_free_goods_redeem"
    Name ="zzzCustList"
End
Begin OutputColumns
    Name ="comm_free_goods_redeem.salesperson_ess_cd"
    Expression ="Trim([note_txt])"
End
Begin Joins
    LeftTable ="comm_free_goods_redeem"
    RightTable ="zzzCustList"
    Expression ="comm_free_goods_redeem.SalesOrderNumber = zzzCustList.hsi_customer_id"
    Flag =1
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
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
Begin
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.doc_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubESS_Salesorder.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.ID"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_transaction.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesorder_ESS_map.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesorder_ESS_map.ess_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_free_goods_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.SourceCode"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.Source"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.salesperson_ess_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesorder_ESS_map.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_free_goods_redeem.CalMonth"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="zzzCustList.note_txt"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =1
    Top =46
    Right =1527
    Bottom =1010
    Left =-1
    Top =-1
    Right =1502
    Bottom =397
    Left =0
    Top =0
    ColumnsShown =579
    Begin
        Left =332
        Top =73
        Right =573
        Bottom =387
        Top =0
        Name ="comm_free_goods_redeem"
        Name =""
    End
    Begin
        Left =658
        Top =109
        Right =802
        Bottom =253
        Top =0
        Name ="zzzCustList"
        Name =""
    End
End
