# MoE Wi-Fi unofficial client

## Login screen
1. Add your login details from the login screen.
2. Refresh.
3. Login.

## Logout screen
1. Pull down to see active sessions.
2. Click on the X button to close a session.

## Users screen
1. View added login details.
2. Pull down to refresh.
3. Set a login detail as default or delete it.

## Known issues
1. **Sometimes refresh may timeout in Android.**<br>
This is likely caused by the `Private DNS` feature of Android. Turning off `Private DNS` should fix it.
2. **In linux-based distros, the login session may close abruptly sometimes.**<br>
This happens if multiple network managers are running together as explored in this forum: [https://bbs.archlinux.org/viewtopic.php?id=231194](https://bbs.archlinux.org/viewtopic.php?id=231194)<br>
Disable if there is any other dhcp process running along with it.<br>
Eg: in my case, it was systemd-resolved.<br>
`sudo systemctl disable systemd-resolved`<br>
`sudo systemctl stop systemd-resolved`<br>
`sudo rm /etc/resolv.conf`<br>
`sudo vim /etc/NetworkManager/NetworkManager.conf`<br>
Under the `[main]` section, add `dns=default`.<br>
Restart and pray there won't be any DNS issue.
3. **redirect_to_nas**<br>
Just retry whatever you were trying to do. It may be rate-limit or something.