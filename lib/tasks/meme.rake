def load_twilio
  # set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new TWILIO_ACC_SID, TWILIO_AUTH_TOKEN
end

def sendMemes (person, line)
  load_twilio

  @name = person.name
  @phone_number = person.number
  message = "Hey #@name, here is your meme for the day. "
  image_url = line
  @message = @client.account.messages.create(
                                            from: '+19147684531',
                                            to: @phone_number,
                                            body: message,
                                            media_url: image_url
                                            )
 puts "Sent message to #@name"
end



# set up rake task to send memes
task :meme => :environment do
count = 1
File.open('lib/tasks/memes.txt').each do |line|
  users = User.all
  users.each do |user|
    sendMemes(user, line)
    puts "Sent meme on line #{count}..."
    puts "done."
  end
  count = count + 1
  end
end
