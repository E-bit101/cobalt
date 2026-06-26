import json
from util import replace_section

HYPRLAND_KEY_SUBS = {
    "Shift": "SHIFT",
    "Ctrl": "CTRL",
    "Alt": "ALT",
    "WheelScrollDown": "mouse_down",
    "WheelScrollUp": "mouse_up",
    "Mod": "",
    "+": " + "
}


def niri_cmd(cmd):
    if cmd == "exit":
        return "quit"
    elif cmd == "maximize":
        return "maximize-column"
    elif cmd == "fullscreen":
        return "fullscreen-window"
    elif cmd == "floating":
        return "toggle-window-floating"
    elif cmd == "applyPreset":
        return "switch-preset-column-width"
    elif cmd == "close":
        return "close-window"
    elif cmd.startswith("workspace"):
        return cmd.replace("workspace", "focus-workspace ")
    elif cmd.startswith("moveToWorkspace"):
        return cmd.replace("moveToWorkspace", "move-column-to-workspace ")
    elif cmd == "prevWorkspace":
        return "focus-workspace-up"
    elif cmd == "nextWorkspace":
        return "focus-workspace-down"
    elif cmd == "prevWindow":
        return "focus-column-left"
    elif cmd == "nextWindow":
        return "focus-column-right"
        
    return "spawn-sh \"" + cmd + "\""


def hypr_cmd(cmd):
    if cmd == "exit":
        return 'hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch \'hl.dsp.exit()\'")'
    elif cmd == "maximize":
        return 'hl.dsp.window.fullscreen({ action = "toggle" })'
    elif cmd == "fullscreen":
        return 'hl.dsp.window.fullscreen({ action = "toggle" })'
    elif cmd == "floating":
        return 'hl.dsp.window.float({ action = "toggle" })'
    elif cmd == "applyPreset":
        return 'hl.dsp.layout("togglesplit"))'
    elif cmd == "close":
        return 'hl.dsp.window.close()'
    elif cmd.startswith("workspace"):
        return cmd.replace("workspace", 'hl.dsp.focus({ workspace = ') + '})'
    elif cmd.startswith("moveToWorkspace"):
        return cmd.replace("moveToWorkspace", 'hl.dsp.window.move({ workspace = ') + '})'
    elif cmd == "prevWorkspace":
        return 'hl.dsp.focus({ workspace = "e-1" })'
    elif cmd == "nextWorkspace":
        return 'hl.dsp.focus({ workspace = "e+1" })'
    elif cmd == "prevWindow":
        return 'hl.dsp.focus({ direction = "left" })'
    elif cmd == "nextWindow":
        return 'hl.dsp.focus({ direction = "right" })'

    return f"hl.dsp.exec_cmd(\"{cmd.replace("\"", "\\\"")}\")"


def hypr_subs(v):
    out = v

    for key, val in HYPRLAND_KEY_SUBS.items():
        out = out.replace(key, val)

    return out


def bind_to_command(bind, wm="niri"):
    key = list(bind)[0]
    action = bind[key]
    command = ""
    if wm.lower() == "niri":
        command = key + " { " + niri_cmd(action) + "; }"
    else:
        command = f"hl.bind({'mainMod .. ' if key.startswith("Mod") else ''}\"{hypr_subs(key)}\", "
        command += hypr_cmd(action)

    return command


def get_binds(code, result, wm="niri"):
    binds = []
    if "<number>" in code or "<number>" in result:
        for i in range(10):
            binds.append({code.replace("<number>", str(i)): result.replace("<number>", str(i))})
    else:
        binds.append({code: result})

    return binds

def update(home_dir):
    """
        Update the keybinds in the niri and hyprland configs

        `home_dir`: user home directory where the configs are
    """
    global_config_dir = os.path.join(home_dir, ".config", "cobalt", "common.json")
    hypr_config_dir = os.path.join(home_dir, ".config", "hypr", "hyprland.lua")
    niri_config_dir = os.path.join(home_dir, ".config", "niri", "config.kdl")

    with open(hypr_config_dir, "r") as f:
        config = json.load(f)

    binds = []
    for k, v in config["binds"].items():
        binds += get_binds(k, v)

    niri_binds = "\n"
    for i in binds:
        niri_binds += bind_to_command(i, "niri") + "\n"

    hypr_binds = "\n"
    for i in binds:
        hypr_binds += bind_to_command(i, "niri") + "\n"

    with open(hypr_config_dir, "r") as f:
        text = replace_section(f.read(), "keybinds", hypr_binds)
    with open(hypr_config_dir, "w") as f:
        f.write(text)

    with open(niri_config_dir, "r") as f:
        text = replace_section(f.read(), "keybinds", niri_binds)
    with open(niri_config_dir, "w") as f:
        f.write(text)