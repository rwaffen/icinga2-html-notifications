# icinga2-html-notifications
HTML Notifications for Icinga2

Add ``mail-host.rb`` and ``mail-service.rb`` to ``/etc/icinga2/scripts``.
Update the Icinga2 definition of the Mail Command in ``/etc/icinga2/conf.d/commands.conf``.

Mail Script for Hosts
```
/* Command objects */

object NotificationCommand "mail-host-notification" {
  import "plugin-notification-command"

  command = [ SysconfDir + "/icinga2/scripts/mail-host.rb" ]

  env = {
    NOTIFICATIONTYPE = "$notification.type$"
    HOSTALIAS = "$host.display_name$"
    HOSTADDRESS = "$address$"
    HOSTNAME = "$host.name$"
    HOSTSTATE = "$host.state$"
    LONGDATETIME = "$icinga.long_date_time$"
    HOSTOUTPUT = "$host.output$"
    NOTIFICATIONAUTHORNAME = "$notification.author$"
    NOTIFICATIONCOMMENT = "$notification.comment$"
    HOSTDISPLAYNAME = "$host.display_name$"
    USEREMAIL = "$user.email$"
    ICINGA2_HOST = "icinga2.example.com"
    ZONE = "$host.zone$"
  }
}
```

Mail Script for Services
```
object NotificationCommand "mail-service-notification" {
  import "plugin-notification-command"

  command = [ SysconfDir + "/icinga2/scripts/mail-service.rb" ]

  env = {
    NOTIFICATIONTYPE = "$notification.type$"
    SERVICEDESC = "$service.name$"
    HOSTALIAS = "$host.display_name$"
    HOSTADDRESS = "$address$"
    HOSTNAME = "$host.name$"
    SERVICESTATE = "$service.state$"
    LONGDATETIME = "$icinga.long_date_time$"
    SERVICEOUTPUT = "$service.output$"
    NOTIFICATIONAUTHORNAME = "$notification.author$"
    NOTIFICATIONCOMMENT = "$notification.comment$"
    HOSTDISPLAYNAME = "$host.display_name$"
    SERVICEDISPLAYNAME = "$service.display_name$"
    USEREMAIL = "$user.email$"
    ICINGA2_HOST = "icinga2.example.com"
    ZONE = "$host.zone$"
  }
}
```
