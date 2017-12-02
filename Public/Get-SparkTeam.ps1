function Get-SparkTeam {
    <#
    .SYNOPSIS
        Get a Spark Team

    .DESCRIPTION
        Get a Spark Team

    .EXAMPLE
        PS C:\> Get-SparkTeam

        Name Created               TeamID       CreatorID
        ---- -------               ------       ---------
        Test 2017-03-23 7:03:00 PM [TeamID]     [CreatorID]

    #>
    [cmdletbinding(DefaultParameterSetName = "Param")]
    param(
        [Parameter(ParameterSetName = "Param")]
        [string[]]$Name,

        [Parameter(ParameterSetName = "SparkTeam",
                   ValueFromPipelineByPropertyName)]
        $TeamID,

        $Token = $Script:PSSpark.Token
    )

    process{
        if($PSCmdlet.ParameterSetName -eq "SparkTeam") {
            $Params = @{
                Method = "teams/$TeamID"
            }
        } else {
            $Params = @{
                Method = "teams"
            }
        }

        $rawTeams = Send-SparkAPI @Params
        $parsedTeams = Parse-SparkTeam $rawTeams

        if(-not $Name) {
            $parsedTeams
            return
        }

        $Teams = @()

        foreach($n in $Name) {
            if($n -match "\*") {
                $Wildcard = $true
            }

            if(-not $Wildcard) {
                $Teams += $parsedTeams | Where-Object { $_.Name -eq $n -and $Teams -notcontains $_ }
            }

            if($Wildcard) {
                $Teams += $parsedTeams | Where-Object { $_.Name -like $n -and $Teams -notcontains $_ }
            }
        }

        $Teams
    }
}