{ config, pkgs, ... }:
let
  contactsUuid = "ee85de46-1923-44ff-aa47-1494baa7cc4c";
in
{
  home.packages = with pkgs; [
    (import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz";
    }) {}).khal
    khard
    vdirsyncer
  ];

  xdg.configFile = {
    "vdirsyncer/config".text = ''
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
    '';

    "khal/config".text = ''
      [calendars]

      [[calendar_local]]
      path = ~/${config.xdg.dataHome}/calendar/*
      type = discover

      [[contacts_local]]
      path = ~/${config.xdg.dataHome}/contacts/${contactsUuid}/
      type = birthdays

      [locale]
      timeformat = %H:%M
      dateformat = %Y-%m-%d
      longdateformat = %Y-%m-%d
      datetimeformat = %Y-%m-%d %H:%M
      longdatetimeformat = %Y-%m-%d %H:%M
    '';

    "khard/khard.conf".text = ''
      [addressbooks]
      [[personal]]
      path = ~/${config.xdg.dataHome}/contacts/${contactsUuid}/

      [general]
      debug = no
      default_action = list
      editor = nvim, -i, NONE
      merge_editor = nvim, -d

      [contact table]
      display = first_name
      group_by_addressbook = no
      reverse = no
      show_nicknames = yes
      show_uids = no
      sort = last_name
      localize_dates = yes
      preferred_phone_number_type = pref, cell, home
      preferred_email_address_type = pref, home, work

      [vcard]
      private_objects = Jabber,
      preferred_version = 3.0
      search_in_source_files = no
      skip_unparsable = no
    '';
  };
}