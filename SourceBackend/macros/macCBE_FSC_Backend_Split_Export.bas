Version =196611
ColumnsShown =0
Begin
    Action ="TransferSpreadsheet"
    Argument ="1"
    Argument ="10"
    Argument ="FSC_Split_TedKDesign"
    Argument ="S:\\BR\\CommBE\\Publish\\FSC_Backend_Split YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Action ="TransferSpreadsheet"
    Argument ="1"
    Argument ="10"
    Argument ="FSC_Split_Montreal"
    Argument ="S:\\BR\\CommBE\\Publish\\FSC_Backend_Split YYYYMM.xlsx"
    Argument ="-1"
End
Begin
    Action ="MsgBox"
    Argument ="FSC Backend Split exported to \"S:\\BR\\CommBE\\Publish\\ FSC_Backend_Split YYYY"
        "MM.xlsx\""
    Argument ="-1"
    Argument ="0"
End
Begin
    Comment ="_AXL:<?xml version=\"1.0\" encoding=\"UTF-16\" standalone=\"no\"?>\015\012<UserI"
        "nterfaceMacro MinimumClientDesignVersion=\"14.0.0000.0000\" xmlns=\"http://schem"
        "as.microsoft.com/office/accessservices/2009/11/application\"><Statements><Commen"
        "t></Comment><Action Name=\"Imp"
End
Begin
    Comment ="_AXL:ortExportSpreadsheet\"><Argument Name=\"TransferType\">Export</Argument><Ar"
        "gument Name=\"TableName\">FSC_Split_TedKDesign</Argument><Argument Name=\"FileNa"
        "me\">S:\\BR\\CommBE\\Publish\\FSC_Backend_Split YYYYMM.xlsx</Argument><Argument "
        "Name=\"HasFieldNames\">Yes"
End
Begin
    Comment ="_AXL:</Argument></Action><Action Name=\"ImportExportSpreadsheet\"><Argument Name"
        "=\"TransferType\">Export</Argument><Argument Name=\"TableName\">FSC_Split_Montre"
        "al</Argument><Argument Name=\"FileName\">S:\\BR\\CommBE\\Publish\\FSC_Backend_Sp"
        "lit YYYYMM.xlsx</Argument"
End
Begin
    Comment ="_AXL:><Argument Name=\"HasFieldNames\">Yes</Argument></Action><Action Name=\"Mes"
        "sageBox\"><Argument Name=\"Message\">FSC Backend Split exported to \"S:\\BR\\Com"
        "mBE\\Publish\\ FSC_Backend_Split YYYYMM.xlsx\"</Argument></Action></Statements><"
        "/UserInterfaceMacro>"
End
