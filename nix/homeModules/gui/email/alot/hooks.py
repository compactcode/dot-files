# Adapted from https://github.com/pazz/alot/wiki/Contrib-Hooks#open-html-emails-in-external-browser

import alot
import tempfile
import webbrowser
from alot.helper import string_sanitize
from alot.helper import string_decode

# Helper method to extract the raw html part of a message. Note that it
# only extracts the first text/html part found.
def _get_raw_html(msg):
    mail = msg.get_email()

    for part in mail.walk():
        ctype = part.get_content_type()

        if ctype != "text/html":
            continue

        cd = part.get('Content-Disposition', '')

        if cd.startswith('attachment'):
            continue

        enc = part.get_content_charset() or 'utf-8'

        raw = string_decode(part.get_payload(decode=True), enc)

        return string_sanitize(raw), enc

    return None, None


# Opens HTML emails in an external browser.
# Related issue:
#  - https://github.com/pazz/alot/issues/1153
def open_in_browser(ui=None):
    ui.notify("Opening message in browser...")
    msg = ui.current_buffer.get_selected_message()

    htmlstr, enc = _get_raw_html(msg)

    if htmlstr == None:
        ui.notify("Email has no html part")
        return

    temp = tempfile.NamedTemporaryFile(prefix="alot-",suffix=".html",
                                       delete=False)
    temp.write(htmlstr.encode(enc))
    temp.flush()
    temp.close()
    webbrowser.open(temp.name)
