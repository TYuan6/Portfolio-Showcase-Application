ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app58327188@heroku.com',
  :password       => '1qaqwsw05726',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

