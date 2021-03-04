import socket
from libqtile.widget import base


class IPAddress(base.ThreadPoolText):
    DEFAULT_IP = '127.0.0.1'

    orientations = base.ORIENTATION_HORIZONTAL

    defaults = [
        ('update_interval', 1.0, 'Update interval for the IPAddress widget'),
    ]

    def __init__(self, **config):
        super().__init__(text=IPAddress.DEFAULT_IP, **config)
        self.add_defaults(IPAddress.defaults)

    def poll(self):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as sock:
                sock.connect(('8.8.8.8', 80))
                return str(sock.getsockname()[0])
        except socket.error:
            try:
                return socket.gethostbyname(socket.gethostname())
            except socket.gaierror:
                return IPAddress.DEFAULT_IP
