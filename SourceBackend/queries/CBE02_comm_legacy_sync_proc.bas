dbMemo "SQL" ="EXEC comm_legacy_sync_proc @bDebug=0"
dbMemo "Connect" ="ODBC;DSN=DEV_CommBE;Description=DEV_CommBE;Trusted_Connection=Yes;DATABASE=DEV_C"
    "ommBE;Network=DBMSSOCN"
dbBoolean "ReturnsRecords" ="0"
dbInteger "ODBCTimeout" ="60"
dbBoolean "LogMessages" ="0"
dbText "Description" ="sync commission groups from new to legacy"
dbByte "Orientation" ="0"
Begin
End
