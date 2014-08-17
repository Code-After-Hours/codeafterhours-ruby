require 'sinatra'
require 'pony'

set :public_folder, File.dirname(__FILE__) + '/public'

get '/' do
	#Main route
	send_file File.expand_path('index.html', settings.public_folder)
end

get '/done' do
	#route for done, this is served after sending an email
	send_file File.expand_path('done.html', settings.public_folder)
end

get '/bayamon' do
	#route for bayamon
	send_file File.expand_path('bay.html', settings.public_folder)
end

get '/sanjuan' do
	#route for San Juan
	send_file File.expand_path('sj.html', settings.public_folder)
end

#post for sending email
post '/send_email' do
  options = {
  :to => 'info@ens-labs.com',
  :from => params[:email],
  :subject => 'Code After hours',
  :body => params[:message],
  :via => :smtp,
  :via_options => {
    :address => 'smtp.sendgrid.net',
    :port => '587',
    :domain => 'heroku.com',
    :user_name => ENV['SENDGRID_USERNAME'],
    :password => ENV['SENDGRID_PASSWORD'],
    :authentication => :plain,
    :enable_starttls_auto => true
    }
  }
  
  Pony.mail(options)
  
  redirect '/done'
end

