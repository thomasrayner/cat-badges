function Get-FibonacciNumber {
    param(
        [int]$n
    )

    if ($n -eq 0) {
        return 0
    }
    elseif ($n -eq 1) {
        return 1
    }
    else {
        $a = 0
        $b = 1
        for ($i = 2; $i -le $n; $i++) {
            $temp = $a + $b
            $a = $b
            $b = $temp
        }
        return $b
    }
}

function Get-RandomHexColor {
    $random = Get-Random -Minimum 0 -Maximum 16777215  # 16777215 is FFFFFF in decimal
    $hexColor = "{0:X6}" -f $random
    return $hexColor
}

function Get-Shield {
    param (
        [string]$ltext,
        [string]$rtext
    )

    $color = Get-RandomHexColor
    $pat = "https://img.shields.io/badge/$($ltext)-$($rtext)-$($color)"
    return $pat
}

for ($i = 0; $i -lt 50; $i++) {
    $fact = (Invoke-RestMethod -Uri "https://catfact.ninja/fact").fact
    $fact = [Regex]::Replace($fact, "[^\w\s]", "")
    $fib = $(Get-FibonacciNumber -n $($i+1))
    $shield = Get-Shield -ltext "Cat_Fact_$fib" -rtext $($fact -replace " ", "_") 
    $formatted = "[![Cat Fact $fib]($shield)](https://github.com/thomasrayner/cat-badges)"
    Write-Host $formatted
}
