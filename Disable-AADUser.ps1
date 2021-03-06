function Disable-AADUser {

    [cmdletbinding()]
    param(

        [Parameter(Mandatory = $true)]
        [String]$UPN

    )

    <#
		IMPORTANT:
        ===========================================================================
        This script is provided 'as is' without any warranty. Any issues stemming 
        from use is on the user.
        ===========================================================================
		.DESCRIPTION
		Disables AAD User
        Things to change to deploy in your environment:
        Line 30 - replace x with clientID of your reigstered app. See https://bit.ly/3KApKhJ for more info.
		===========================================================================
		.PARAMETER UPN
        REQUIRED - Email/userPrincipalName of user to disable
		===========================================================================
		.EXAMPLE
		Disable-AADUser -UPN bjameson@example.com <--- This disables bjameson@example.com
	#>


    $token = Get-MsalToken -clientid x -tenantid organizations
    $global:header = @{'Authorization' = $token.createauthorizationHeader();'ConsistencyLevel' = 'eventual'}
    $uri = "https://graph.microsoft.com/v1.0/users/$UPN"
    $Body = @{"accountEnabled" = $false} | ConvertTo-Json
    Try {

        Invoke-RestMethod -Uri $Uri -Body $body -Headers $Header -Method Patch -ContentType "application/Json"

    }
    catch{
        $ResponseResult = $_.Exception.Response.GetResponseStream()
        $ResponseReader = New-Object System.IO.StreamReader($ResponseResult)
        $ResponseBody = $ResponseReader.ReadToEnd()
        $ResponseBody    
    }
        
}