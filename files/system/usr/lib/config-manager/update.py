import os, pwd, shutil
import updateHypr as hypr
import updateNiri as niri
import updateSddm as sddm
import updateQs as qs

SOURCE_DIR = "/etc/dotfiles"

for user in pwd.getpwall():
    if user.pw_uid < 1000:
        continue

    home = user.pw_dir

    if not os.path.isdir(home):
        continue

    for item in os.listdir(SOURCE_DIR):
        src = os.path.join(SOURCE_DIR, item)
        dst = os.path.join(home, item)

        if os.path.isdir(src):
            shutil.copytree(src, dst, dirs_exist_ok=True)
        else:
            shutil.copy2(src, dst)

        shutil.chown(dst, user.pw_uid)

    sddm.update(home)
    niri.update(home)
    hypr.update(home)
    qs.update(home)

    