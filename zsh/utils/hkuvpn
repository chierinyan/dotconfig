#!/usr/bin/sudo /usr/bin/env python3

import sys, subprocess

from poplib import POP3_SSL
from email import message_from_bytes

from time import sleep
from datetime import datetime, timedelta, timezone

import logging
LOG_FORMAT = '%(asctime)s [%(levelname)s] %(message)s'
logging.basicConfig(level=logging.INFO, format=LOG_FORMAT)

CREDENTIALS = {
    "mail": {
        "server": "pop.qq.com",
        "address": "66666666@qq.com",
        "password": "abcdef0123456789"
    },
    "openconnect": {
        "server": "vpn2fa.hku.hk",
        "username": "66666666",
        "password": "abcdef0123456789"
    }
}

OPENCONNECT_CMD = ['openconnect',
    '--no-dtls',
    '--base-mtu', '1350',
    '--interface', 'hku',
    '--reconnect-timeout', '30',
    '--useragent', 'AnyConnect',
    # '--script', 'vpn-slice --prevent-idle-timeout 10.64.0.0/12 147.8.0.0/16 175.159.158.0/23 175.159.160.0/19 175.159.212.0/22 202.189.112.0/20 202.189.96.0/20 202.45.128.0/24;',
    CREDENTIALS['openconnect']['server']
]


class MailClient:
    def __init__(self):
        self.pop_server = POP3_SSL(CREDENTIALS['mail']['server'])
        self.pop_server.user(CREDENTIALS['mail']['address'])
        self.pop_server.pass_(CREDENTIALS['mail']['password'])

    def __del__(self):
        self.pop_server.quit()

    def _get_mail(self):
        try:
            mail_count = len(self.pop_server.list()[1])
            while mail_count > 0:
                mail_bytes_list = self.pop_server.retr(mail_count)[1]
                mail_bytes = b'\n'.join(mail_bytes_list)
                mail = message_from_bytes(mail_bytes)
                if 'HKU 2FA Email Token Code' in mail['Subject']:
                    return mail
        except Exception as e:
            logging.error(e)

    def get_token(self):
        initial_time = datetime.now(timezone(timedelta(hours=8)))
        for _ in range(30):
            sleep(10)
            mail = self._get_mail()
            if mail is None:
                continue

            sent_time = datetime.strptime(mail['Date'].split(', ')[-1], '%d %b %Y %H:%M:%S %z')
            logging.debug(f'Last token received at {sent_time}.')
            d = sent_time - initial_time
            if timedelta(seconds=-10) < d < timedelta(minutes=5):
                return mail['Subject'].split()[-1]


def main():
    logging.info('Starting new connection')

    ocp = subprocess.Popen(
        OPENCONNECT_CMD,
        bufsize=1,
        stdin=subprocess.PIPE,
        stdout=sys.stdout,
        stderr=sys.stderr,
        encoding='utf-8'
    )
    ocp.stdin.write(CREDENTIALS['openconnect']['username']+'\n')
    ocp.stdin.write(CREDENTIALS['openconnect']['password']+'\n')

    token = MailClient().get_token()
    if token:
        ocp.stdin.write(token+'\n')
        ocp.wait()
    else:
        logging.fatal(f'No valid token received. Exiting...')
        exit(233)


if __name__ == '__main__':
    main()
