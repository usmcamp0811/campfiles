#!/bin/python3 
import subprocess

def group_tuple(g):
    return g.split("(")[0], g.split("(")[-1].replace(")", "")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Clone some user given the output of `id`")
    parser.add_argument('--id', type=str, help='Just pass $(id) to this')
    args = parser.parse_args()
    ID=args.id
    # ID="uid=1000(aur) gid=986(users) groups=985(users),976(docker),102(test),998(wheel)"
    UID = ID.split(" ")[0].split("uid=")[1].split("(")[0]
    SID = ID.split(" ")[0].split("(")[-1].replace(")","")
    GID = ID.split(" ")[1].split("gid=")[1].split("(")[0]
    GNAME = ID.split(" ")[1].split("(")[-1].replace(")","")

    # get current group ids used on the system
    cat_stdout = subprocess.Popen("cat /etc/passwd",stdin=subprocess.PIPE,stdout=subprocess.PIPE,stderr=subprocess.PIPE,shell=True).stdout
    sys_gids = []
    for g in cat_stdout:
        sys_gids.append(int(g.decode().split(":")[3]))

    # remove the user if exists
    subprocess.run(["userdel", SID])

    # remove primary group 
    gout = subprocess.run(["getent", "group", GID], capture_output=True)
    if gout.stdout:
        delgname = str(gout.stdout).split(":")[0].replace("b'", "")
        newgid = max(sys_gids) + 1
        sys_gids.append(newgid)
        # change the group id because it conflicts with one of given groups
        subprocess.run(["groupmod", "-g", str(newgid), delgname])
        print("GROUP:", delgname, "has a new ID:", newgid)
    # remove any group with the same name as our primary
    subprocess.run(["groupdel", GNAME])

    # add the primary group back
    subprocess.run(["groupadd", "-g", GID, GNAME])

    # add our user back with the primary group set as above
    subprocess.run(["useradd", "-u", UID, "-g", GNAME, "-d", f"/home/{SID}", "-s", "/bin/bash", SID])

    groups = ID.split("groups=")[-1].split(",")
    groups = [group_tuple(g) for g in groups]
    for gid, gname in groups:
        if gname != GNAME:
            # get the group name if the gid exists so we can remove it
            gout = subprocess.run(["getent", "group", gid], capture_output=True)
            if gout.stdout:
                delgname = str(gout.stdout).split(":")[0].replace("b'", "")
                newgid = max(sys_gids) + 1
                sys_gids.append(newgid)
                # change the group id because it conflicts with one of given groups
                subprocess.run(["groupmod", "-g", str(newgid), delgname])
                print("GROUP:", delgname, "has a new ID:", newgid)

            # remove the group
            subprocess.run(["groupdel", gname])

            # add the group back with the correct gid
            subprocess.run(["groupadd", "-g", gid, gname])
        
        subprocess.run(["usermod", "-aG", gname, SID])

        
