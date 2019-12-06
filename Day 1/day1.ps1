param (
    [string]$InputFile = "input.txt"
)

Begin
{
    if(-not(Test-Path $InputFile))
    {
        # can't continue
        Write-Warning "Input file $InputFile was not found!"
        break
    }

    $InputContent = Get-Content $InputFile

    $FuelRequired = @()
}
Process
{
    <#
    Fuel required to launch a given module is based on its mass. Specifically, to find the fuel required for a module, take its mass, divide by three, round down, and subtract 2.

    For example:

    For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
    For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
    For a mass of 1969, the fuel required is 654.
    For a mass of 100756, the fuel required is 33583.

    The Fuel Counter-Upper needs to know the total fuel requirement. To find it, individually calculate the fuel needed for the mass of each module (your puzzle input), then add together all the fuel values.
    #>

    ForEach($Mass in $InputContent)
    {
        [int]$Mass = $Mass
        $Fuel = ([Math]::Floor([decimal]($Mass/3))-2)
        $FuelRequired += $Fuel
    }
}
End
{
    $Total = 0
    foreach($FuelAmount in $FuelRequired)
    {
        $Total += $FuelAmount
    }
    return $Total
}