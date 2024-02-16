{ config, contactsUuid }: ''
[general]
status_path = "${config.xdg.configHome}/vdirsyncer/status/"

[storage contacts_nosync]
type = "filesystem"
path = "~/${config.xdg.dataHome}/contacts/nosync"
fileext = ".vcf"

[pair calendar_vcs]
a = "calendar_vcs_local"
b = "calendar_vcs_remote"
collections = ["from a", "from b"]
metadata = ["displayname"]

[storage calendar_vcs_local]
type = "filesystem"
path = "~/${config.xdg.dataHome}/calendar/vcs"
fileext = ".ics"

[storage calendar_vcs_remote]
type = "http"
url = https://outlook.office365.com/owa/calendar/43a1fb8b0a254f669df0ebf9b1097037@volvocars.com/19e96e8d19f24987b2a8348ffb4323042737759542241723415/calendar.ics

[pair calendar_swedish_holidays]
a = "calendar_swedish_holidays_local"
b = "calendar_swedish_holidays_remote"
collections = ["from a", "from b"]
metadata = ["displayname"]

[storage calendar_swedish_holidays_local]
type = "filesystem"
path = "~/${config.xdg.dataHome}/calendar/swedish_holidays"
fileext = ".ics"

[storage calendar_swedish_holidays_remote]
type = "http"
url = https://www.webcal.guru/sv-SE/ladda_ner_kalendern?calendar_instance_id=86
''