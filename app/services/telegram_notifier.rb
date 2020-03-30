class TelegramNotifier
  def self.call(text)
    HTTP.post("https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_KEY']}/sendMessage", json: {
      chat_id: ENV["TELEGRAM_CHAT_ID"],
      text: text
    })
  end
end
