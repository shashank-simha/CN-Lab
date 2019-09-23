BEGIN {drop0=0;drop1=0}
{
    if ($1 == "d" && $6 == "500")
    {
        drop0++;
    }
    if ($1 == "d" && $6 == "200")
    {
        drop1++;
    }
}
END {
    printf("\n");
    printf("Number of UDP0 packets dropped: %d\n",drop0);
    printf("Number of UDP1 packets dropped: %d\n",drop1);
}