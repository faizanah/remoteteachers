
# server = BbbServer.create!({url: 'http://test-install.blindsidenetworks.com/bigbluebutton/', name: 'Test Server', secret: '8cd8ef52e8e101574e400365b55e11a6'})
# user = User.create!({name: 'Faizan Ah',provider: 'greenlight', email: 'faizuali4@gmail.com', password: '1234zxcv', role: 'admin', status: 'accepted', bbb_server_id: server.id})
# server.user_id = user.id
# server.save
# # AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
# AdminUser.create!(email: 'faizuali4@gmail.com', password: 'password', password_confirmation: 'password')
# AdminUser.create!(email: 'jfeuzeu@hotmail.com', password: 'password', password_confirmation: 'password')
#
# user = User.create!({name: 'Faizan Ah',provider: 'greenlight', email: 'faizuali4+4@gmail.com', password: '1234zxcv', role: 'admin'})

site = Site.new
site.name = "Remote Teachers"
site.domain_url = "https://vcmgt.remoteteachers.com"
site.privacy_and_policy_url = ""
site.terms_and_condition_url = ""
site.save!
