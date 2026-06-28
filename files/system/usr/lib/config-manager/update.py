import os, pwd, shutil
import updateBinds as binds
import updateCompositors as compositors
import json

SOURCE_DIR = "/etc/dotfiles"
ignored_paths = []
pwuid = 0
config = None

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

    if os.path.exists(os.path.join(home, ".config", "cobalt", "common.json")):
        with open(os.path.join(home, ".config", "cobalt", "common.json"), "r") as f:
            config = json.load(f)
            ignored_paths = config["ignored"]

    hypr_config_dir = os.path.join(home, ".config", "hypr", "hyprland.lua")
    niri_config_dir = os.path.join(home, ".config", "niri", "config.kdl")

    if os.path.exists(hypr_config_dir):
        with open(os.path.join(home, ".config", "cobalt", "niri.json"), "r") as f:
            config_niri = json.load(f)

    if os.path.exists(niri_config_dir):
        with open(os.path.join(home, ".config", "cobalt", "hypr.json"), "r") as f:
            config_hypr = json.load(f)

    for item in os.listdir(SOURCE_DIR):
        src = os.path.join(SOURCE_DIR, item)
        dst = os.path.join(home, item)

        if os.path.isdir(src):
            shutil.copytree(src, dst, dirs_exist_ok=True, copy_function=copy_check)
        else:
            copy_check(src, dst)        

    compositors.update(home, config, config_niri, config_hypr)
    binds.update(home, config, config_niri, config_hypr)

    