#!/usr/bin/python

from __future__ import print_function

import os
import sys

os.chdir(os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    '.bitcoin'))

BITCOIND_CONFIG_FILE = '/root/.bitcoin/bitcoin.conf'
conf = {}

if os.environ.get('BITCOIND_HOST'):
   BITCOIND_HOST = os.environ.pop('BITCOIND_HOST')

for k,v in os.environ.iteritems():
    if k.startswith('BITCOIND_'):
        k = k[len('BITCOIND_'):].lower()
        conf[k] = v

with open(BITCOIND_CONFIG_FILE, 'w+') as f:
    for k, v in conf.iteritems():
        if k in ['rpcallowip', 'addnode', 'connect']:
            nodes = v.split(',')
            for node in nodes:
                f.write("%s=%s\n" % (k, node))
        else:
            f.write("%s=%s\n" % (k, v))

# Start Bitcoind
os.execl('/usr/local/bin/bitcoind', 'bitcoind')
