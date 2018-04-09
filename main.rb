
require 'rubygems'
require 'telegram/bot'
require 'roo'
require 'net/http'

token = '577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck'

Telegram::Bot::Client.run(token,logger: Logger.new($stderr)) do |bot|
	 bot.logger.info('Bot has been started')
  bot.listen do |message|

case message
    when Telegram::Bot::Types::CallbackQuery
      puts 'cquery';
    end

    case message.text
      when 'test'
      bot.api.send_message(chat_id: message.chat.id, text: "test passed, bot is ready !")

       when 'opt 1'
      bot.api.send_message(chat_id: message.chat.id, text: "you say opt 1!")

    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, start!", parse_mode:"HTML")
    when '/end'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")

 
    else
		if(message.document)
    		bot.api.send_message(chat_id: message.chat.id, text: "Hello darlong")
puts token

puts 'str to get file path'
puts "https://api.telegram.org/bot#{token}/getFile?file_id=#{message.document.file_id}"


uri = URI("https://api.telegram.org/bot#{token}/getFile?file_id=#{message.document.file_id}")
dssd = Net::HTTP.get(uri) # => String

puts dssd


puts 'str to file path'
puts "https://api.telegram.org/file/bot#{token}/documents/file_4.xlsx"


  path = "Hello, #{message.chat.type}!"
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






    	else
    

    		bot.api.send_message(chat_id: message.chat.id, text: "test", reply_markup:"{\"keyboard\":[[\"opt 1\",\"opt 2\",\"opt 3\"],[\"menu\"]],\"resize_keyboard\":true, \"one_time_keyboard\":true}")
    end
end
  end
end