from netifaces import interfaces, ifaddresses, AF_INET
from libqtile.widget import base


class IPAddress(base.ThreadedPollText):
    orientations = base.ORIENTATION_HORIZONTAL

    defaults = [
        ("update_interval", 1.0, "Update interval for the IPAddress widget"),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(IPAddress.defaults)

    def tick(self):
        self.update(self.poll())
        return self.update_interval

    def poll(self):
        ip_address = '127.0.0.1'
        for iface_name in interfaces():
            ip = [
                i['addr'] for i in ifaddresses(iface_name).setdefault(
                    AF_INET, 
                    [{'addr':'No IP addr'}]
                )
            ]
            if ip[0].startswith('192'):
                ip_address = ip[0]
                break
        return f'{ip_address}'
