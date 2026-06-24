import os

def update(home_dir):
    config_dir = os.path.join(home_dir, ".config")

    with open("/etc/sddm.conf.d/theme.conf", "w") as f:
        f.write("[Theme]\nCurrent=elarun")