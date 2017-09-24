Version =196611
ColumnsShown =0
Begin
    Action ="TransferSpreadsheet"
    Comment ="ESS_Backend"
    Argument ="1"
    Argument ="10"
    Argument ="ESS_Backend"
    Argument ="S:\\Business Reporting\\CommBE\\Export\\ESS_Backend YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Comment ="ESS_Backend_Monthly"
End
Begin
    Action ="TransferSpreadsheet"
    Comment ="ESS_Backend_FreeGoods"
    Argument ="1"
    Argument ="10"
    Argument ="ESS_Backend_FreeGoods"
    Argument ="S:\\Business Reporting\\CommBE\\Export\\ESS_Backend YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Action ="TransferSpreadsheet"
    Argument ="1"
    Argument ="10"
    Argument ="CCS_Backend"
    Argument ="S:\\Business Reporting\\CommBE\\Export\\CCS_Backend YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Action ="MsgBox"
    Argument ="ESS backend exported to \"ESS_Backend YYYYMM.xlsx\""
    Argument ="-1"
    Argument ="0"
End
Begin
    Comment ="_AXL:<?xml version=\"1.0\" encoding=\"UTF-16\" standalone=\"no\"?>\015\012<UserI"
        "nterfaceMacro MinimumClientDesignVersion=\"14.0.0000.0000\" xmlns=\"http://schem"
        "as.microsoft.com/office/accessservices/2009/11/application\"><Statements><Commen"
        "t>ESS_Backend</Comment><Actio"
End
Begin
    Comment ="_AXL:n Name=\"ImportExportSpreadsheet\"><Argument Name=\"TransferType\">Export</"
        "Argument><Argument Name=\"TableName\">ESS_Backend</Argument><Argument Name=\"Fil"
        "eName\">S:\\Business Reporting\\CommBE\\Export\\ESS_Backend YYYYMM.xlsx</Argumen"
        "t><Argument Name=\"HasFiel"
End
Begin
    Comment ="_AXL:dNames\">Yes</Argument></Action><Comment>ESS_Backend_Monthly</Comment><Comm"
        "ent></Comment><Comment>ESS_Backend_FreeGoods</Comment><Action Name=\"ImportExpor"
        "tSpreadsheet\"><Argument Name=\"TransferType\">Export</Argument><Argument Name=\""
        "TableName\">ESS_Bac"
End
Begin
    Comment ="_AXL:kend_FreeGoods</Argument><Argument Name=\"FileName\">S:\\Business Reporting"
        "\\CommBE\\Export\\ESS_Backend YYYYMM.xlsx</Argument><Argument Name=\"HasFieldNam"
        "es\">Yes</Argument></Action><Action Name=\"ImportExportSpreadsheet\"><Argument N"
        "ame=\"TransferType\">Expo"
End
Begin
    Comment ="_AXL:rt</Argument><Argument Name=\"TableName\">CCS_Backend</Argument><Argument N"
        "ame=\"FileName\">S:\\Business Reporting\\CommBE\\Export\\CCS_Backend YYYYMM.xlsx"
        "</Argument><Argument Name=\"HasFieldNames\">Yes</Argument></Action><Comment></Co"
        "mment><Action Name=\"Mes"
End
Begin
    Comment ="_AXL:sageBox\"><Argument Name=\"Message\">ESS backend exported to \"ESS_Backend "
        "YYYYMM.xlsx\"</Argument></Action></Statements></UserInterfaceMacro>"
End
