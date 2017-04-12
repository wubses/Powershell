Add-Type -AssemblyName System.Windows.Forms

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Remote Service Control"
$Form.TopMost = $true
$Form.Width = 300
$Form.Height = 250

$StopButton = New-Object system.windows.Forms.Button
$StopButton.BackColor = "#ff0000"
$StopButton.Text = "Stop"
$StopButton.Width = 60
$StopButton.Height = 30
$StopButton.location = new-object system.drawing.point(25,100)
$StopButton.Font = "Microsoft Sans Serif,10"
$Form.AcceptButton=$StopButton
$Form.controls.Add($StopButton)

$StartButton = New-Object system.windows.Forms.Button
$StartButton.BackColor = "#00ff00"
$StartButton.Text = "Start"
$StartButton.Width = 60
$StartButton.Height = 30
$StartButton.location = new-object system.drawing.point(200,100)
$StartButton.Font = "Microsoft Sans Serif,10"
$Form.AcceptButton=$StartButton
$Form.controls.Add($StartButton)

$RestartButton = New-Object system.windows.Forms.Button
$RestartButton.BackColor = "#0000ff"
$RestartButton.Text = "Restart"
$RestartButton.ForeColor = "#ffffff"
$RestartButton.Width = 60
$RestartButton.Height = 30
$RestartButton.location = new-object system.drawing.point(112,100)
$RestartButton.Font = "Microsoft Sans Serif,10"
$Form.AcceptButton=$RestartButton
$Form.controls.Add($RestartButton)

$CancelButton = New-Object system.windows.Forms.Button
$CancelButton.BackColor = "#ffffff"
$CancelButton.Text = "Cancel"
$CancelButton.ForeColor = "#000000"
$CancelButton.Width = 60
$CancelButton.Height = 30
$CancelButton.location = new-object system.drawing.point(112,150)
$CancelButton.Font = "Microsoft Sans Serif,10"
$Form.AcceptButton=$CancelButton
$Form.controls.Add($CancelButton)

$ServerBox = New-Object system.windows.Forms.TextBox
$ServerBox.Width = 153
$ServerBox.Height = 20
$ServerBox.location = new-object system.drawing.point(90,15)
$ServerBox.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($ServerBox)

$userBox = New-Object system.windows.Forms.TextBox
$userBox.Width = 153
$userBox.Height = 20
$userBox.location = new-object system.drawing.point(90,40)
$userBox.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($userBox)

$ServiceBox = New-Object system.windows.Forms.TextBox
$ServiceBox.Width = 153
$ServiceBox.Height = 20
$ServiceBox.location = new-object system.drawing.point(90,65)
$ServiceBox.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($ServiceBox)

$UserNameLabel = New-Object system.windows.Forms.Label
$UserNameLabel.Text = "Username"
$UserNameLabel.AutoSize = $true
$UserNameLabel.Width = 25
$UserNameLabel.Height = 10
$UserNameLabel.location = new-object system.drawing.point(25,40)
$UserNameLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($UserNameLabel)

$ServiceLabel = New-Object system.windows.Forms.Label
$ServiceLabel.Text = "Service"
$ServiceLabel.AutoSize = $true
$ServiceLabel.Width = 25
$ServiceLabel.Height = 10
$ServiceLabel.location = new-object system.drawing.point(25,65)
$ServiceLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($ServiceLabel)

$ServerLabel = New-Object system.windows.Forms.Label
$ServerLabel.Text = "Server"
$ServerLabel.AutoSize = $true
$ServerLabel.Width = 25
$ServerLabel.Height = 10
$ServerLabel.location = new-object system.drawing.point(25,15)
$ServerLabel.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($ServerLabel)

$StartButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$StopButton.DialogResult = [System.Windows.Forms.DialogResult]::Yes
$RestartButton.DialogResult = [System.Windows.Forms.DialogResult]::No
$CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel

#[void]$Form.ShowDialog()

$result = $Form.ShowDialog()

while($true){
    if ($result -eq [System.Windows.Forms.DialogResult]::OK){
        
        invoke-command –ComputerName $ServerBox.Text –ScriptBlock { Start-Service $ServiceBox.Text } –Credential $userBox.Text

        Break
    }
    if ($result -eq [System.Windows.Forms.DialogResult]::Yes){

        invoke-command –ComputerName $ServerBox.Text –ScriptBlock { Stop-Service $ServiceBox.Text } –Credential $userBox.Text

        Break
    }
    if ($result -eq [System.Windows.Forms.DialogResult]::No){

        invoke-command –ComputerName $ServerBox.Text –ScriptBlock { Restart-Service $ServiceBox.Text } –Credential $userBox.Text

        Break
    }
    if ($result -eq [System.Windows.Forms.DialogResult]::Cancel){

        $Form.Dispose()
        Break
    }
}

$Form.Dispose()
