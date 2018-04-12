
require 'rubygems'
require 'telegram/bot'
require 'roo'
require 'net/http'
require 'json'


# curl -F chat_id="260337622" -F document=@"Users/alexandermoiseev/RubyOnRails/2.html" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument

token = '577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck'

def handle_callback2
  puts 'handle_callback2'
end

# def handle_callback(bot, message)
#   puts 'handle_Real_callback'
# end
 
def handle_location(bot, message)
   buttons = [
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text: 'przystanek', 
      callback_data: {
        'type' => 'bus',
        'lat' => message.text, 
        'lng' => message.text
      }.to_json
    ),
    Telegram::Bot::Types::InlineKeyboardButton.new(
      text: 'pogoda', 
      callback_data: {
        'type' => 'weather',
        'lat' => message.text, 
        'lng' => message.text
      }.to_json
    ),
  ]
  markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: buttons)
  bot.api.send_message(
    chat_id: message.chat.id, 
    text: 'Co chcesz uzyskać?', 
    reply_markup: markup)
end

def handle_callback(bot, message)
  # order = JSON.parse(message.data)
    bot.api.send_message(
      chat_id: message.from.id, 
      text: "callback",
      parse_mode: 'Markdown')

end



Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
   bot.logger.info('Bot has been started2')
   bot.listen do |message|
    puts 'pizda!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    # begin 

  case message
    when Telegram::Bot::Types::InlineQuery
      puts 'inline comes'
      puts message.query
      puts 'inline goes'
  when Telegram::Bot::Types::CallbackQuery
    # Here you can handle your callbacks from inline buttons
    if message.data == 'touch'
      # puts message.message.text
      # puts message.message.message_id

      # if(message.message.message_id != nil)
      #   bot.api.editMessageText(chat_id: message.message.chat.id, message_id: message.message.message_id, text: "sdok")
      # else
      #   puts 'data is nil'
      # end
       bot.api.send_message(chat_id: message.message.chat.id, text: "Don't touch me!")
       bot.api.answerCallbackQuery(callback_query_id: message.id, text: message.data, show_alert:false)
    end
  when Telegram::Bot::Types::Message
    kb = [
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Stay here', switch_inline_query_current_chat: 'enter location:'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
      Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Switch to inline', switch_inline_query: '')
    ]
    markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard:true)
    bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
  end

  # rescue  
  #   puts 'I am rescued.'  
  # end 


end

#   bot.listen do |message|

# case message
#       when Telegram::Bot::Types::CallbackQuery
# puts message.class
# puts message.inline_message_id
#         # handle_callback(bot, message)
#         if(message.inline_message_id != nil && message.inline_message_id > 1)
#           puts message.message_id
#           bot.api.editMessageText(inline_message_id: message.inline_message_id, text: "sdasds")
#         end

#          # bot.api.answerCallbackQuery(callback_query_id: message.id, text:"test text", show_alert:false)
#       when Telegram::Bot::Types::Message
#         case message.text
#         when '/s'
#           bot.api.send_message(chat_id: message.chat.id, text: "Wyślij swoją lokalizację aby otrzymać oraz", parse_mode: 'Markdown')
#       when '/t'
#           handle_location(bot, message)
#       end
        
#       end
      
# end
 end










 #         workbook = Roo::Spreadsheet.open "https://api.telegram.org/file/bot#{token}/documents/file_4.xlsx"
# worksheets = workbook.sheets
# puts "Found #{worksheets.count} worksheets"

# worksheets.each do |worksheet|
#   puts "Reading: #{worksheet}"
#   num_rows = 0
#   workbook.sheet(worksheet).each_row_streaming do |row|
#     row_cells = row.map { |cell| cell.value }
#     num_rows += 1
#   end
#   puts "Read #{num_rows} rows" 
# end



  
