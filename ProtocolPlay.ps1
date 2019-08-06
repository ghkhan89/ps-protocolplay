<#
	.Description :
		Enable/Disable TLS & SSL
	
	.How to Use :
		Just Run the script
		
	.Made By:
		Ghufran Khan
#>
Clear-Host
[void][System.Reflection.Assembly]::LoadWithPartialName('PresentationFramework');
$user = [Security.Principal.WindowsIdentity]::GetCurrent();
if((New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
{
$RegBckPath = "C:\Protocol.reg"

if((Test-path $RegBckPath) -eq $true)
{
    $msgBoxInput =  [System.Windows.MessageBox]::Show("Overwrite on the File $RegBckPath ? `r`n`r`n'Yes' to Overwrite.`r`n'No' to continue without a backup.`r`n'Cancel' to exit.",'Backup Registry','YesNoCancel','Error')
    switch($msgBoxInput)
    {
        'Yes' {Reg Export "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" $RegBckPath /y | out-null;[System.Windows.MessageBox]::Show("Registry Backed Up at Location $RegBckPath `r`nby overwritting the file !!!",'Backup Registry','OK','Information') | Out-null;}
        'No' {}
        'Cancel' {Exit;}
    }    
}
else{Reg Export "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols" $RegBckPath /y | out-null; "Protocols registry backup stored path : '" + $RegBckPath + "'";"";}

$SvrCDet = @()
$Sobj = New-Object PSObject -Property @{'SvrChg' = 0;'SvrCatch' = 0}
$SvrCDet += $Sobj

$CliCDet = @()
$Cobj = New-Object PSObject -Property @{'CliChg' = 0;'CliCatch' = 0}
$CliCDet += $Cobj

[void][System.Reflection.Assembly]::LoadWithPartialName('PresentationFramework')
if ($host.name -eq 'ConsoleHost')
{
[xml]$XAML = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Protocol Play" Height="270" Width="428" ResizeMode="NoResize" ToolTip="Protocol Play by Ghufran Khan">
    <Grid>
        <Border Background="GhostWhite" BorderBrush="Silver" BorderThickness="1" CornerRadius="8,8,3,3" HorizontalAlignment="Left" Height="184" VerticalAlignment="Top" Width="193" Margin="7,7,0,0"/>
        <StackPanel Name="SSvrMPUH" Margin="17,45,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrMPUH" Content="Multi-Protocol Unified Hello" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrPCT10" Margin="17,65,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrPCT10" Content="PCT 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrSSL20" Margin="17,85,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrSSL20" Content="SSL 2.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrSSL30" Margin="17,105,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrSSL30" Content="SSL 3.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrTLS10" Margin="17,125,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrTLS10" Content="TLS 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrTLS11" Margin="17,145,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrTLS11" Content="TLS 1.1" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrTLS12" Margin="17,165,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrTLS12" Content="TLS 1.2" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <Label Name="LblSvr" Content="Server Protocals" HorizontalAlignment="Left" Margin="19,18,0,0" VerticalAlignment="Top" Width="167" HorizontalContentAlignment="Center" Height="20" Padding="0" Background="GhostWhite" BorderBrush="Silver" BorderThickness="1"/>
        <Border Background="GhostWhite" BorderBrush="Silver" BorderThickness="1" CornerRadius="8,8,3,3" HorizontalAlignment="Left" Height="184" VerticalAlignment="Top" Width="193" Margin="210,7,0,0"/>
        <Label Name="LblCli" Content="Client Protocals" HorizontalAlignment="Left" Margin="222,18,0,0" VerticalAlignment="Top" Width="167" HorizontalContentAlignment="Center" Height="20" Padding="0" Background="GhostWhite" BorderBrush="Silver" BorderThickness="1"/>
        <StackPanel Name="CCliMPUH" Margin="222,45,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliMPUH" Content="Multi-Protocol Unified Hello" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliPCT10" Margin="222,65,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliPCT10" Content="PCT 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliSSL20" Margin="222,85,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliSSL20" Content="SSL 2.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliSSL30" Margin="222,105,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliSSL30" Content="SSL 3.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliTLS10" Margin="222,125,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliTLS10" Content="TLS 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliTLS11" Margin="222,145,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliTLS11" Content="TLS 1.1" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliTLS12" Margin="222,165,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliTLS12" Content="TLS 1.2" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <Button Name="BtnSvr" Content="Apply Server Side" HorizontalAlignment="Left" Height="25" Margin="7,198,0,0" VerticalAlignment="Top" Width="193"/>
        <Button Name="BtnCli" Content="Apply Client Side" HorizontalAlignment="Left" Height="25" Margin="210,198,0,0" VerticalAlignment="Top" Width="193"/>
    </Grid>
</Window>
'@
}
else
{
[xml]$XAML = @'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Protocol Play" Height="263" Width="418" ResizeMode="NoResize" ToolTip="Protocol Play by Ghufran Khan">
    <Grid>
        <Border Background="GhostWhite" BorderBrush="Silver" BorderThickness="1" CornerRadius="8,8,3,3" HorizontalAlignment="Left" Height="184" VerticalAlignment="Top" Width="193" Margin="7,7,0,0"/>
        <StackPanel Name="SSvrMPUH" Margin="17,45,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrMPUH" Content="Multi-Protocol Unified Hello" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrPCT10" Margin="17,65,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrPCT10" Content="PCT 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrSSL20" Margin="17,85,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrSSL20" Content="SSL 2.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrSSL30" Margin="17,105,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrSSL30" Content="SSL 3.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrTLS10" Margin="17,125,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrTLS10" Content="TLS 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrTLS11" Margin="17,145,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrTLS11" Content="TLS 1.1" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="SSvrTLS12" Margin="17,165,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="SvrTLS12" Content="TLS 1.2" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <Label Name="LblSvr" Content="Server Protocals" HorizontalAlignment="Left" Margin="19,18,0,0" VerticalAlignment="Top" Width="167" HorizontalContentAlignment="Center" Height="20" Padding="0" Background="GhostWhite" BorderBrush="Silver" BorderThickness="1"/>
        <Border Background="GhostWhite" BorderBrush="Silver" BorderThickness="1" CornerRadius="8,8,3,3" HorizontalAlignment="Left" Height="184" VerticalAlignment="Top" Width="193" Margin="210,7,0,0"/>
        <Label Name="LblCli" Content="Client Protocals" HorizontalAlignment="Left" Margin="222,18,0,0" VerticalAlignment="Top" Width="167" HorizontalContentAlignment="Center" Height="20" Padding="0" Background="GhostWhite" BorderBrush="Silver" BorderThickness="1"/>
        <StackPanel Name="CCliMPUH" Margin="222,45,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliMPUH" Content="Multi-Protocol Unified Hello" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliPCT10" Margin="222,65,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliPCT10" Content="PCT 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliSSL20" Margin="222,85,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliSSL20" Content="SSL 2.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliSSL30" Margin="222,105,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliSSL30" Content="SSL 3.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliTLS10" Margin="222,125,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliTLS10" Content="TLS 1.0" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliTLS11" Margin="222,145,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliTLS11" Content="TLS 1.1" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <StackPanel Name="CCliTLS12" Margin="222,165,0,0" HorizontalAlignment="Left" VerticalAlignment="Top" Height="15"><CheckBox Name="CliTLS12" Content="TLS 1.2" HorizontalAlignment="Left" VerticalAlignment="Top" Width="170"/></StackPanel>
        <Button Name="BtnSvr" Content="Apply Server Side" HorizontalAlignment="Left" Height="25" Margin="7,198,0,0" VerticalAlignment="Top" Width="193"/>
        <Button Name="BtnCli" Content="Apply Client Side" HorizontalAlignment="Left" Height="25" Margin="210,198,0,0" VerticalAlignment="Top" Width="193"/>
    </Grid>
</Window>
'@
}
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}
$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}

$APaths = @()

# Multi-Protocol Unified Hello
$objInfo = New-Object PSObject -Property @{'ID' = 0;'Protocol' = 'Multi-Protocol Unified Hello';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\Multi-Protocol Unified Hello';'Server' = 1;'Client' = 1;'CbSvr' = $SvrMPUH;'CbCli' = $CliMPUH;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrMPUH;'SCli' = $CCliMPUH}
$APaths += $objInfo
# PCT 1.0
$objInfo = New-Object PSObject -Property @{'ID' = 1;'Protocol' = 'PCT 1.0';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\PCT 1.0';'Server' = 1;'Client' = 1;'CbSvr' = $SvrPCT10;'CbCli' = $CliPCT10;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrPCT10;'SCli' = $CCliPCT10}
$APaths += $objInfo
# SSL 2.0
$objInfo = New-Object PSObject -Property @{'ID' = 2;'Protocol' = 'SSL 2.0';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0';'Server' = 1;'Client' = 0;'CbSvr' = $SvrSSL20;'CbCli' = $CliSSL20;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrSSL20;'SCli' = $CCliSSL20}
$APaths += $objInfo
# SSL 3.0
$objInfo = New-Object PSObject -Property @{'ID' = 3;'Protocol' = 'SSL 3.0';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0';'Server' = 1;'Client' = 1;'CbSvr' = $SvrSSL30;'CbCli' = $CliSSL30;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrSSL30;'SCli' = $CCliSSL30}
$APaths += $objInfo
# TLS 1.0
$objInfo = New-Object PSObject -Property @{'ID' = 4;'Protocol' = 'TLS 1.0';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0';'Server' = 1;'Client' = 1;'CbSvr' = $SvrTLS10;'CbCli' = $CliTLS10;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrTLS10;'SCli' = $CCliTLS10}
$APaths += $objInfo
# TLS 1.1
$objInfo = New-Object PSObject -Property @{'ID' = 5;'Protocol' = 'TLS 1.1';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1';'Server' = 1;'Client' = 1;'CbSvr' = $SvrTLS11;'CbCli' = $CliTLS11;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrTLS11;'SCli' = $CCliTLS11}
$APaths += $objInfo
# TLS 1.2
$objInfo = New-Object PSObject -Property @{'ID' = 6;'Protocol' = 'TLS 1.2';'Path' = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2';'Server' = 1;'Client' = 1;'CbSvr' = $SvrTLS12;'CbCli' = $CliTLS12;'DSvr' = 1;'DCli' = 1;'SSvr' = $SSvrTLS12;'SCli' = $CCliTLS12}
$APaths += $objInfo

foreach($x in $APaths)
{    
    #Server
    If((Test-path ($x.path + "\Server")) -eq $true)
    {
        try
        { 
            $SvrEnb = (Get-ItemPropertyValue -Path ($x.path + "\Server") -Name Enabled) 
            If($SvrEnb -gt 0)
            {
                $APaths[$x.ID].Server = 1
                ($x.CbSvr).IsChecked = $true
                                
            }
            else
            {
                $APaths[$x.ID].Server = 0
                ($x.CbSvr).IsChecked = $false                
            }
            $APaths[$x.ID].DSvr = 0
        }
        catch 
        {
            $APaths[$x.ID].Server = 1
            ($x.CbSvr).IsChecked = $true
            ($x.CbSvr).IsEnabled = $false            
            $APaths[$x.ID].DSvr = 1
            $SvrCDet[0].SvrCatch = 1
                 
        }        
        if($SvrCDet[0].SvrCatch -eq 1)
        {
            ($x.SSvr).Add_MouseDown(
            {
                $Child = $this.children
                foreach($iSvr in $APaths)
                {
                    if((($iSvr.CbSvr).Name -eq $Child.Name) -and (($iSvr.CbSvr).IsEnabled -eq $false))
                    {
                        ($iSvr.CbSvr).IsEnabled = $true
                        ($iSvr.CbSvr).IsChecked = $false
                    }
                }            
            })
        } 
    }
    else
    {
        $APaths[$x.ID].Server = 1
        ($x.CbSvr).IsChecked = $true
        ($x.CbSvr).IsEnabled = $false
        ($x.SSvr).Add_MouseDown(
        {
             $Child = $this.children
             foreach($iSvr in $APaths)
             {
                 if((($iSvr.CbSvr).Name -eq $Child.Name) -and (($iSvr.CbSvr).IsEnabled -eq $false))
                 {
                     ($iSvr.CbSvr).IsEnabled = $true
                     ($iSvr.CbSvr).IsChecked = $false
                 }
             }            
        })    
        $APaths[$x.ID].DSvr = 1   
    }
    
    #Client        
    If((Test-path ($x.path + "\Client")) -eq $true)
    {
        try
        {
            $CliEnb = (Get-ItemPropertyValue -Path ($x.path + "\Client") -Name Enabled)
            If($CliEnb -gt 0)
            {
                $APaths[$x.ID].Client = 1
                ($x.CbCli).IsChecked = $true
            }
            else
            {
                $APaths[$x.ID].Client = 0
                ($x.CbCli).IsChecked = $false
            }
            $APaths[$x.ID].DCli = 0
        }
        catch
        {            
            ($x.CbCli).IsChecked = $true
            $APaths[$x.ID].Client = 1
            $APaths[$x.ID].DCli = 1
            ($x.CbCli).IsEnabled = $false
            $CliCDet[0].CliCatch = 1              
        }
        if($CliCDet[0].CliCatch -eq 1)
        {
            ($x.SCli).Add_MouseDown(
            {
                $Child = $this.children
                foreach($iCli in $APaths)
                {
                    if((($iCli.CbCli).Name -eq $Child.Name) -and (($iCli.CbCli).IsEnabled -eq $false))
                    {
                        ($iCli.CbCli).IsChecked = $false
                        ($iCli.CbCli).IsEnabled = $true                        
                    }
                }            
            })
        }

    }
    else
    {       
         ($x.CbCli).IsChecked = $true
         $APaths[$x.ID].Client = 1
         $APaths[$x.ID].DCli = 1
         ($x.CbCli).IsEnabled = $false
         ($x.SCli).Add_MouseDown(
         {
             $Child = $this.children
             foreach($iCli in $APaths)
             {
                 if((($iCli.CbCli).Name -eq $Child.Name) -and (($iCli.CbCli).IsEnabled -eq $false))
                 {
                     ($iCli.CbCli).IsChecked = $false
                     ($iCli.CbCli).IsEnabled = $true
                 }
             }            
         })         
    }
}

"Old Settings"
$APaths | Format-Table -Wrap -AutoSize -Property 'ID','Protocol','Server','Client','DSvr','DCli'


# On Button Click of Server
$BtnSvr.Add_Click({

foreach($ySvr in $APaths)
{
    if((($ySvr.CbSvr).IsChecked -eq $true) -and ($APaths[$ySvr.ID].DSvr -eq 0) -and ($APaths[$ySvr.ID].Server -eq 0))
    {
        $SvrCDet[0].SvrChg = 1
        $APaths[$ySvr.ID].Server = 1
        If((Test-path $ySvr.path) -eq $true)
        {
            if((Test-path ($ySvr.path + "\Server")) -eq $false)
            {
                MD ($ySvr.path + "\Server")
            }
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "Enabled" -Value 1 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "DisabledByDefault" -Value 0 -PropertyType "DWord" -Force
        }
        else
        {
            MD ($ySvr.path)
            MD ($ySvr.path + "\Server")
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "Enabled" -Value 1 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "DisabledByDefault" -Value 0 -PropertyType "DWord" -Force
        }        
    }
    if((($ySvr.CbSvr).IsChecked -eq $false) -and ($APaths[$ySvr.ID].Server -eq 1))
    {
        $SvrCDet[0].SvrChg = 1
        $APaths[$ySvr.ID].Server = 0
        $APaths[$ySvr.ID].DSvr = 0
        If((Test-path $ySvr.path) -eq $true)
        {
            if((Test-path ($ySvr.path + "\Server")) -eq $false)
            {
                MD ($ySvr.path + "\Server")
            }
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "Enabled" -Value 0 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "DisabledByDefault" -Value 1 -PropertyType "DWord" -Force
        }
        else
        {
            MD ($ySvr.path)
            MD ($ySvr.path + "\Server")
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "Enabled" -Value 0 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($ySvr.path + "\Server") -Name "DisabledByDefault" -Value 1 -PropertyType "DWord" -Force
        }
    }
}

if($SvrCDet[0].SvrChg -eq 1)
{
    [System.Windows.MessageBox]::Show('Please Reboot for the changes to take effect')
}
else
{
    [System.Windows.MessageBox]::Show('No Change')
}

})

# On Button Click of Client
$BtnCli.Add_Click({

foreach($yCli in $APaths)
{
    if((($yCli.CbCli).IsChecked -eq $true) -and ($APaths[$yCli.ID].DCli -eq 0) -and ($APaths[$yCli.ID].Client -eq 0))
    {
        $CliCDet[0].CliChg = 1
        $APaths[$yCli.ID].Client = 1
        If((Test-path $yCli.path) -eq $true)
        {
            if((Test-path ($yCli.path + "\Client")) -eq $false)
            {
                MD ($yCli.path + "\Client")
            }
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "Enabled" -Value 1 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "DisabledByDefault" -Value 0 -PropertyType "DWord" -Force
        }
        else
        {
            MD ($yCli.path)
            MD ($yCli.path + "\Client")
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "Enabled" -Value 1 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "DisabledByDefault" -Value 0 -PropertyType "DWord" -Force
        }
    }
    if((($yCli.CbCli).IsChecked -eq $false) -and ($APaths[$yCli.ID].Client -eq 1))
    {
        $CliCDet[0].CliChg = 1
        $APaths[$yCli.ID].Client = 0
        $APaths[$yCli.ID].DCli = 0
        If((Test-path $yCli.path) -eq $true)
        {
            if((Test-path ($yCli.path + "\Client")) -eq $false)
            {
                MD ($yCli.path + "\Client")
            }
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "Enabled" -Value 0 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "DisabledByDefault" -Value 1 -PropertyType "DWord" -Force
        }
        else
        {
            MD ($yCli.path)
            MD ($yCli.path + "\Client")
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "Enabled" -Value 0 -PropertyType "DWord" -Force
            New-ItemProperty -Path ($yCli.path + "\Client") -Name "DisabledByDefault" -Value 1 -PropertyType "DWord" -Force
        }
    }
}

if($CliCDet[0].CliChg -eq 1)
{
    [System.Windows.MessageBox]::Show('Please Reboot for the changes to take effect')
}
else
{
    [System.Windows.MessageBox]::Show('No Change')
}

})

$Form.ShowDialog() | out-null
$APaths | Format-Table -Wrap -AutoSize -Property 'ID','Protocol','Server','Client','DSvr','DCli';
$Form = ''
$XAML = ''
$reader = ''
$APaths = ''
}
else{
[System.Windows.MessageBox]::Show('Please run the script as Administrator !!!') | Out-Null;
"Please run the script as Administrator !!!"
}