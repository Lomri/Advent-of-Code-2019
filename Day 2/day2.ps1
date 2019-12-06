param (
    [string]$InputFile = "input.txt"
)

Begin
{
    $InputList = @()

    if($InputFile -notmatch "/" -or $InputFile -notmatch "\")
    {
        $CurrentPath = Split-Path ($MyInvocation.MyCommand.Path)
        $InputFile = "$CurrentPath\$InputFile"
    }

    if(-not(Test-Path $InputFile))
    {
        # can't continue
        Write-Warning "Input file $InputFile was not found!"
        break
    }

    $Content = (Get-Content $InputFile).split(",")
    foreach($number in $Content)
    {
        $InputList += $number
    }
}
Process
{
    #Restore the gravity assist program to the "1202 program alarm" state
    $InputList[1] = 12
    $InputList[2] = 2

    [int]$CurrentIndex = 0
    [int]$Opcode = 0

    do
    {
        $Opcode = $InputList[$CurrentIndex]

        if($Opcode -ne 99)
        {
            [int]$IndexPlusOne = $inputlist[$CurrentIndex + 1]
            [int]$IndexPlusTwo = $inputlist[$CurrentIndex + 2]
            [int]$StoreHere = $inputlist[$CurrentIndex + 3]
            [int]$NextIndex = $CurrentIndex + 4
            [int]$FirstNumber = $InputList[$IndexPlusOne]
            [int]$SecondNumber = $InputList[$IndexPlusTwo]

            $Result = $null

            switch($Opcode)
            {
                1
                {
                    # ADD
                    $Result = $FirstNumber + $SecondNumber
                }
                2
                {
                    # MULTIPLY
                    $Result = $FirstNumber * $SecondNumber
                }
                default
                {
                    # nothing
                }
            }

            # store result
            $InputList[$StoreHere] = $Result

            # move to next opcode
            $CurrentIndex = $NextIndex
        }
    }
    while($Opcode -ne 99) # HALT
}
End
{
    return $InputList[0]
}