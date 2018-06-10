VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} PropertyExtensionForm 
   Caption         =   "Edit custom properties"
   ClientHeight    =   3420
   ClientLeft      =   120
   ClientTop       =   465
   ClientWidth     =   6555
   OleObjectBlob   =   "PropertyExtensionForm.frx":0000
   StartUpPosition =   1  'Fenstermitte
End
Attribute VB_Name = "PropertyExtensionForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

'reference to opend sheet
Private ws As Worksheet
'old value of combobox
Private oldValue As String

'sets the sheet to edit/add properties
Public Sub setSheet(actSheet As Worksheet)
    Set ws = actSheet
End Sub

Private Sub btnCancel_Click()
    Me.Hide
End Sub

Private Sub btnConfig_Click()
    Call cbProperty_Change
    Me.Hide
    IndexSheetExtensionForm.Show
End Sub

'handles click on btnOK
Private Sub btnOk_Click()
    setProperty ws, Me.cbProperty.Text, Me.txtValue.Text
    Me.Hide
    Call generateIndexWorksheet
End Sub

'handles change of selected property
Private Sub cbProperty_Change()
      If oldValue <> "" Then setProperty ws, oldValue, Me.txtValue.Text
      
      Me.txtValue.Text = getProperty(ws, Me.cbProperty.Text)
      oldValue = Me.cbProperty.Text
End Sub

'is property already in listbox?
Private Function isInList(lst As ComboBox, val As String) As Boolean
Dim treffer As Boolean
treffer = False

Dim i As Integer
i = 0

For i = 0 To lst.ListCount - 1
    If LCase(lst.List(i)) = LCase(val) Then treffer = True
Next

isInList = treffer
End Function

'handles shown event
Private Sub UserForm_Activate()
    Dim xx  As CustomProperty
    Dim tmp As Variant
    
    oldValue = ""
    If ws Is Nothing Then Set ws = Application.ActiveSheet
    If ws Is Nothing Then Exit Sub
    
    Me.cbProperty.Clear
    Me.txtValue.Text = ""
    
    'add existising properties to combobox.list
    For Each xx In ws.CustomProperties
        Me.cbProperty.AddItem xx.Name
    Next xx
    
    'add default properties to combobox.list (if they are not already set)
    For Each tmp In getIndexCustomProperties()
        If isInList(Me.cbProperty, CStr(tmp)) = False Then Me.cbProperty.AddItem CStr(tmp)
    Next tmp
    
    'default property is first one defined
    Me.cbProperty.Text = CStr(getIndexCustomProperties(0))
    
    'caption of form (sheet/workbook in it)
    Me.Caption = "Edit custom properties of [" & ws.Parent.Name & "].[" & ws.Name & "]"
    Me.txtValue.SetFocus
    
End Sub
