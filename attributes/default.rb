
default[:bridger][:interface] = "eth0"
default[:bridger][:name] = "ovsbr0"
default[:bridger][:dhcp] = "none"
default[:bridger][:ipaddress] = node["ipaddress"]
default[:bridger][:netmask] = node["network"]["interfaces"][node['network']["default_interface"]]["addresses"][node["ipaddress"]]["netmask"]
default[:bridger][:gateway] = node["network"]["default_gateway"]

default[:bond][:enabled] = "no"
default[:bond][:type] = ""
default[:bond][:mode] = ""
default[:bond][:slaves] = ""
default[:bond][:type] = "6"
default[:bond][:miimon] = "miimon=80"
default[:bond][:slaves] = "eth0"
