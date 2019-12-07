# https://adventofcode.com/2019/day/4
# is a number between 372304-847060
# Two adjacent digits are the same (like 22 in 122345)
# the digits never decrease; they only ever increase or stay the same

$minrange = 372304
$maxrange = 847060

$OKNumbers = 0

for($i = $minrange;$i -le $maxrange;$i++)
{
    Write-Progress -Activity "Running through numbers" -Status "$i / $maxrange" -CurrentOperation "Numbers found: $($OKNumbers.count)"
    
    [string]$NumberToString = $i
    [int]$1st = $NumberToString[0]
    [int]$2nd = $NumberToString[1]
    [int]$3rd = $NumberToString[2]
    [int]$4th = $NumberToString[3]
    [int]$5th = $NumberToString[4]
    [int]$6th = $NumberToString[5]

    # check if numbers never increase from right to left
    if(($6th -ge $5th) -and ($5th -ge $4th) -and ($4th -ge $3rd) -and ($3rd -ge $2nd) -and ($2nd -ge $1st))
    {
        # check if number has at least two adjacent same numbers
        if($NumberToString -match "11" -or $NumberToString -match "22" -or $NumberToString -match "33" -or $NumberToString -match "44" -or $NumberToString -match "55" -or $NumberToString -match "66" -or $NumberToString -match "77" -or $NumberToString -match "88" -or $NumberToString -match "99")
        {
            $OKNumbers++
        }
    }
    [int]$i = $i
}

return $OKNumbers