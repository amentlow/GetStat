
require 'rubygems'
require 'telegram/bot'
require 'roo'
require 'net/http'
require 'tempfile'

token = '577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck'

Telegram::Bot::Client.run(token,logger: Logger.new($stderr)) do |bot|
	 bot.logger.info('Bot has been started')
  bot.listen do |message|

case message
    when Telegram::Bot::Types::CallbackQuery
      puts 'cquery';
    end

    case message.text
      when 't'
      bot.api.send_message(chat_id: message.chat.id, text: "test passed, bot is ready !")


# ruby docs temp file
# myfile  = File.new("simple_file.html", "w+")
myfile = Tempfile.new(['simple_file', '.html'])

File.open(myfile, "w") do |f|
    f.write "<h1>some data</h1>"
end
puts message.chat.id
puts myfile.path 
puts myfile.readline
puts "curl -F chat_id=\"260337622\" -F document=@\"#{myfile.path}\" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument"
system("curl -F chat_id=\"260337622\" -F document=@\"#{myfile.path}\" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument")

 # bot.api.send_document(chat_id: message.chat.id, document: myfile)
 # myfile.close
       when 'opt 1'
      bot.api.send_message(chat_id: message.chat.id, text: "you say opt 1!")

    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, start!", parse_mode:"HTML")
    when '/end'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")

 
    else
		if(message.document)
    		bot.api.sendMessage(chat_id: message.chat.id, text: "Hello darlong")

system('curl -v -F chat_id="260337622" -F document=@"/Users/alexandermoiseev/RubyOnRails/2.html" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument')
puts '_______'
puts message.chat.id
puts '_______'


# bot.api.sendDocument(chat_id: message.chat.id, document: 'BQADAgADMQEAAnYlaEoe5FHDeLzaXgI')
        

puts 'str to get file path'
puts "https://api.telegram.org/bot#{token}/getFile?file_id=#{message.document.file_id}"


uri = URI("https://api.telegram.org/bot#{token}/getFile?file_id=#{message.document.file_id}")
dssd = Net::HTTP.get(uri) # => String

puts 'str to file path'
puts "https://api.telegram.org/file/bot#{token}/documents/file_4.xlsx"


  path = "Hello, #{message.chat.type}!"




    	else
    

    		bot.api.send_message(chat_id: message.chat.id, text: "test", reply_markup:"{\"keyboard\":[[\"opt 1\",\"opt 2\",\"opt 3\"],[\"menu\"]],\"resize_keyboard\":true, \"one_time_keyboard\":true}")
    end
end
  end
end