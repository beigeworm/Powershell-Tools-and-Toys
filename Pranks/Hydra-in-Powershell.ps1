<#========================== Hydra Prank in Powershell ==============================

SYNOPSIS
Recreating the classic Hydra pranks from early windows systems in powershell.
(every time the message popup is closed by the user, 2 more windows will appear!)

USAGE
Run the script for endless joy ;)

#>

Add-Type -AssemblyName System.Windows.Forms

function Create-Form {
    $form = New-Object Windows.Forms.Form
    $form.Text = "  __--** YOU HAVE BEEN INFECTED BY HYDRA **--__ "
    $form.Font = 'Microsoft Sans Serif,12,style=Bold'
    $form.Size = New-Object Drawing.Size(300, 170)
    $form.StartPosition = 'Manual'  # Set StartPosition to Manual
    $form.BackColor = [System.Drawing.Color]::Black
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
    $form.ControlBox = $false
    $form.Font = 'Microsoft Sans Serif,12,style=bold'
    $form.ForeColor = "#FF0000"

    $Text = New-Object Windows.Forms.Label
    $Text.Text = "Cut The Head Off The Snake..`n`n    ..Two More Will Appear"
    $Text.Font = 'Microsoft Sans Serif,14'
    $Text.AutoSize = $true
    $Text.Location = New-Object System.Drawing.Point(15, 20)

    $Close = New-Object Windows.Forms.Button
    $Close.Text = "Close?"
    $Close.Width = 120
    $Close.Height = 35
    $Close.BackColor = [System.Drawing.Color]::White
    $Close.ForeColor = [System.Drawing.Color]::Black
    $Close.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $Close.Location = New-Object System.Drawing.Point(85, 100)
    $Close.Font = 'Microsoft Sans Serif,12,style=Bold'

    $form.Controls.AddRange(@($Text, $Close))
    return $form
}

while ($true) {
    $form = Create-Form
    $form.StartPosition = 'Manual'
    $form.Location = New-Object System.Drawing.Point((Get-Random -Minimum 0 -Maximum 1000), (Get-Random -Minimum 0 -Maximum 1000))
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $form2 = Create-Form
        $form2.StartPosition = 'Manual'
        $form2.Location = New-Object System.Drawing.Point((Get-Random -Minimum 0 -Maximum 1000), (Get-Random -Minimum 0 -Maximum 1000))
        $form2.Show()
    }
    $random = (Get-Random -Minimum 0 -Maximum 2)
    Sleep $random
}
