set ns [new Simulator]

# open a log file with name sim.nam in write mode
set nf [open sim.nam w]

# log all traces into nf
$ns namtrace-all $nf

# create nodes
set n0 [$ns node]
set n1 [$ns node]

# create a duplex link between nodes
$ns duplex-link $n0 $n1 10Mb 8ms DropTail

# set orientation of nodes
$ns duplex-link-op $n0 $n1 orient right-center

# create a tcp agent and attach it to node 0
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

# create a tcp sink agent and attach it to node 1
set sink [new Agent/TCPSink]
$ns attach-agent $n1 $sink

# establish connection between nodes
$ns connect $tcp $sink

# create an FTP application and attach it to tcp of node 0
set ftp [new Application/FTP]
$ftp attach-agent $tcp

# invoke nam visualizer
proc finish {} {
    global ns nf
    $ns flush-trace
    close $nf
    exec nam sim.nam &
    exit 0
}

# start communication and exit after 4ms
$ns at 0.1ms "$ftp start"
$ns at 4ms "finish"
$ns run