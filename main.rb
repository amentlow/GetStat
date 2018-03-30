
require 'rubygems'
require 'telegram/bot'

token = '577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck'

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
    when '/end'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
    else
      bot.api.send_message(chat_id: message.chat.id, text: " everyone is gay, except alexander moiseev ")
    end
  end
end