Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"FSC*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"FSCGPZZ\")) OR (((comm_salesperson_master.comm_plan_id) Lik"
    "e \"ESS*\" And (comm_salesperson_master.comm_plan_id)<>\"ESSGPZZ\")) OR (((comm_"
    "salesperson_master.comm_plan_id) Like \"CCS*\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.select_ind"
    Expression ="comm_salesperson_master.comm_plan_id"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbBoolean "UseTransaction" ="-1"
dbBoolean "FailOnError" ="0"
dbByte "Orientation" ="0"
dbByte "RecordsetType" ="0"
dbMemo "OrderBy" ="[CBE80_SetExportFlag_manual].[comm_plan_id]"
dbBoolean "OrderByOn" ="-1"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3615"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.select_ind"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =0
    Left =0
    Top =0
    Right =1560
    Bottom =797
    Left =-1
    Top =-1
    Right =1544
    Bottom =577
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =48
        Top =12
        Right =545
        Bottom =371
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
