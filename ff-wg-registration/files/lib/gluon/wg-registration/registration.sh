#!/bin/sh

if [ "$(uci get gluon.mesh_vpn.enabled)" == "true" ] || [ "$(uci get gluon.mesh_vpn.enabled)" == "1" ]; then
        # try to wget the broker to see if connection is available
        gw_count=$(batctl gwl -H|grep -v "gateways in range"|wc -l)
        if [ gw_count -gt 0 ]; then
                logger -t wg-registration "uplink connected"
        else
                wg show | grep "latest handshake"
                if [ "$?" -eq "0" ]; then
                        logger -t wg-registration "wg connected - but no batman"
                else
                        logger -t wg-registration "No connection - trying to register"
                        # Push public key to broker, test for https and use if supported
                        wget -q https://[::1]
                        if [ $? -eq 1 ]; then
                                PROTO=http
                        else
                                PROTO=http
                        fi
                        PUBLICKEY=$(uci get network.wg_mesh.private_key | wg pubkey)
                        NODENAME=$(uci get system.@system[0].hostname)
                        BROKER=$(uci get wireguard.mesh_vpn.broker)
                        logger -t wg-registration "Post $NODENAME and $PUBLICKEY to $PROTO://$BROKER"
                        gluon-wan wget -q  -O- --post-data='{"node_name": "'"$NODENAME"'","public_key": "'"$PUBLICKEY"'"}' $PROTO://$BROKER
                fi
	fi
fi
