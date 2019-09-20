BEGIN {tcp=0;ack=0}
{
    if ($1 == "r" && $5 == "ack")
    {
        ack++;
    }
    else if ($1 == "r" && $5 == "tcp")
    {
        tcp++;
    }
}
END {
    printf("\n");
    printf("Number of TCP packets sent by sender: %d\n", tcp);
    printf("Number of ACK packets received by sender: %d\n", ack);
}