Operation =1
Option =0
Where ="(((comm_salesperson_master.comm_plan_id) Like \"fsc*\" And (comm_salesperson_mas"
    "ter.comm_plan_id)<>\"FSCDPZZ\"))"
Begin InputTables
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Expression ="comm_salesperson_master.salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_nm"
    Expression ="comm_salesperson_master.comm_plan_id"
    Expression ="comm_salesperson_master.branch_cd"
    Expression ="comm_salesperson_master.employee_num"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Expression ="comm_salesperson_master.territory_start_dt"
    Expression ="comm_salesperson_master.note_txt"
    Expression ="comm_salesperson_master.select_ind"
    Expression ="comm_salesperson_master.creation_dt"
    Expression ="comm_salesperson_master.salary_draw_amt"
    Expression ="comm_salesperson_master.deficit_amt"
    Expression ="comm_salesperson_master.FiscalMonth"
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="-1"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
dbMemo "OrderBy" ="[CBE28_Salesperson_Review].[territory_start_dt] DESC, [CBE28_Salesperson_Review]"
    ".[branch_cd], [CBE28_Salesperson_Review].[employee_num], [CBE28_Salesperson_Revi"
    "ew].[salesperson_nm], [CBE28_Salesperson_Review].[salesperson_key_id], [CBE28_Sa"
    "lesperson_Review].[master_salesperson_cd], [CBE28_Salesperson_Review].[select_in"
    "d] DESC, [CBE28_Salesperson_Review].[comm_plan_id]"
dbMemo "Filter" ="([CBE28_Salesperson_Review].[branch_cd]=\"TORNT \")"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_nm"
        dbInteger "ColumnWidth" ="3990"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="3075"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.comm_plan_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.employee_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.master_salesperson_cd"
        dbLong "AggregateType" ="-1"
        dbInteger "ColumnWidth" ="2595"
        dbBoolean "ColumnHidden" ="0"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.territory_start_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.branch_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.note_txt"
        dbInteger "ColumnWidth" ="5535"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.select_ind"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.creation_dt"
        dbInteger "ColumnWidth" ="2355"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.deficit_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salary_draw_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.FiscalMonth"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1548
    Bottom =943
    Left =-1
    Top =-1
    Right =1568
    Bottom =283
    Left =0
    Top =0
    ColumnsShown =539
    Begin
        Left =38
        Top =6
        Right =439
        Bottom =263
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
