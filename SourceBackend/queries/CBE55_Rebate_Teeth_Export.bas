﻿Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"FSC*\"))"
Begin InputTables
    Name ="comm_configure"
    Name ="STAGE_Rebate"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_configure.current_fiscal_yearmo_num"
    Alias ="comm_grp"
    Expression ="\"REBTEE\""
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Alias ="vend"
    Expression ="\"REBATE\""
    Alias ="chqno"
    Expression ="\"NA\""
    Alias ="line_no"
    Expression ="0"
    Alias ="trans_dt"
    Expression ="Now()"
    Alias ="details"
    Expression ="\"REBATE TEETH\""
    Alias ="trans_amt"
    Expression ="-1*[rebate_monthly_amt]*(1-[percent_rt])"
    Alias ="GP"
    Expression ="[trans_amt]"
    Alias ="comm_amt"
    Expression ="0"
End
Begin Joins
    LeftTable ="STAGE_Rebate"
    RightTable ="comm_salesperson_master"
    Expression ="STAGE_Rebate.salesperson_key_id = comm_salesperson_master.salesperson_key_id"
    Flag =1
End
Begin OrderBy
    Expression ="comm_salesperson_master.salesperson_key_id"
    Flag =0
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
        dbText "Name" ="details"
        dbInteger "ColumnWidth" ="2445"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_grp"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="vend"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="chqno"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="line_no"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="trans_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="trans_amt"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2235"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_configure.current_fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="GP"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2235"
        dbBoolean "ColumnHidden" ="0"
    End
End
Begin
    State =0
    Left =-210
    Top =21
    Right =954
    Bottom =897
    Left =-1
    Top =-1
    Right =1132
    Bottom =158
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =306
        Top =6
        Right =528
        Bottom =128
        Top =0
        Name ="comm_configure"
        Name =""
    End
    Begin
        Left =48
        Top =12
        Right =192
        Bottom =156
        Top =0
        Name ="STAGE_Rebate"
        Name =""
    End
    Begin
        Left =492
        Top =-6
        Right =657
        Bottom =236
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
