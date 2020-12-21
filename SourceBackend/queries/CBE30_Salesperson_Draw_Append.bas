Operation =3
Name ="comm_transaction_stage"
Option =0
Where ="(((comm_batch_control.fiscal_yearmo_num)>\"0\"))"
Begin InputTables
    Name ="comm_batch_control"
    Name ="comm_salesperson_master"
End
Begin OutputColumns
    Name ="fiscal_yearmo_num"
    Expression ="comm_batch_control.fiscal_yearmo_num"
    Alias ="division_cd"
    Name ="division_cd"
    Expression ="\"\""
    Alias ="salesperson_cd"
    Name ="salesperson_cd"
    Expression ="comm_salesperson_master.master_salesperson_cd"
    Alias ="source_cd"
    Name ="source_cd"
    Expression ="\"PAYROLL\""
    Alias ="transaction_dt"
    Name ="transaction_dt"
    Expression ="comm_batch_control.fiscal_begin_dt"
    Alias ="transaction_amt"
    Name ="transaction_amt"
    Expression ="0"
    Alias ="comm_cd"
    Name ="comm_cd"
    Expression ="\"Z\""
    Alias ="doc_key_id"
    Name ="doc_key_id"
    Expression ="comm_batch_control.fiscal_yearmo_num"
    Alias ="line_id"
    Name ="line_id"
    Expression ="1"
    Alias ="customer_nm"
    Name ="customer_nm"
    Expression ="\"n/a\""
    Alias ="shipped_qty"
    Name ="shipped_qty"
    Expression ="1"
    Alias ="transaction_txt"
    Name ="transaction_txt"
    Expression ="\"SALD30\""
    Alias ="cost_ext_amt"
    Name ="cost_ext_amt"
    Expression ="0"
    Alias ="comm_group_cd"
    Name ="comm_group_cd"
    Expression ="\"SALD30\""
    Name ="comm_amt"
    Expression ="comm_salesperson_master.salary_draw_amt"
    Name ="salesperson_key_id"
    Expression ="comm_salesperson_master.salesperson_key_id"
    Alias ="status_cd"
    Name ="status_cd"
    Expression ="20"
End
Begin Joins
    LeftTable ="comm_salesperson_master"
    RightTable ="comm_batch_control"
    Expression ="comm_salesperson_master.FiscalMonth = comm_batch_control.FiscalMonth"
    Flag =1
End
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="0"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "UseTransaction" ="-1"
dbText "Description" ="Payroll import to stage"
Begin
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_key_id"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.salesperson_nm"
        dbInteger "ColumnWidth" ="3000"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="division_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="salesperson_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="source_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_dt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="doc_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="line_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="customer_nm"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="shipped_qty"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="transaction_txt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="cost_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="status_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master_stage.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_batch_control.fiscal_yearmo_num"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salary_draw_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="comm_salesperson_master.salesperson_key_id"
        dbInteger "ColumnWidth" ="2505"
        dbBoolean "ColumnHidden" ="0"
        dbLong "AggregateType" ="-1"
    End
End
Begin
    State =2
    Left =-8
    Top =-31
    Right =1414
    Bottom =945
    Left =-1
    Top =-1
    Right =1390
    Bottom =319
    Left =0
    Top =0
    ColumnsShown =651
    Begin
        Left =664
        Top =29
        Right =925
        Bottom =196
        Top =0
        Name ="comm_batch_control"
        Name =""
    End
    Begin
        Left =388
        Top =109
        Right =532
        Bottom =253
        Top =0
        Name ="comm_salesperson_master"
        Name =""
    End
End
