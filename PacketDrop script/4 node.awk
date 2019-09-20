BEGIN {tcp0=0;ack0=0;tcp2=0;ack2=0;udp1=0;udp2=0}
{
    if ($1 == "r" && $5 == "tcp" && $3 == "0")
    {
        tcp0++;
    }
    else if ($1 == "r" && $5 == "tcp" && $3 == "2")
    {
        tcp2++;
    }
    else if ($1 == "r" && $5 == "cbr" && $3 == "1")
    {
        udp1++;
    }
    else if ($1 == "r" && $5 == "cbr" && $3 == "2")
    {
        udp2++;
    }
    else if ($1 == "r" && $5 == "ack" && $4 == "0")
    {
        ack0++;
    }
    else if ($1 == "r" && $5 == "ack" && $4 == "2")
    {
        ack2++;
    }
}
END {
    printf("\n");
    printf("Number of TCP packets sent by node 0: %d\n", tcp0);
    printf("Number of ACK packets received by node 0: %d\n", ack0);
    printf("Number of packets dropped by node 0: %d\n", tcp0-ack0);
    printf("Number of TCP packets sent by node 2: %d\n", tcp2);
    printf("Number of ACK packets received by node 2: %d\n", ack2);
    printf("Number of packets dropped by node 2: %d\n", tcp2-ack2);
    printf("Number of UDP packets sent by node 1: %d\n", udp1);
    printf("Number of UDP packets sent by node 2: %d\n", udp2);
}