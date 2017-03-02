#!/usr/bin/env ruby

require 'net/smtp'

sender = 'icinga2@example.com'
recipient = ENV['USEREMAIL']

state = ENV['HOSTSTATE']

case state
  when "DOWN"
    color = "danger"
  when "UP"
    color = "success"
  else
    color = "none"
end

message = <<MESSAGE_END
From: #{sender}
To: #{recipient}
MIME-Version: 1.0
Content-type: text/html
Subject: #{ENV['NOTIFICATIONTYPE']} - #{ENV['HOSTDISPLAYNAME']} is #{ENV['HOSTSTATE']}

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<br />
<div class="container">
  <table class="table table-striped table-bordered">
    <tr><td>Notification Type:</td><td>#{ENV['NOTIFICATIONTYPE']}</td></tr>
    <tr><td>Host:</td><td>#{ENV['HOSTALIAS']}</td></tr>
    <tr><td>Address:</td><td>#{ENV['HOSTADDRESS']}</td></tr>
    <tr class="#{color}"><td>State:</td><td>#{ENV['HOSTSTATE']}</td></tr>
    <tr><td>Date/Time:</td><td>#{ENV['LONGDATETIME']}</td></tr>
    <tr><td>Additional Info:</td><td>#{ENV['HOSTOUTPUT']}</td></tr>
    <tr><td>Comment:</td><td>[#{ENV['NOTIFICATIONAUTHORNAME']}] #{ENV['NOTIFICATIONCOMMENT']}</td></tr>
    <tr><td>Link:</td><td>http://#{ENV['ICINGA2_HOST']}/icingaweb2/monitoring/host/show?host=#{ENV['HOSTNAME']}</td></tr>
    <tr><td>Zone:</td><td>#{ENV['ZONE']}</td></tr>
  </table>
</div>
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, sender, recipient
end
