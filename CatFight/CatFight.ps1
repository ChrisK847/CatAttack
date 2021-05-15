cls
$players = (Get-Content "$PSScriptRoot\Players\Players.txt" | ConvertFrom-Json).Players
$userChoice = 0
do {
    foreach ($value in $players) {
        Write-Host "select $($players.IndexOf($value)+1) for - $($value.name)"
    }
    $userchoice = Read-Host "Please enter your choice"
} while (-not($userchoice))

Write-Host "Users choice was: $($players[$userChoice-1].Name)"



exit
function CreatePlayer(){
    $myStats = new-object system.object
    add-member -inputobject $myStats -membertype noteproperty -name "Press to Select" -value $args[0]
    add-member -inputobject $myStats -membertype noteproperty -name "Breed" -value $args[1]
    add-member -inputobject $myStats -membertype noteproperty -name "HP" -value $args[2]
    add-member -inputobject $myStats -membertype noteproperty -name "STR" -value $args[3]
    add-member -inputobject $myStats -membertype noteproperty -name "DEF" -value $args[4]
    add-member -inputobject $myStats -membertype noteproperty -name "SPD" -value $args[5]
    add-member -inputobject $myStats -membertype noteproperty -name "STM" -value $args[6]
    add-member -inputobject $myStats -membertype noteproperty -name "LVL" -value $args[7]
    add-member -inputobject $myStats -membertype noteproperty -name "EXP" -value $args[8]
    add-member -inputobject $myStats -membertype noteproperty -name "NLV" -value $args[9]
    add-member -inputobject $myStats -membertype noteproperty -name "PTS" -value 0
    add-member -inputobject $myStats -membertype noteproperty -name "TOT" -value $($args[2] + $args[3] + $args[4] + $args[5])
    add-member -inputobject $myStats -membertype noteproperty -name "Owner" -value $args[12]
    add-member -inputobject $myStats -membertype noteproperty -name "Password" -value $args[13]
    add-member -inputobject $myStats -membertype noteproperty -name "arrLuck" -value $args[14]
    add-member -inputobject $myStats -membertype noteproperty -name "avgLuck" -value $args[15]
    add-member -inputobject $myStats -membertype noteproperty -name "arrSpd" -value $args[16]
    add-member -inputobject $myStats -membertype noteproperty -name "avgSpd" -value $args[17]
    add-member -inputobject $myStats -membertype noteproperty -name "arrPts" -value $args[18]
    add-member -inputobject $myStats -membertype noteproperty -name "Pet Name" -value $args[19]
    return $myStats
}

function Attack(){

    $crazyLuck=if($(get-random(1..50)) -eq 25){2}else{0}

    $attack=($args[0].STR + $crazyLuck) - ($args[1].DEF / 2)

    if($attack -lt 1){
        $attack=1
    }

    $speedBonus=($args[0].SPD - $args[1].SPD) * .05

    #CRITICAL HIT?
    $preHit=get-random(0,.25,.5,.75,1)

    $hit = $preHit + $speedBonus

    If($hit -le 0 -or $preHit -eq 0){
        $hit = 0
    }elseif($hit -ge 1){
        $hit = 1
    }else{}

    $totalDamage=$attack*$hit
    $attacker="attacker=$($args[0].Owner)/$($args[0].Breed)"
    $stats="attack=$attack, speedBonus=$([system.math]::round($speedBonus*100,2))%, luck=$([system.math]::round($preHit*100,2))%, hit%=$([system.math]::round($hit*100,2))%, totalDamage=$totalDamage"
 
    return @($($args[1].HP - $totalDamage),$totalDamage,$("$attacker`n$stats"),$preHit,$speedBonus,$crazyLuck)

}

write-host "CAT FIGHT 2021`n`nDon't let your pet off the leash!"
sleep -Seconds 3
cls

#ENTER YOUR NAME
#$name1 = Read-Host "Player 1, Enter Your Name."
$players = (Get-Content "$PSScriptRoot\Players\Players.txt" | ConvertFrom-Json).Players
$characters | FT @{l="Press `nto`nselect";e={$_."Press to Select"};w=7;a="Center"},@{l="`n`nPet Name";e={$_."Breed"};w=21},@{l="`n`nHP";e={$_.HP};w=4;a="Center"},@{l="`n`nSTR";e={$_.STR};w=4;a="Center"},@{l="`n`nDEF";e={$_.DEF};w=4;a="Center"},@{l="`n`nSPD";e={$_.SPD};w=4;a="Center"}
[int]$select1 = Read-Host "Press key shown in 'Press to Select' field to select Pet, then press enter."
Switch ($select1){
    1 {$name1=$players[0]."Breed";$hp=$characters[0].HP;$STR=$characters[0].STR;$DEF=$characters[0].DEF;$SPD=$characters[0].SPD;$userName=$name1}
    2 {$name1=$players[1]."Breed";$hp=$characters[1].HP;$STR=$characters[1].STR;$DEF=$characters[1].DEF;$SPD=$characters[1].SPD;$userName=$name1}
    3 {$name1=$players[2]."Breed";$hp=$characters[2].HP;$STR=$characters[2].STR;$DEF=$characters[2].DEF;$SPD=$characters[2].SPD;$userName=$name1}
    default {write-host "Please restart program and select 1 to $($characters.Count)";exit}
}

