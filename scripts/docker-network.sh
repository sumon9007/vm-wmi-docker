#!/bin/bash

# Configuration - Subnets (UDPATE these to modify network settings)
INTERNAL_SUBNET="172.18.0.0/24"
INTERNAL_GATEWAY="172.18.0.1"

EXTERNAL_SUBNET="172.19.0.0/24"
EXTERNAL_GATEWAY="172.19.0.1"

MGMT_SUBNET="172.20.0.0/24"
MGMT_GATEWAY="172.20.0.1"

# Network Names
NET_INTERNAL="internal_net"
NET_EXTERNAL="external_net"
NET_MGMT="mgmt_net"

# Helper function to create a network
create_network() {
    local name=$1
    local subnet=$2
    local gateway=$3

    if docker network inspect "$name" >/dev/null 2>&1; then
        echo "Network '$name' already exists."
    else
        echo "Creating network '$name' ($subnet)..."
        docker network create \
            --driver bridge \
            --subnet "$subnet" \
            --gateway "$gateway" \
            "$name"
        
        if [ $? -eq 0 ]; then
            echo "Successfully created '$name'."
        else
            echo "Failed to create '$name'."
            exit 1
        fi
    fi
}

# Helper function to delete a network
delete_network() {
    local name=$1
    if docker network inspect "$name" >/dev/null 2>&1; then
        echo "Removing network '$name'..."
        docker network rm "$name"
    else
        echo "Network '$name' does not exist."
    fi
}

# Main logic
case "$1" in
    create)
        echo "Creating Docker networks..."
        create_network "$NET_INTERNAL" "$INTERNAL_SUBNET" "$INTERNAL_GATEWAY"
        create_network "$NET_EXTERNAL" "$EXTERNAL_SUBNET" "$EXTERNAL_GATEWAY"
        create_network "$NET_MGMT" "$MGMT_SUBNET" "$MGMT_GATEWAY"
        ;;
    delete)
        echo "Deleting Docker networks..."
        delete_network "$NET_INTERNAL"
        delete_network "$NET_EXTERNAL"
        delete_network "$NET_MGMT"
        ;;
    recreate)
        echo "Recreating Docker networks..."
        $0 delete
        $0 create
        ;;
    *)
        echo "Usage: $0 {create|delete|recreate}"
        echo "  create   : Create internal, external, and mgmt networks if they don't exist"
        echo "  delete   : Remove the networks"
        echo "  recreate : Remove and then create the networks (applies new config)"
        exit 1
        ;;
esac
