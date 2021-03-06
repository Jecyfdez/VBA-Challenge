Sub Stock_Challenge()

    For Each ws In Worksheets
    
    'Create Columns for the desired outcomes
    ws.Range("I1").Value = "TICKER"
    ws.Range("J1").Value = "YRLY CHANGE"
    ws.Range("K1").Value = "% CHANGE"
    ws.Range("L1").Value = "TOTAL VOL"
    
    'Create a Variable for Ticker Symbols
    Dim Tick_Symbol As String
    
    'Create a Table for the desired outcomes
    Dim Table_Row As Integer
    Table_Row = 2
    
    'Define Opening Total
    Dim Opening As Double
    Opening = 0
    
    'Define Closing Total
    Dim Closing As Double
    Closing = 0
    
    'Define Volume Total
    Dim Volume As Double
    Volume = 0
    
    'Define Yearly Change
    Dim Yr_Change As Double
    
    'Define Percent Change
    Dim Percent_Changed As Double
    
    'Determine Last Row
    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    
        'Create a loop to find all Ticker Symbols
        For i = 2 To LastRow
               
            'Create an IF state to find when a new ticker is presented
            If ws.Cells(i, 1).Value <> ws.Cells(i + 1, 1).Value Then
                
                'Create the new symbol equal to the variable
                Tick_Symbol = ws.Cells(i, 1).Value
                
                'Add Ticker Symbol to the Table
                ws.Cells(Table_Row, 9).Value = Tick_Symbol
                
                'Add Closing & Opening Values
                Opening = Opening + ws.Cells(i, 3).Value
                Closing = Closing + ws.Cells(i, 6).Value
                
                'Add Yearly Changed to the Table
                Yr_Change = (Closing - Opening)
                ws.Cells(Table_Row, 10).Value = Yr_Change
                       
                'How to calculate percent changed
                If Opening = 0 Then
                    Percent_Changed = 0
                Else
                    Percent_Changed = Yr_Change / Opening
                End If
                
                'Add Percent Changed to the Table
                ws.Cells(Table_Row, 11) = Percent_Changed
                
                'Sum Volume
                Volume = Volume + ws.Cells(i, 7).Value
                'Add Total Volume to the Table
                ws.Cells(Table_Row, 12) = Volume
                
                'Go to the next Row for the next symbol
                Table_Row = Table_Row + 1
                
                'Clear opening & closing & Volume count
                Opening = 0
                Closing = 0
                Volume = 0
                
            Else
                'When the same ticker add up Opening & Closing & Value
                Opening = Opening + ws.Cells(i, 3).Value
                Closing = Closing + ws.Cells(i, 6).Value
                Volume = Volume + ws.Cells(i, 7).Value
                
            End If
        
        Next i
        
        'Create a new loop to target Table Yrly Change
        For i = 2 To Table_Row
            
            'Conditional Formatting that will highlight positive change in green
            If ws.Cells(i, 10).Value > 0 Then
            ws.Cells(i, 10).Interior.ColorIndex = 4
            
            'Conditional Formatting that will highlight positive change in red
            ElseIf ws.Cells(i, 10).Value < 0 Then
            ws.Cells(i, 10).Interior.ColorIndex = 3
            
            End If
        
        Next i
    
    'Change the Formatting of column K to be a percent
    ws.Range("K:K").NumberFormat = "0.00%"
    
    'Create second table
    ws.Range("O1") = "TICKER"
    ws.Range("P1") = "VALUE"
    
    'Change formatting for second table
    ws.Range("N2", "N3").NumberFormat = "0.00%"
    
    'Assigning the values for the greatest increase, decrease and total volume
    ws.Cells(2, 14).Value = "Greatest % increase"
    ws.Cells(3, 14).Value = "Greatest % decrease"
    ws.Cells(4, 14).Value = "Greatest Total Vol"
    
    'Define variables used in second table
    Dim Max As Double
    Dim Min As Double
    Dim Greatest_Vol As Double
    Percent_Range = ws.Range("K2:K" & Table_Row).Value
    Volume_Range = ws.Range("L2:L" & Table_Row).Value
            
        'find Max, Min and greatest volume using functions
        Max = Application.WorksheetFunction.Max(Percent_Range)
        Min = Application.WorksheetFunction.Min(Percent_Range)
        Greatest_Vol = Application.WorksheetFunction.Max(Volume_Range)
            
           'Create a loop to find the Ticker symbol to match the MAX, MIN and TOT VOL values
            For i = 2 To Table_Row
            
                If ws.Cells(i, 11).Value = Max Then
                ws.Cells(2, 16).Value = Max
                ws.Cells(2, 16).NumberFormat = "0.00%"
                ws.Cells(2, 15).Value = ws.Cells(i, 9).Value
                
                ElseIf ws.Cells(i, 11).Value = Min Then
                ws.Cells(3, 16).Value = Min
                ws.Cells(3, 16).NumberFormat = "0.00%"
                ws.Cells(3, 15).Value = ws.Cells(i, 9).Value
                
                ElseIf ws.Cells(i, 12).Value = Greatest_Vol Then
                ws.Cells(4, 16).Value = Greatest_Vol
                ws.Cells(4, 15).Value = ws.Cells(i, 9).Value
                        
               End If
                
            Next i
        
        Next ws

End Sub
