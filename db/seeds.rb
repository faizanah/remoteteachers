# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# server = BbbServer.create!({url: 'http://test-install.blindsidenetworks.com/bigbluebutton/', name: 'Test Server', secret: '8cd8ef52e8e101574e400365b55e11a6'})
# user = User.create!({name: 'Faizan Ah',provider: 'greenlight', email: 'faizuali4+22@gmail.com', password: '1234zxcv', role: 'admin', status: 'accepted', bbb_server_id: server.id})
# server.user_id = user.id
# server.save
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
AdminUser.create!(email: 'faizuali4@gmail.com', password: 'password', password_confirmation: 'password')
AdminUser.create!(email: 'jfeuzeu@hotmail.com', password: 'password', password_confirmation: 'password')