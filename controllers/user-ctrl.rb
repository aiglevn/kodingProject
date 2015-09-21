$LOAD_PATH << '.'
require_relative '../models/user.rb'
# require "rubygems"
# require 'sinatra'
require 'sinatra/base'
require 'json' 
require 'erb'
require 'debugger'
require 'pry'

class UsersServices < Sinatra::Base
	########
	#set :port, 8080
	set :environment, :production
	#set :static, true
	# sets root as the parent-directory of the current file
	set :root, File.join(File.dirname(__FILE__), '..')
	# sets the view directory correctly
	set :views, Proc.new { File.join(root, "views") } 
	########

	# Listing get
	get '/comments' do
		content_type :json, :charset => 'utf-8'
		comment = Comments.all

		if comment && comment != []
		    comment.to_json 
		else
		    error 404, {:error => "Comments table is empty"}.to_json 
		end

	end

	# Listing ALL User
	get '/users' do
		content_type :json, :charset => 'utf-8'
		user = Users.all
		
		if user && user != []
		    user.to_json 
		else
		    error 404, {:error => "Users table is empty"}.to_json 
		end

	end

	# Get User by ID
	get '/user/:id' do
		content_type :json, :charset => 'utf-8'
		user = Users.find(:id => params[:id])
		if user
		    user.to_json 
		else
		    error 404, {:error => "user not found"}.to_json 
		end

		#erb :'index' # dung template la file views/index.erb
	end

	# Get User by Username, Email
	get '/user/:username/:email' do
		content_type :json, :charset => 'utf-8'
		userjson = getUserByUsernameAndEmail(params[:username], params[:email])
	    if userjson != nil # da ton tai
	    	userjson
		else
		    error 404, {:error => "user not found"}.to_json 
		end
	end

	def getUserByUsernameAndEmail(username, email)
		user = Users.find(:username => username.to_s, :email => email.to_s)
		if user
		    return user.to_json 
		else
		    return nil 
		end
	end

	# Edit user - update Gender
	put '/user/:id/update' do
		content_type :json, :charset => 'utf-8'

		#debugger
		#binding.pry

		jdata = JSON.parse(params.to_json,:symbolize_names => true) 
		user = Users.find(:id => params[:id])
		
		if user
		    begin
		      	if jdata.has_key?(:gender)					
					if(params[:gender].to_s != "0" && params[:gender].to_s != "1")
						error 400, ("truyen sai tham so Gender, gender chi duoc la 0 hoac 1").to_json
					else
						user.gender = params[:gender]
					end
				end				
				user = user.save_changes
				status 202
		      	user.to_json

			    rescue => e
			      error 400, ("system error: " + e.message).to_json
		    end
		else
		    error 404, "user not found".to_json
		end
		
		#redirect to ("/user#{@user.id}")
		# p @user
		# @user.to_json

	end

	# Delete user
	delete '/user/:id/delete' do
		content_type :json, :charset => 'utf-8'
		user = Users.find(:id => params[:id])
		
		#p 'User has been deleted'
		#p @user
		#@user.to_json
		if user
			begin
				if user.photo != nil
					error 400, ("khong the xoa User da co Photo").to_json
				end

				user = user.delete
				
				status 202 # spec: expect(last_response.status).to eq(202)
				user.to_json

			  	rescue => e
			      error 400, ("system error: " + e.message).to_json
		  	end 
	  	else
		    error 404, "user not found".to_json
		end
	end

	# Create new user
	post '/user/new' do
		content_type :json, :charset => 'utf-8'
		jdata = JSON.parse(params.to_json,:symbolize_names => true)

		# check username va email da ton tai
		checkuser = getUserByUsernameAndEmail(params[:username], params[:email])
		#user = JSON.parse(last_response.body)
	    if checkuser == nil # chua ton tai

	    	newUser = Users.load(
							:username=>params[:username],
							:email=>params[:email]
							)
			begin
				newId = Users.insert(newUser)
				if newId
				  status 202
			      { newUserId: newId, res_u_name: params[:username] }.to_json
			    else
			      error 400, ">>> error: can not insert".to_json
			    end
			  	rescue => e
			      error 400, ("SYSTEM ERROR: " + e.message).to_json
		  	end

	    else	
	    	error 400, ">>> error: username va email da ton tai, ko the insert".to_json
	    end
	    		
	end

end