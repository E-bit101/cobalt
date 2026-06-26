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