VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} IndexSheetExtensionForm 
   Caption         =   "edit custom values for index sheet"
   ClientHeight    =   3420
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6555
   OleObjectBlob   =   "IndexSheetExtensionForm.frx":0000
   StartUpPosition =   1  'Fenstermitte
End
Attribute VB_Name = "IndexSheetExtensionForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub btnOk_Click()
    Call saveSettings
    Me.Hide
End Sub

Private Sub CommandButton1_Click()
    Me.Hide
End Sub

Private Sub UserForm_Activate()
    txtSumTitel.Text = getIndexSheetName()
    txtProperties.Text = Join(getIndexCustomProperties(), ";")
    txtSummaryColumns.Text = Join(getIndexColumns(), ";")
    txtWorkSheetCreatedDate.Text = getWorksheetCreatedDatePropName()
End Sub

Private Sub saveSettings()
    
    'save "global"-properties in ThisWorkbook.Worksheets(1)
    ' -> ThisWorkbook is where the code is saved (xlam-file)
    ' -> even a xlam file has at least one sheet
    ' -> here it's named "IndexConfig"
    setProperty ThisWorkbook.Worksheets(1), "IndexWorksheetName", txtSumTitel.Text
    setProperty ThisWorkbook.Worksheets(1), "IndexCustomProperties", txtProperties.Text
    setProperty ThisWorkbook.Worksheets(1), "IndexColumns", txtSummaryColumns.Text
    setProperty ThisWorkbook.Worksheets(1), "WorksheetCreatedDatePropName", txtWorkSheetCreatedDate.Text
        
    On Error Resume Next
    Application.DisplayAlerts = False
    ThisWorkbook.Save
    Application.DisplayAlerts = True
    On Error GoTo 0
End Sub

Private Sub UserForm_Terminate()
    ' Call saveSettings
End Sub