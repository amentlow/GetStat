require 'rubygems'
require 'telegram/bot'
require 'roo'
require 'net/http'
require 'json'


# curl -F chat_id="260337622" -F document=@"Users/alexandermoiseev/RubyOnRails/2.html" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument

token = '577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck'

def strip_or_self!(str)
  str.strip! || str if str
end

def is_final_request(message)
  false
end

Telegram::Bot::Client.run(token, logger: Logger.new($stderr)) do |bot|
  bot.logger.info('Bot has been started2')
  bot.listen do |message|

  Thread.start(message) do |message|
    puts 'pizda!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
    begin 
      case message
        when Telegram::Bot::Types::InlineQuery
          puts 'inline comes'
        
          results = [
            [1, 'Пушкинский муниципальный район', message.query + 'Пушкинский муниципальный район'],
            [2, 'г.о. Кашира', message.query +  'г.о. Кашира'],
            [3, 'г.о. Луховицы', message.query +  'г.о. Луховицы'],
            [4, 'г.о.Жуковский', message.query + 'г.о.Жуковский'],
            [5, 'Раменский муниципальный район', message.query +  'Раменский муниципальный район'],
            [6, 'Дмитровский муниципальный район', message.query +  'Дмитровский муниципальный район'],
            [7, 'Ленинский муниципальный район', message.query +  'Ленинский муниципальный район'],
            [8, 'КСМО', message.query +  'КСМО'],
            [9, 'Воскресенский муниципальный район', message.query + 'Воскресенский муниципальный район'],
            [99, 'Наро-Фоминск городской округ', message.query + 'Наро-Фоминск городской округ'],
            [23, 'Солнечногорский муниципальный  район', message.query + 'Солнечногорский муниципальный  район'],
            [22, 'Талдомский муниципальный район', message.query + 'Талдомский муниципальный район'],
            [21, 'Щёлковский муниципальный район', message.query + 'Щёлковский муниципальный район'],
            [24, 'г.о. Истра', message.query + 'г.о. Истра'],
            [25, 'г.о.Люберцы', message.query + 'г.о.Люберцы'],
            [26, 'Сергиево-Посадский  муниципальный район', message.query + 'Сергиево-Посадский  муниципальный район'],
            [27, 'г.о. Павловский Посад', message.query + 'г.о. Павловский Посад'],
            [28, 'г.о.Шатура', message.query + 'г.о.Шатура'],
            [29, 'Дмитровский муниципальный район', message.query + 'Дмитровский муниципальный район']
          ]

          puts message.query

          if message.query.include? ':'
            district_part = message.query[message.query.index(':') + 1, message.query.length]
            program_part = message.query[0, message.query.index(':') + 1]

            strip_or_self!(district_part)
            strip_or_self!(program_part)

            puts district_part
            puts program_part

            if district_part.length > 0
              results = results.select {|item|  item[1].downcase.include? district_part.downcase}
            end

            results2 =  results.map do |arr|
              Telegram::Bot::Types::InlineQueryResultArticle.new(
                id: arr[0], title: arr[1], input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(message_text: program_part + district_part)
              )
          end
        end

        bot.api.answer_inline_query(inline_query_id: message.id, results: results2, cache_time: '0')

      when Telegram::Bot::Types::CallbackQuery
        if message.data == 'touch'
          # if(message.message.message_id != nil)
          #   bot.api.editMessageText(chat_id: message.message.chat.id, message_id: message.message.message_id, text: "sdok")
          # else
          #   puts 'data is nil'
          # end
           bot.api.send_message(chat_id: message.message.chat.id, text: "Don't touch me!")
           bot.api.answerCallbackQuery(callback_query_id: message.id, text: message.data, show_alert:false)
        end
      when Telegram::Bot::Types::Message  
        if message.text == '/start'
      answers =
        Telegram::Bot::Types::ReplyKeyboardMarkup
        .new(keyboard: ["Start new query"], one_time_keyboard: false)
    bot.api.send_message(chat_id: message.chat.id, text: 'question', reply_markup: answers)
  end
       if is_final_request(message)
           bot.api.send_message(chat_id: message.chat.id, text: 'reply_to_message_idhere', reply_to_message_id: message.message_id)
        else

          kb = [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Чистая Вода', switch_inline_query_current_chat: 'Чистая Вода, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Системы водоотведения', switch_inline_query_current_chat: 'Системы водоотведения, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Создание условий для обеспечения качественными коммунальными услугами', switch_inline_query_current_chat: 'Создание условий для обеспечения качественными коммунальными услугами, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Энергосбережение и повышение энергетической эффективности на территории Московской области', switch_inline_query_current_chat: 'Энергосбережение и повышение энергетической эффективности на территории Московской области, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Развитие и модернизация электроэнергетики в Московской области', switch_inline_query_current_chat: 'Развитие и модернизация электроэнергетики в Московской области, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Развитие газификации в Московской области', switch_inline_query_current_chat: 'Развитие газификации в Московской области, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Развитие топливозаправочного комплекса в Московской области', switch_inline_query_current_chat: 'Развитие топливозаправочного комплекса в Московской области, район: '),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Обеспечивающая подпрограмма', switch_inline_query_current_chat: 'Обеспечивающая подпрограмма, район: ')
          ]
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb, resize_keyboard: true)
            bot.api.send_message(chat_id: message.chat.id, text: 'Make a choice', reply_markup: markup)
        end
      end

      rescue => e
        puts "Error during processing: #{$!}"
        puts "Backtrace:\n\t#{e.backtrace.join("\n\t")}"
      end

    end #   end of Thread
  end
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


# # ruby docs temp file
# myfile = Tempfile.new(['simple_file', '.html'])
# File.open(myfile, "w") do |f|
#     f.write "<h1>some data</h1>"
# def is_final_request(message)
#   message.text.include? "interesting"
# end
# puts message.chat.id
# puts myfile.path 
# puts myfile.readline
# puts "curl -F chat_id=\"260337622\" -F document=@\"#{myfile.path}\" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument"
# system("curl -F chat_id=\"260337622\" -F document=@\"#{myfile.path}\" https://api.telegram.org/bot577447618:AAHJwCZ51XLxik596Howxf2yVjcpixXMBck/sendDocument")

 # bot.api.send_document(chat_id: message.chat.id, document: myfile)
  
