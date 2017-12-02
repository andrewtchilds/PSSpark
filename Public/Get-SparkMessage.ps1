function Get-SparkMessage {
    <#
    .SYNOPSIS
        Get a Spark Message

    .DESCRIPTION
        Get a Spark Message

    .EXAMPLE
        PS C:\> Get-SparkRoom -Name Test | Get-SparkMessage -MentionedUser me

        MessageID : [MessageID]
        RoomID    : [RoomID]
        RoomType  : group
        Text      : Hi John!
        UserID    : [UserID]
        Email     : janedoe@example.com
        Created   : 2017-11-20 12:05:42 PM
    #>
    [cmdletbinding(DefaultParameterSetName = "Param")]
    param(
        [Parameter(ParameterSetName = "Param")]
        $MentionedUser,

        [Parameter(ParameterSetName = "Param",
                   ValueFromPipelineByPropertyName)]
        $RoomID,

        [Parameter(ParameterSetName = "SparkMessage",
                   ValueFromPipelineByPropertyName)]
        $MessageID,

        $Token = $Script:PSSpark.Token
    )

    process{
        if($PSCmdlet.ParameterSetName -eq "SparkMessage") {
            $Params = @{
                Method = "messages/$MessageID"
            }
        } else {
            $Params = @{
                Method = "messages"
            }
        }

        $Params.Query = @()

        switch($PSBoundParameters.Keys) {
            "MentionedUser"     { $Params.Query += "mentionedPeople=$MentionedUser" }
            "RoomID"            { $Params.Query += "roomId=$($RoomID)" }
        }

        $rawMessages = Send-SparkAPI @Params
        Parse-SparkMessage $rawMessages
    }
}