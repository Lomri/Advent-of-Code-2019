# Get input content from files
$wire1File = "input_wire1.txt"
$wire2File = "input_wire2.txt"

$wire1content = (get-content $wire1File).split(",")
$wire2content = (get-content $wire2File).split(",")

Write-Host "Wire 1 has $($wire1content.count) steps."
Write-Host "Wire 2 has $($wire2content.count) steps."

# Create new objects for both wires
Write-Host "Creating new objects.."
$wire1 = New-Object pscustomobject
$wire2 = New-Object pscustomobject

$wire1 | Add-Member -Name "x" -Value 0 -MemberType NoteProperty
$wire1 | Add-Member -Name "y" -Value 0 -MemberType NoteProperty
$wire2 | Add-Member -Name "x" -Value 0 -MemberType NoteProperty
$wire2 | Add-Member -Name "y" -Value 0 -MemberType NoteProperty

write-host $wire1
write-host $wire2

# Every step is stored here for both wires
$wire1_steps = @()
$wire2_steps = @()

write-host "Saving each step for both wires.."
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

write-host "Calculating each step for wire 1"
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
                $newcoords = @($wire1.x,$i)
                Write-Progress -Activity "Calculating all positions for wire 1..." -status "Step $wire1_step_i / $wire1_total_steps : Moving up $amount steps" -PercentComplete ($wire1_step_i / $wire1_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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
                $newcoords = @($wire1.x,$i)
                Write-Progress -Activity "Calculating all positions for wire 1..." -status "Step $wire1_step_i / $wire1_total_steps : Moving down $amount steps" -PercentComplete ($wire1_step_i / $wire1_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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
                $newcoords = @($i,$wire1.y)
                Write-Progress -Activity "Calculating all positions for wire 1..." -status "Step $wire1_step_i / $wire1_total_steps : Moving left $amount steps" -PercentComplete ($wire1_step_i / $wire1_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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
                $newcoords = @($i,$wire1.y)
                Write-Progress -Activity "Calculating all positions for wire 1..." -status "Step $wire1_step_i / $wire1_total_steps : Moving right $amount steps" -PercentComplete ($wire1_step_i / $wire1_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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

write-host "Calculating each step for wire 2"
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
                $newcoords = @($wire2.x,$i)
                Write-Progress -Activity "Calculating all positions for wire 2..." -status "Step $wire2_step_i / $wire2_total_steps : Moving up $amount steps" -PercentComplete ($wire2_step_i / $wire2_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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
                $newcoords = @($wire2.x,$i)
                Write-Progress -Activity "Calculating all positions for wire 2..." -status "Step $wire2_step_i / $wire2_total_steps : Moving down $amount steps" -PercentComplete ($wire2_step_i / $wire2_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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
                $newcoords = @($i,$wire2.y)
                Write-Progress -Activity "Calculating all positions for wire 2..." -status "Step $wire2_step_i / $wire2_total_steps : Moving left $amount steps" -PercentComplete ($wire2_step_i / $wire2_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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
                $newcoords = @($i,$wire2.y)
                Write-Progress -Activity "Calculating all positions for wire 2..." -status "Step $wire2_step_i / $wire2_total_steps : Moving right $amount steps" -PercentComplete ($wire2_step_i / $wire2_total_steps * 100) -CurrentOperation "$($newcoords[0]),$($newcoords[1])"
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

write-host "Checking for overlapping coordinates"
# Check if any two coordinates overlap (meaning wire 1 is exactly at the same coordinate with wire 2)
$OverlappingCoordinates = @()
foreach($Wire1Coordinate in $wire1AllCoordinates)
{
    foreach($Wire2Coordinate in $wire2AllCoordinates)
    {
        if(($Wire1Coordinate[0] -eq $Wire2Coordinate[0]) -and ($Wire1Coordinate[1] -eq $Wire2Coordinate[1]))
        {
            $NewOverlappingCoords = @($Wire1Coordinate)
        }
    }
}

write-host "Overlapping coordinates found: $($OverlappingCoordinates.count)x"

# Get the Manhattan distance for each overlapping coordinate pair
$OverlappingCoordinatesManhattanDistances = @()
foreach($OverlappingCoordinate in $OverlappingCoordinates)
{
    $FirstNumber = [Math]::Abs($OverlappingCoordinate[0])
    $SecondNumber = [Math]::Abs($OverlappingCoordinate[1])

    $NewManhattanDistance = $FirstNumber + $SecondNumber
    write-host "Distance: $NewManhattanDistance"
    $OverlappingCoordinatesManhattanDistances += $NewManhattanDistance
}

write-host "Getting the smallest distance"

# Return the smallest Manhattan distance from the list
$SmallestNumber = $OverlappingCoordinatesManhattanDistances | sort-object -Descending | Select -last 1
return $SmallestNumber