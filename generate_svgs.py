import os

os.makedirs("assets", exist_ok=True)

svgs = {
    "home.svg": '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>''',
    "combat.svg": '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m14.5 12.5-8 8a2.12 2.12 0 1 1-3-3l8-8"/><path d="m16 16 6-6"/><path d="m8 8 6-6"/><path d="m9 7 8 8"/></svg>''',
    "esp.svg": '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7Z"/><circle cx="12" cy="12" r="3"/></svg>''',
    "generator.svg": '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"/></svg>''',
    "teleport.svg": '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="3 11 22 2 13 21 11 13 3 11"/></svg>''',
    "settings.svg": '''<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12.22 2h-.44a2 2 0 0 0-2 2v.18a2 2 0 0 1-1.45 1.92l-.41.11a2 2 0 0 1-2.33-1.07l-.22-.39a2 2 0 0 0-2.6-.74l-.38.22a2 2 0 0 0-.74 2.6l.22.38a2 2 0 0 1-1.07 2.33l-.11.41a2 2 0 0 1-1.92 1.45H2a2 2 0 0 0-2 2v.44a2 2 0 0 0 2 2h.18a2 2 0 0 1 1.92 1.45l.11.41a2 2 0 0 1-1.07 2.33l-.38.22a2 2 0 0 0-.74 2.6l.22.38a2 2 0 0 0 2.6.74l.41-.11a2 2 0 0 1 2.33 1.07l.11.41a2 2 0 0 1 1.45 1.92V22a2 2 0 0 0 2 2h.44a2 2 0 0 0 2-2v-.18a2 2 0 0 1 1.45-1.92l.41-.11a2 2 0 0 1 2.33 1.07l.22.39a2 2 0 0 0 2.6.74l.38-.22a2 2 0 0 0 .74-2.6l-.22-.38a2 2 0 0 1 1.07-2.33l.11-.41a2 2 0 0 1 1.92-1.45H22a2 2 0 0 0 2-2v-.44a2 2 0 0 1-2-2h-.18a2 2 0 0 1-1.92-1.45l-.11-.41a2 2 0 0 1 1.07-2.33l.38-.22a2 2 0 0 0 .74-2.6l-.22-.38a2 2 0 0 0-2.6-.74l-.41.11a2 2 0 0 1-2.33-1.07l-.11-.41A2 2 0 0 1 12.44 2.18V2z"/><circle cx="12" cy="12" r="3"/></svg>'''
}

for name, content in svgs.items():
    with open(os.path.join("assets", name), "w", encoding="utf-8") as f:
        f.write(content)

print("SVGs generated successfully.")
