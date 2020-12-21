Operation =1
Option =0
Where ="(((comm_customer_rebate_YTD.fiscal_yearmo_num)>=\"202001\"))"
Begin InputTables
    Name ="zzzCustList"
    Name ="BRS_Customer"
    Name ="comm_customer_rebate_YTD"
End
Begin OutputColumns
    Expression ="BRS_Customer.BillTo"
    Expression ="BRS_Customer.ShipTo"
    Expression ="comm_customer_rebate_YTD.fiscal_yearmo_num"
    Expression ="BRS_Customer.VPA"
    Expression ="comm_customer_rebate_YTD.hsi_shipto_id"
    Expression ="comm_customer_rebate_YTD.salesperson_cd"
    Expression ="comm_customer_rebate_YTD.rebate_YTD"
End
Begin Joins
    LeftTable ="zzzCustList"
    RightTable ="BRS_Customer"
    Expression ="zzzCustList.hsi_customer_id = BRS_Customer.BillTo"
    Flag =1
    LeftTable ="BRS_Customer"
    RightTable ="comm_customer_rebate_YTD"
    Expression ="BRS_Customer.ShipTo = comm_customer_rebate_YTD.hsi_shipto_id"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[Query1].[fiscal_yearmo_num]"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="BRS_Customer.ShipTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.rebate_YTD"
        dbInteger "ColumnWidth" ="1815"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.salesperson_cd"
        dbInteger "ColumnWidth" ="1845"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.BillTo"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="BRS_Customer.VPA"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_customer_rebate_YTD.hsi_shipto_id"
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
        Top =59
        Right =202
        Bottom =203
        Top =0
        Name ="zzzCustList"
        Name =""
    End
    Begin
        Left =291
        Top =81
        Right =435
        Bottom =225
        Top =0
        Name ="BRS_Customer"
        Name =""
    End
    Begin
        Left =601
        Top =112
        Right =745
        Bottom =256
        Top =0
        Name ="comm_customer_rebate_YTD"
        Name =""
    End
End
