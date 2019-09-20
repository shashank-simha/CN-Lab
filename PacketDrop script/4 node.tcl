set ns [new Simulator]
$ns color 1 Blue
$ns color 2 Red

set nf [open sim.nam w]
set nt [open ag.tr w]

$ns namtrace-all $nf
$ns trace-all $nt

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 color red
$n1 color blue
$n3 color brown

$ns duplex-link $n0 $n2 10Mb 8ms DropTail
$ns duplex-link $n1 $n2 10Mb 8ms DropTail
$ns duplex-link $n2 $n3 10Mb 10ms DropTail

$ns queue-limit $n0 $n2 3
$ns queue-limit $n1 $n2 3

$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right-center

set tcp [new Agent/TCP] 
$ns attach-agent $n0 $tcp

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

set null [new Agent/Null]
$ns attach-agent $n3 $null

$ns connect $tcp $sink
$ns connect $udp $null

$tcp set fid_ 1
$udp set fid_ 2

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp

proc finish {} {
    global ns nf nt
    $ns flush-trace
    close $nf
    close $nt
    # exec nam sim.nam &
    exec gawk -f 4\ node.awk ag.tr &
    exit 0
}

$ns at 0.1ms "$ftp start"
$ns at 0.1ms "$cbr start"
$ns at 4ms "finish"
$ns run