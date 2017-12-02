function Get-SparkUser {
    <#
    .SYNOPSIS
        Get a Spark User

    .DESCRIPTION
        Get a Spark User

    .EXAMPLE
        PS C:\> Get-SparkUser -Name "John Doe"

        Email        : {johndoe@example.com}
        Name         : John Doe
        NickName     : John
        FirstName    : John
        LastName     : Doe
        Avatar       : https://example.com/avatar.png
        OrgId        : [OrgID]
        Created      : 2016-08-10 2:43:19 PM
        LastActivity : 2017-12-01 3:18:41 PM
        Status       : inactive
        Type         : person
        UserID       : [UserID]
    #>
    [cmdletbinding(DefaultParameterSetName = "Param")]
    param(
        [Parameter(ParameterSetName = "Param")]
        [string]$Name,

        [Parameter(ParameterSetName = "Param")]
        [string]$Email,

        [Parameter(ParameterSetName = "SparkUser",
                   ValueFromPipelineByPropertyName)]
        $UserID,

        $Token = $Script:PSSpark.Token
    )

    process {
        if($PSCmdlet.ParameterSetName -eq "SparkUser") {
            $Params = @{
                Method = "people/$UserID"
            }
        } else {
            $Params = @{
                Method = "people"
            }
        }

        $Params.Query = @()

        switch($PSBoundParameters.Keys) {
            "Name"      { $Params.Query += "displayName=$($Name.toLower())" }
            "Email"     { $Params.Query += "email=$($Email.toLower())" }
        }

        $rawUsers = Send-SparkAPI @Params
        Parse-SparkUser $rawUsers
    }
}