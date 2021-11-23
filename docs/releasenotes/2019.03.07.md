### 2019.03.07.1

grand reorganization of i3ass. created a new GitHub organization: i3ass-dev.
Where all the i3ass scripts have it's own repo. It's on these repos development will be done from now on. This (budlabs/i3ass), will be the repo where all issues should be reported host the wiki and the installable version of i3ass. I think this will be great.

This repo also contains two fixes to issues reported by APotOfSoup:
i3get reported wrong info when criteria was **con_id**. and [i3flip] was not moving containers at all (the latter issue is only partially fixed, moving in containers that are not tabbed or stacked with i3flip is temporarily disabled)

more [i3get] fixes: there where some issues related to special characters in title of a window, and a bug that made all class searching and fetching not work. both fixed now.

