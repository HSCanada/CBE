Operation =1
Option =0
Begin InputTables
    Name ="qsub_EPS_Details"
    Name ="comm_group"
End
Begin OutputColumns
    Expression ="qsub_EPS_Details.fiscal_yearmo_num"
    Alias ="Eps_Code"
    Expression ="qsub_EPS_Details.SegCd"
    Expression ="qsub_EPS_Details.hsi_shipto_div_cd"
    Expression ="qsub_EPS_Details.MarketClass"
    Expression ="qsub_EPS_Details.SegCd"
    Expression ="qsub_EPS_Details.Specialty"
    Expression ="qsub_EPS_Details.branch_cd"
    Expression ="qsub_EPS_Details.Supplier"
    Alias ="Supplier_Description"
    Expression ="comm_group.comm_group_desc"
    Expression ="qsub_EPS_Details.salesperson_cd"
    Expression ="qsub_EPS_Details.item_id"
    Expression ="qsub_EPS_Details.transaction_txt"
    Expression ="qsub_EPS_Details.item_comm_group_cd"
    Expression ="qsub_EPS_Details.shipped_qty"
    Expression ="qsub_EPS_Details.transaction_amt"
    Expression ="qsub_EPS_Details.gp_ext_amt"
    Expression ="qsub_EPS_Details.transaction_dt"
    Expression ="qsub_EPS_Details.hsi_shipto_id"
    Expression ="qsub_EPS_Details.hsi_shipto_nm"
    Expression ="qsub_EPS_Details.doc_key_id"
    Expression ="qsub_EPS_Details.line_id"
    Expression ="qsub_EPS_Details.source_cd"
    Expression ="qsub_EPS_Details.reference_order_txt"
End
Begin Joins
    LeftTable ="qsub_EPS_Details"
    RightTable ="comm_group"
    Expression ="qsub_EPS_Details.Supplier = comm_group.comm_group_cd"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="0"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[EPS_Details].[Supplier_Description]"
Begin
    Begin
        dbText "Name" ="qsub_EPS_Details.Supplier"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.Specialty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.reference_order_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.hsi_shipto_div_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.SegCd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.MarketClass"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.item_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.item_comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.hsi_shipto_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.hsi_shipto_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsub_EPS_Details.line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Eps_Code"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="Supplier_Description"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1550
    Bottom =945
    Left =-1
    Top =-1
    Right =1481
    Bottom =463
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =60
        Top =71
        Right =240
        Bottom =415
        Top =0
        Name ="qsub_EPS_Details"
        Name =""
    End
    Begin
        Left =409
        Top =56
        Right =553
        Bottom =200
        Top =0
        Name ="comm_group"
        Name =""
    End
End
