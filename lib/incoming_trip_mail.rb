require 'mailman'

Mailman.config.pop3 = {
  server: 'pop.gmail.com', port: 995, ssl: true,
  username: "itinerarybuilder2017@gmail.com",
  password: "DLPclp397"
}

Mailman::Application.run do
  default do
    begin
      Trip.receive_mail(message)
    rescue Exception => e
      Mailman.logger.error "Exception occurred while receiving message:\n#{message}"
      Mailman.logger.error [e, *e.backtrace].join("\n")
    end
  end
end
