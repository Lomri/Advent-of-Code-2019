#https://adventofcode.com/2019/day/3

# Get input content from files
$wire1File = "input_wire1.txt"
$wire2File = "input_wire2.txt"

$wire1content = (get-content $wire1File).split(",")
$wire2content = (get-content $wire2File).split(",")

# Save results to files to speed up consecutive runs
$Wire1SaveFile = "wire1_data.txt"
$Wire2SaveFile = "wire2_data.txt"

# Create new objects for both wires
$wire1 = New-Object pscustomobject
$wire2 = New-Object pscustomobject

$wire1 | Add-Member -Name "x" -Value 0 -MemberType NoteProperty
$wire1 | Add-Member -Name "y" -Value 0 -MemberType NoteProperty
$wire2 | Add-Member -Name "x" -Value 0 -MemberType NoteProperty
$wire2 | Add-Member -Name "y" -Value 0 -MemberType NoteProperty

# Every step is stored here for both wires
$wire1_steps = @()
$wire2_steps = @()

foreach($AddStep in $wire1content)
{
    $wire1_steps += $AddStep
}
foreach($AddStep2 in $wire2content)
{
    $wire2_steps += $AddStep2
}

# Every coordinate for both wires are stored here
$wire1AllCoordinates = @()
$wire2AllCoordinates = @()

# Used for progress bar update
$wire1_step_i = 0
$wire2_step_i = 0
$wire1_total_steps = $wire1_steps.count
$wire2_total_steps = $wire2_steps.count

if(-not(test-path $Wire1SaveFile))
{
    # Calculate every possible coordinate for wire 1
    foreach($step in $wire1_steps)
    {
        $wire1_step_i++
        switch($step[0])
        {
            "U"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire1.y + $amount)

                for($i = $wire1.y; $i -ne $futurecoord; $i++)
                {
                    $newcoords = "$($wire1.x),$i"
                    $wire1AllCoordinates += $newcoords
                }

                $wire1.y += $amount
            }
            "D"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire1.y - $amount)

                for($i = $wire1.y; $i -ne $futurecoord; $i--)
                {
                    $newcoords = "$($wire1.x),$i"
                    $wire1AllCoordinates += $newcoords
                }

                $wire1.y -= $amount
            }
            "L"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire1.x - $amount)

                for($i = $wire1.x; $i -ne $futurecoord; $i--)
                {
                    $newcoords = "$i,$($wire1.y)"
                    $wire1AllCoordinates += $newcoords
                }

                $wire1.x -= $amount
            }
            "R"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire1.x + $amount)

                for($i = $wire1.x; $i -ne $futurecoord; $i++)
                {
                    $newcoords = "$i,$($wire1.y)"
                    $wire1AllCoordinates += $newcoords
                }

                $wire1.x += $amount
            }
            default
            {
                Write-Error "Unknown step: $step"
                break
            }
        }
    
    }
    $wire1AllCoordinates | Add-Content $Wire1SaveFile -Force
}
else
{
    $wire1AllCoordinates += Get-Content $Wire1SaveFile
}

if(-not(Test-Path $Wire2SaveFile))
{
    # Calculate every possible coordinate for wire 2
    foreach($step in $wire2_steps)
    {
        $wire2_step_i++
        switch($step[0])
        {
            "U"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire2.y + $amount)

                for($i = $wire2.y; $i -ne $futurecoord; $i++)
                {
                    $newcoords = "$($wire2.x),$i"
                    $wire2AllCoordinates += $newcoords
                }

                $wire2.y += $amount
            }
            "D"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire2.y - $amount)

                for($i = $wire2.y; $i -ne $futurecoord; $i--)
                {
                    $newcoords = "$($wire2.x),$i"
                    $wire2AllCoordinates += $newcoords
                }

                $wire2.y -= $amount
            }
            "L"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire2.x - $amount)

                for($i = $wire2.x; $i -ne $futurecoord; $i--)
                {
                    $newcoords = "$i,$($wire2.y)"
                    $wire2AllCoordinates += $newcoords
                }

                $wire2.x -= $amount
            }
            "R"
            {
                $amount = $step.split($step[0])[1]
                $futurecoord = ($wire2.x + $amount)

                for($i = $wire2.x; $i -ne $futurecoord; $i++)
                {
                    $newcoords = "$i,$($wire2.y)"
                    $wire2AllCoordinates += $newcoords
                }

                $wire2.x += $amount
            }
            default
            {
                Write-Error "Unknown step: $step"
                break
            }
        }
    
    }
    $wire2AllCoordinates | Add-Content $Wire2SaveFile -Force
}
else
{
    $wire2AllCoordinates += Get-Content $Wire2SaveFile
}

write-host "Checking for overlapping coordinates"
# Check if any two coordinates overlap (meaning wire 1 is exactly at the same coordinate with wire 2)

$OverlappingCoordinatesManhattanDistances = @()

foreach($coordinate in $wire1AllCoordinates)
{
    if($coordinate -ne "0,0")
    {
        write-host "Checking coordinate $coordinate"
        if($coordinate -in $wire2AllCoordinates)
        {
            # Got matching coordinates for x,y for both wires

            [int]$FirstCoordWire1X = $coordinate.split(",")[0]
            [int]$SecondCoordWire1Y = $coordinate.split(",")[1]

            # Get the Manhattan distance for this collision
            $FirstNumber = [Math]::Abs($FirstCoordWire1X)
            $SecondNumber = [Math]::Abs($SecondCoordWire1Y)

            $NewManhattanDistance = $FirstNumber + $SecondNumber
            $OverlappingCoordinatesManhattanDistances += $NewManhattanDistance

            $NewManhattanDistance | Add-Content "manhattan_distances_data.txt" -Force
        }
    }
}

# Return the smallest Manhattan distance from the list
$SmallestNumber = $OverlappingCoordinatesManhattanDistances | sort-object -Descending | Select -last 1
return $SmallestNumber