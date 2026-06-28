from util import set_niri_property
import os

def update(home_dir, config, config_niri, config_hypr):
    """
        Update the keybinds in the niri and hyprland configs

        `home_dir`: user home directory where the configs are
        `config`: the global JSON config as a dict
        `config_niri`: the global niri specific config as a dict
        `config_hypr`: the global niri specific config as a dict
    """
    hypr_config_dir = os.path.join(home_dir, ".config", "hypr", "hyprland.lua")
    niri_config_dir = os.path.join(home_dir, ".config", "niri", "config.kdl")

    with open(niri_config_dir, "r") as f:
        text = f.read()
        if config["lookAndFeel"]["animationSpeed"] <= 0:
            text = set_niri_property(text, "animations", "off", append=True)
        else:
            text = set_niri_property(text, "animations.slowdown", 100 / config["lookAndFeel"]["animationSpeed"])

    with open(niri_config_dir, "w") as f:
        f.write(text)

    with open(hypr_config_dir, "r") as f:
        text = f.read()
        if config["lookAndFeel"]["animationSpeed"] <= 0:
            text = set_hypr_property(text, "hl.config:animations:enabled", "False")

    with open(hypr_config_dir, "w") as f:
        f.write(text)