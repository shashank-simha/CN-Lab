set ns [new Simulator]
set nf [open sim.nam w]
set nt [open ag.tr w]

$ns namtrace-all $nf
$ns trace-all $nt

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 10Mb 8ms DropTail
$ns duplex-link $n1 $n2 10Mb 8ms DropTail

$ns queue-limit $n0 $n1 3
$ns queue-limit $n2 $n1 3

$ns duplex-link-op $n0 $n1 orient right-center
$ns duplex-link-op $n1 $n2 orient right-center

set tcp1 [new Agent/TCP] 
$ns attach-agent $n0 $tcp1

set tcp2 [new Agent/TCP]
$ns attach-agent $n2 $tcp2

set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1

set sink2 [new Agent/TCPSink]
$ns attach-agent $n1 $sink2

$ns connect $tcp1 $sink1
$ns connect $tcp2 $sink2

set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2

proc finish {} {
    global ns nf nt
    $ns flush-trace
    close $nf
    close $nt
    exec nam sim.nam &
    exec gawk -f 3\ node.awk ag.tr &
    exit 0
}

$ns at 0.1ms "$ftp1 start"
$ns at 0.1ms "$ftp2 start"
$ns at 4ms "finish"
$ns run