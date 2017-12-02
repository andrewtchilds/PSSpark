function Send-SparkMessage {
    <#
    .SYNOPSIS
        Send a Spark Message

    .DESCRIPTION
        Send a Spark Message

    .EXAMPLE
        PS C:\> Get-SparkUser -Name "John Doe" | Send-SparkMessage -MarkdownText "test"
    #>
    [cmdletbinding()]
    param(
        [string]$Text,

        [string]$MarkdownText,

        [Parameter(ValueFromPipelineByPropertyName)]
        $RoomID,

        [Parameter(ValueFromPipelineByPropertyName)]
        $UserID,

        $Token = $Script:PSSpark.Token
    )

    $Body = @{}

    switch($PSBoundParameters.Keys) {
        "Text"          { $Body.Add("text",$Text) }
        "MarkdownText"  { $Body.Add("markdown",$MarkdownText) }
        "RoomID"        { $Body.Add("roomId",$RoomID) }
        "UserID"        { $Body.Add("toPersonId",$UserID) }
    }

    $Params = @{
        Uri = $Script:PSSpark.Uri + "messages"
        ContentType = "application/json; charset=utf-8"
        Headers = @{ "Authorization" = "Bearer $Token" }
        Method = "Post"
        Body = $Body | ConvertTo-Json
    }

    $Params | Out-String | Write-Verbose

    $rawMessages = Invoke-RestMethod @Params
    Parse-SparkMessage $rawMessages
}