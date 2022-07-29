require "net/http"
require "sendgrid-ruby"
include SendGrid

from = Email.new(email: ENV['SEND_EMAIL'])
to = Email.new(email: ENV['RECV_EMAIL'])
subject = "page changed"
content = Content.new(type: 'text/plain', value: "it changed")

def send_em(mail)
  sg = SendGrid::API.new(api_key: ENV['API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
end

page =  Net::HTTP.get(URI ENV['WEBSITE']).to_s

while true
  if page != Net::HTTP.get(URI ENV['WEBSITE']).to_s
    send_em(Mail.new(from, subject, to, content))
    end
  sleep(1.day)
end
