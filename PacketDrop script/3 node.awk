BEGIN {tcp0=0;ack0=0;tcp2=0;ack2=0}
{
    if ($1 == "r" && $3 == "0" && $5 == "tcp")
    {
        tcp0++;
    }
    else if ($1 == "r" && $3 == "2" && $5 == "tcp")
    {
        tcp2++;
    }
    else if ($1 == "r" && $4 == "0" && $5 == "ack")
    {
        ack0++;
    }
    else if ($1 == "r" && $4 == "2" && $5 == "ack")
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
    printf("Number of TCP packets received by node 1: %d\n", ack0+ack2);
}