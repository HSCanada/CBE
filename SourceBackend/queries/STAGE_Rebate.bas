Operation =1
Option =0
Begin InputTables
    Name ="STAGE_Rebate2"
End
Begin OutputColumns
    Expression ="STAGE_Rebate2.salesperson_key_id"
    Expression ="STAGE_Rebate2.rebate_monthly_amt"
    Expression ="STAGE_Rebate2.merch_teeth_amt"
    Expression ="STAGE_Rebate2.merch_amt"
    Expression ="STAGE_Rebate2.percent_rt"
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
        dbText "Name" ="STAGE_Rebate2.percent_rt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_Rebate2.merch_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_Rebate2.merch_teeth_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_Rebate2.rebate_monthly_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="STAGE_Rebate2.salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =40
    Right =1541
    Bottom =817
    Left =-1
    Top =-1
    Right =1517
    Bottom =498
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =87
        Top =82
        Right =363
        Bottom =378
        Top =0
        Name ="STAGE_Rebate2"
        Name =""
    End
End
