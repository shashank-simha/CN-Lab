set ns [new Simulator]

# open a log file with name sim.nam in write mode
set nf [open sim.nam w]

# log all traces into nf
$ns namtrace-all $nf

# create nodes
set n0 [$ns node]
set n1 [$ns node]

# create a duplex link between nodes
$ns duplex-link $n0 $n1 1Mb 8ms DropTail

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

# start communication and exit after 4ms
$ns at 0.1ms "$ftp start"
$ns at 4ms exit
$ns run