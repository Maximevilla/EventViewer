[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")  
[void] [System.Windows.Forms.Application]::EnableVisualStyles() 
 
function Application 
{ 
 get-eventlog -LogName "Application" | Out-GridView 
} 


function OnClick($Sender){ 
	 get-eventlog -LogName "$Sender" | Out-GridView
}



#--------Form
 
$Form = New-Object system.Windows.Forms.Form 
$Form.Size = New-Object System.Drawing.Size(407, 390) 
#You can use the below method as well 
#$Form.Width = 400 
#$Form.Height = 200 
$form.MaximizeBox = $true 
$Form.StartPosition = "CenterScreen" 
$Form.FormBorderStyle = 'Fixed3D' 
$Form.Text = "Event Viewer" 
#$form.topmost = $true


#-----ComboBox

#$EventsName = @(1,2,3)
$EventsName = (get-eventlog  -List)
$EventsName =$EventsName.log
$comboBox1 = New-Object System.Windows.Forms.ComboBox
$comboBox1.Location = New-Object System.Drawing.Point(25, 55)
$comboBox1.Size = New-Object System.Drawing.Size(350, 310)
foreach($EventName in $EventsName)
{
  $comboBox1.Items.add($EventName)
}
$Form.Controls.Add($comboBox1)

#-----------Button Validate Choice

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(25, 20)
$Button.Size = New-Object System.Drawing.Size(98, 23)
$Button.Text = "View"
$Button.add_Click({OnClick($comboBox1.SelectedItem.ToString())})
$Form.Controls.Add($Button)


#$formIcon = New-Object system.drawing.icon ("$env:USERPROFILE\desktop\Blog\v.ico") 
#$form.Icon = $formicon 
 
####$Okbutton = New-Object System.Windows.Forms.Button 
#$Okbutton.Location = New-Object System.Drawing.Size(10,10) 
#$Okbutton.Size = New-Object System.Drawing.Size(120,30) 
#$Okbutton.Text = "Application" 
#$Okbutton.Add_Click({Application}) 
#$Form.Controls.Add($Okbutton) 
 
$Form.ShowDialog() 