cls

#IMPORT SAVED CHARACTERS
$characters = (Get-Content "$PSScriptRoot\Characters\Characters.txt" | ConvertFrom-Json).Characters

#CHOOSE CHARACTER
write-host "$name1, Choose Your Character"
$characters | FT @{l="Press `nto`nselect";e={$_."Press to Select"};w=7;a="Center"},@{l="`n`nPet Name";e={$_."Breed"};w=21},@{l="`n`nHP";e={$_.HP};w=4;a="Center"},@{l="`n`nSTR";e={$_.STR};w=4;a="Center"},@{l="`n`nDEF";e={$_.DEF};w=4;a="Center"},@{l="`n`nSPD";e={$_.SPD};w=4;a="Center"}
[int]$select1 = Read-Host "Press key shown in 'Press to Select' field to select Pet, then press enter."
Switch ($select1){
    1 {$character=$characters[0]."Breed";$hp=$characters[0].HP;$STR=$characters[0].STR;$DEF=$characters[0].DEF;$SPD=$characters[0].SPD;$userName=$name1}
    2 {$character=$characters[1]."Breed";$hp=$characters[1].HP;$STR=$characters[1].STR;$DEF=$characters[1].DEF;$SPD=$characters[1].SPD;$userName=$name1}
    3 {$character=$characters[2]."Breed";$hp=$characters[2].HP;$STR=$characters[2].STR;$DEF=$characters[2].DEF;$SPD=$characters[2].SPD;$userName=$name1}
    default {write-host "Please restart program and select 1 to $($characters.Count)";exit}
}

#CREATE PLAYER1
$player1=CreatePlayer $null $character $hp $STR $DEF $SPD $null $null $null $null 0 $null $name1 ""

#CREATE PLAYER2
[int]$select2=Get-random(1..3)
$name2=Get-Random("Some Pet owner","Shady","Patches")
Switch ($select2){
    1 {$character=$characters[0]."Breed";$hp=$characters[0].HP;$STR=$characters[0].STR;$DEF=$characters[0].DEF;$SPD=$characters[0].SPD;$userName=$name2}
    2 {$character=$characters[1]."Breed";$hp=$characters[1].HP;$STR=$characters[1].STR;$DEF=$characters[1].DEF;$SPD=$characters[1].SPD;$userName=$name2}
    3 {$character=$characters[2]."Breed";$hp=$characters[2].HP;$STR=$characters[2].STR;$DEF=$characters[2].DEF;$SPD=$characters[2].SPD;$userName=$name2}
    default {write-host "Please restart program and select 1 to $($characters.Count)";exit}
}
$player2=CreatePlayer $null $character $hp $STR $DEF $SPD $null $null $null $null 0 $null $name2 ""
cls

#FIGHT ORDER
if($player1.SPD -gt $player2.SPD){
    $order=@($player1,$player2)
}elseif($player1.SPD -lt $player2.SPD){
    $order=@($player2,$player1)
}else{
    if($(get-random(0,1)) -eq 0){
        $order=@($player1,$player2)
    }else{
        $order=@($player2,$player1)
    }
}

#CONTENDERS
write-host "Contenders"
$order | Select Owner,"Breed",HP,STR,DEF,SPD | ft
sleep -Seconds 5
cls

#FIGHT UNTIL WIN
$history = @()
$turn=0
$round=1
do{
    $temp=@() 
    $temp2=@()
    if($turn -eq 0){
        Write-host "Round $round"
        
        $temp += $(Attack $order[0] $order[1])

        $order[1].HP = $([system.math]::round($temp[0],2))

        $order[0].PTS = $order[0].PTS + $temp[1]

        $temp[2]

        $turn=1


    }elseif($turn -eq 1){

        Write-host "Round $round"

        $temp += $(Attack $order[1] $order[0])

        $order[0].HP = $([system.math]::round($temp[0],2))

        $order[1].PTS = $order[1].PTS + $temp[1]

        $temp[2]

        #$order[0].HP = $([system.math]::round($(Attack $order[1] $order[0]),2))
        $turn=0
    

    }else{}

   
    if($order[0].HP -lt 0){
        $order[0].HP=0
    }
    if($order[1].HP -lt 0){
        $order[1].HP=0
    }

    
    $temp2 += $order | select Owner,"Breed",HP | ft
    $history += $temp2
    $temp2

    read-host "[Ding ding ding!] Round $round ends. Motivate your pet and press any key to start next round."
    
    cls
    $round++
    

}while(($order[0].HP -gt 0 -and $order[1].HP -gt 0) -and $round -le 6)



write-host "Fight Results"

$order | ft Owner,"Breed",HP,STR,DEF,SPD,PTS