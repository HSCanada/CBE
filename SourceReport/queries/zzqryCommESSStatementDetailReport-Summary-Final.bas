dbMemo "SQL" ="SELECT GetCurrentFSC() AS salesperson_key_id, [zqsubCommESSStatementDetailReport"
    "Summary].comm_group_cd, [zqsubCommESSStatementDetailReportSummary].comm_group_de"
    "sc, [zqsubCommESSStatementDetailReportSummary].report_sort_id, CDbl(nz([pre_tota"
    "l_transaction_amt],0)) AS total_transaction_amt, CDbl(nz([pre_total_gp_ext_amt],"
    "0)) AS total_gp_ext_amt, CDbl(nz([pre_total_comm_amt],0)) AS total_comm_amt\015\012"
    "FROM zqsubCommESSStatementDetailReportSummary LEFT JOIN [zzqryCommESSStatementDe"
    "tailReport-Summary] ON [zqsubCommESSStatementDetailReportSummary].comm_group_cd="
    "[zzqryCommESSStatementDetailReport-Summary].item_comm_group_cd\015\012ORDER BY ["
    "zqsubCommESSStatementDetailReportSummary].report_sort_id;\015\012"
dbMemo "Connect" =""
dbBoolean "ReturnsRecords" ="-1"
dbInteger "ODBCTimeout" ="60"
dbByte "RecordsetType" ="2"
dbBoolean "OrderByOn" ="0"
dbByte "Orientation" ="0"
dbByte "DefaultView" ="2"
dbBoolean "FilterOnLoad" ="0"
dbBoolean "OrderByOnLoad" ="-1"
dbBoolean "TotalsRow" ="0"
Begin
    Begin
        dbText "Name" ="salesperson_key_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommESSStatementDetailReportSummary.comm_group_cd"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommESSStatementDetailReportSummary.comm_group_desc"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="qsubCommESSStatementDetailReportSummary.report_sort_id"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_transaction_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_gp_ext_amt"
        dbLong "AggregateType" ="-1"
    End
    Begin
        dbText "Name" ="total_comm_amt"
        dbLong "AggregateType" ="-1"
    End
End
