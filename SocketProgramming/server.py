#!/usr/bin/env python3

import socket 

HOST = '127.0.0.1'
PORT = int (input('Enter the PORT number ot connect: '))

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            data = conn.recv(1024)
            if not data:
                break
            data = "Returned with thanks " + str(data)[1:]
            conn.sendall(str.encode(data))