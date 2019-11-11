#!/usr/bin/env python3

import socket 

HOST = '127.0.0.1'
PORT = int (input('Enter the PORT number ot connect: '))

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    data = input('Enter message: ')
    s.sendall(str.encode(data))
    data = s.recv(1024)

print("Received ", repr(data)[1:])
