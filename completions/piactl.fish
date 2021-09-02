# Usage: piactl [options] command [parameters...]
# Command-line interface to the PIA client.  Some commands, such as connect, require that the graphical client is also running.

function __piactl_regions
  command piactl get regions
end

complete --command piactl -x --no-files -s h -l help    -d 'Displays help'
complete --command piactl -x --no-files -s v -l version -d 'Displays version information'

complete --command piactl -x --no-files -s t -l timeout -d 'Sets time for one-shot commands'
complete --command piactl -x --no-files -s d -l debug   -d 'Prints debug logs to stderr'

complete --command piactl --no-files -x -n '__fish_use_subcommand' -a connect -d 'Connects to the VPN, or reconnects to apply new settings'
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a disconnect -d 'Disconnects from the VPN'
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a logout -d 'Log out your PIA account on this computer'
complete --command piactl            -x -n '__fish_use_subcommand' -a login -d 'Usage: login <login_file>. Log in to your PIA account'
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a resetsettings -d 'Resets daemon settings to the defaults (ports/protocols/etc)'

# background
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a background -d 'Allow the killswitch and/or VPN connection to remain active in the background when the GUI client is not running'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from background' -a enable -d 'PIA daemon will stay active when GUI client isn\'t running'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from background' -a disable -d 'PIA daemon will not stay active when GUI client isn\'t running'

# dedicatedip
complete --command piactl --no-files -x -n '__fish_use_subcommand ' -a dedicatedip -d 'Add or remove a Dedicated IP'
complete --command piactl            -x -n '__fish_seen_subcommand_from dedicatedip' -a enable -d 'Add dedicated IP from <token_file>'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from dedicatedip' -a disable -d 'Remove dedicated IP <region_id>'

#     usage (remove): dedicatedip remove <region_id>
#     To add, put the dedicated IP token in a text file (by itself), and specify that file on the command line:
#         DIP20000000000000000000000000000
#     (This ensures the token is not visible in the process command line or environment.)
#     To remove, specify the dedicated IP region ID, as shown by `piactl get regions`, such as
#     `dedicated-sweden-000.000.000.000`.

# get
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a get -d 'Get information from the PIA daemon.'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a allowlan -d 'Whether to allow LAN traffic'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a connectionstate -d 'VPN connection state'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a debuglogging -d 'State of debug logging setting'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a portforward -d 'Forwarded port number if available, or the status of the request to forward a port'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a protocol -d 'VPN connection protocol'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a pubip -d 'Current public IP address'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a region -d 'Currently selected region (or "auto")'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a regions -d 'List all available regions'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a requestportforward -d 'Whether a forwarded port will be requested on the next connection attempt'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from get' -a vpnip -d 'Current VPN IP address'

# monitor
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a monitor -d 'Monitors the PIA daemon for changes in a specific setting or state value.'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a allowlan -d 'Whether to allow LAN traffic'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a connectionstate -d 'VPN connection state'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a debuglogging -d 'State of debug logging setting'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a portforward -d 'Forwarded port number if available, or the status of the request to forward a port'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a protocol -d 'VPN connection protocol'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a pubip -d 'Current public IP address'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a region -d 'Currently selected region (or "auto")'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a requestportforward -d 'Whether a forwarded port will be requested on the next connection attempt'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from monitor' -a vpnip -d 'Current VPN IP address'

# set
complete --command piactl --no-files -x -n '__fish_use_subcommand' -a set -d 'Change settings in the PIA daemon'

set -l __piactl_set_subcommands 'region protocol allowlan debuglogging requestportforward'

# set region
complete --command piactl --no-files -x -n "__fish_seen_subcommand_from set; and not __fish_seen_subcommand_from $__piactl_set_subcommands" \
  -a region -d 'Select region'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from set; and __fish_seen_subcommand_from region' -a '(__piactl_regions)'

# set protocol
complete --command piactl --no-files -x -n "__fish_seen_subcommand_from set; and not __fish_seen_subcommand_from $__piactl_set_subcommands" \
  -a protocol -d 'Select a VPN protocol'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from set; and __fish_seen_subcommand_from protocol' -a 'wireguard openvpn'

# set allowlan
complete --command piactl --no-files -x -n "__fish_seen_subcommand_from set; and not __fish_seen_subcommand_from $__piactl_set_subcommands" \
  -a allowlan -d 'Whether to allow LAN traffic'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from set; and __fish_seen_subcommand_from allowlan' -a 'true false'

# set debuglogging
complete --command piactl --no-files -x -n "__fish_seen_subcommand_from set; and not __fish_seen_subcommand_from $__piactl_set_subcommands" \
  -a debuglogging -d 'Enable or disable debug logging'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from set; and __fish_seen_subcommand_from debuglogging' -a 'true false'

# set requestportforward
complete --command piactl --no-files -x -n "__fish_seen_subcommand_from set; and not __fish_seen_subcommand_from $__piactl_set_subcommands" \
  -a requestportforward -d 'Whether to request a forwarded port on the next connection attempt'
complete --command piactl --no-files -x -n '__fish_seen_subcommand_from set; and __fish_seen_subcommand_from requestportforward' -a 'true false'
