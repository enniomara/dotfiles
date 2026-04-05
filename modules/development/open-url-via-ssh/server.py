import json
import logging
import selectors
import socket
import sys
import types
import webbrowser

sel = selectors.DefaultSelector()
logging.basicConfig(level=logging.INFO)


def accept_wrapper(sock):
    conn, addr = sock.accept()  # Should be ready to read
    logging.info(f"Accepted connection from {addr}")
    conn.setblocking(False)
    data = types.SimpleNamespace(addr=addr, inb=b"", outb=b"")
    events = selectors.EVENT_READ | selectors.EVENT_WRITE
    sel.register(conn, events, data=data)


def service_connection(key, mask):
    sock = key.fileobj
    data = key.data
    if mask & selectors.EVENT_READ:
        recv_data = sock.recv(1024)  # Should be ready to read
        if recv_data:
            handle_data(recv_data)
            data.outb += recv_data
        else:
            logging.info(f"Closing connection to {data.addr}")
            sel.unregister(sock)
            sock.close()


def handle_data(data):
    j = json.loads(data)
    if j["type"] == "url":
        webbrowser.open(j["open"])
        return
    logging.warning("Got an unknown type: %s", j["type"])


if __name__ == "__main__":
    if len(sys.argv) != 3:
        print(f"Usage: {sys.argv[0]} <host> <port>")
        sys.exit(1)

    host, port = sys.argv[1], int(sys.argv[2])
    lsock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    lsock.bind((host, port))
    lsock.listen()

    logging.info(f"Listening on {(host, port)}")
    lsock.setblocking(False)
    sel.register(lsock, selectors.EVENT_READ, data=None)

    try:
        while True:
            events = sel.select(timeout=None)
            for key, mask in events:
                if key.data is None:
                    accept_wrapper(key.fileobj)
                else:
                    service_connection(key, mask)
    except KeyboardInterrupt:
        logging.info("Caught keyboard interrupt, exiting")
    finally:
        sel.close()
