Operation =1
Option =0
Where ="(((comm_summary.salesperson_key_id)=\"SParkESS\"))"
Begin InputTables
    Name ="comm_summary"
End
Begin OutputColumns
    Expression ="comm_summary.salesperson_key_id"
    Expression ="comm_summary.comm_group_cd"
    Expression ="comm_summary.sales_ytd_amt"
    Expression ="comm_summary.costs_ytd_amt"
    Expression ="comm_summary.comm_ytd_amt"
    Expression ="comm_summary.creation_dt"
    Expression ="comm_summary.audit_id"
    Expression ="comm_summary.gp_ytd_amt"
    Expression ="comm_summary.gp_ref_amt"
    Expression ="comm_summary.sales_prior_amt"
    Expression ="comm_summary.costs_prior_amt"
    Expression ="comm_summary.comm_prior_amt"
    Expression ="comm_summary.gp_prior_amt"
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
        dbText "Name" ="comm_summary.gp_ref_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_group_cd"
        dbInteger "ColumnWidth" ="1950"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_ytd_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.costs_ytd_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.sales_ytd_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.creation_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.audit_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.gp_ytd_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.sales_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.costs_prior_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_summary.comm_prior_amt"
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
        Left =70
        Top =32
        Right =593
        Bottom =303
        Top =0
        Name ="comm_summary"
        Name =""
    End
End
