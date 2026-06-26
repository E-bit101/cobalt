import os, pwd, shutil
import updateBinds as binds
import json

SOURCE_DIR = "/etc/dotfiles"
ignored_paths = []
pwuid = 0

def copy_check(src, dst):
    for i in ignored_paths:
        if src.startswith(SOURCE_DIR + "/" + i):
            return

    if pwuid != 0:
        shutil.chown(dst, user.pw_uid)

    shutil.copy2(src, dst)


for user in pwd.getpwall():
    if user.pw_uid < 1000:
        continue

    home = user.pw_dir

    if not os.path.isdir(home):
        continue

    pwuid = user.pw_uid

    if os.path.exists(os.path.join(home, ".config", "cobalt", "common")):
        with open(os.path.join(home, ".config", "cobalt", "common"), "r") as f:
            ignored_paths = json.load(f)["ignored"]

    for item in os.listdir(SOURCE_DIR):
        src = os.path.join(SOURCE_DIR, item)
        dst = os.path.join(home, item)

        if os.path.isdir(src):
            shutil.copytree(src, dst, dirs_exist_ok=True, copy_function=copy_check)
        else:
            copy_check(src, dst)        

    binds.update(home)

    