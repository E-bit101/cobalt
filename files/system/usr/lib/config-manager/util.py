import json

def combineJson(old_json, incoming_json):
    old = json.loads(old_json)
    incoming = json.loads(incoming_json)

    # begin with the contents of old
    combined = dict(old)

    for key, value in incoming.items():
        if type(value) == list and key in combined and type(combined[key]) == list:
            combined[key].extend(value)
        else:
            combined[key] = value
    return combined

def replace_section(text, section, content):
    """
        Replaces all text between a pair of "--- SECTION ---" and "--- END ---" tags
        
        `text`:    the text to replace the section in
        `section`: the section name (must be uppercase in the file)
        `content`: the content to replace the section

        `returns`: `text` with the section replaced
    """
    
    begin = text.find(f"--- {section.upper()} ---") + len(f"--- {section} ---")
    end = text[begin:].find(f"// --- END ---") + begin

    if end == begin - 1:
        end = text[begin:].find(f"--- END ---") + begin

    return text[:begin] + f"\n{content}\n" + text[end:]

def set_niri_property(text, property_path, value, append=False):
    """
        Sets a property in a niri `config.kdl` file

        `text`: the contents of the niri `config.kdl` file
        `property_path`: the path of the property to change seperated by "."
            for example: `animations` or `layout.border.width`
        `value`: the value the property should be set to
            with `append=True` this represents the final property name as well
        `append`: Should the value be appended to the path (True) or should it be modified (False)

        `returns`: `text` with the property modified
    """
    if append:
        property_path += " {"

    property_path = property_path.replace(".", " {.").split(".")
    begin = 0
    
    for i in property_path:
        begin += text[begin:].find(i) + len(i)
        if begin == len(i) - 1:
            print(f"Could not set property {property_path}")
            return text

    end = begin
    while end < len(text) and text[end] != "\n":
        end += 1

    if append:
        return text[:end] + f"\n{'\t' * len(property_path)}{value}" + text[end:]
    else:
        return text[:begin] + f" {value}" + text[end:]

def set_hypr_property(text, property_path, value, append=False):
    """
        Sets a property in a hyprland `hyprland.lua` file

        `text`: the contents of the hyprland `hyprland.lua` file
        `property_path`: the path of the property to change seperated by "." and in-property json fields seperated by ":"
            for example: `hl.config:general:border_size` or `hl.env`
        `value`: the value the property should be set to. Include quotes ("") for strings
            with `append=True` this represents the final property name as well
        `append`: Should the value be appended to the path (True) or should it be modified (False)

        `returns`: `text` with the property modified
    """
    if append:
        if ":" in property_path:
            t = " = {".join(property_path.split(":")[1:])
            return text + "\n" + property_path.split(":")[0] + "( { " + f"{t} = {value}" + "} " * len(property_path.split(":")) + ")"
        else:
            return text + f"{property_path}( {value} )"

    if ":" in property_path:
        property_path = property_path.split(":") + ["="]
        begin = 0
        
        for i in property_path:
            begin += text[begin:].find(i) + len(i)
            print(text[begin-2:begin+2])
            if begin == len(i) - 1:
                print(f"Could not set property {property_path}")
                return text

        end = begin

        while end < len(text) and text[end] != ",":
            end += 1

    begin = text.find(property_path + "(") + len(property_path + "(")
    end = text[begin:].find(")\n") + begin

    print(text[begin:end])

    return text[:begin] + f"{value}" + text[end:]