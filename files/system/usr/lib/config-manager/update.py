import os
import pwd
import shutil

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

    with open("/etc/sddm.conf.d/theme.conf", "w") as f:
        f.write(
"""[Theme]
Current=elarun"""
        )