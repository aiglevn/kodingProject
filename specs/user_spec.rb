require_relative "../spec/spec_helper.rb"
require_relative "../controllers/user-ctrl.rb"

RSpec.describe "testing user controller ====>>>>" do

	# Init Class
	def app
		UsersServices.new
	end

  	before(:each) do
      @user_id = 1 # 1

      @newIdIndex = 1
      #@newUser = { username: "NewUser_#{@newIdIndex}", email: "newuser_#{@newIdIndex}@gmail.com" }      
      @deletedUserId = 8
  	end
    
    describe 'get 1 user =>' do			  
		# GET /user/:id
	    it 'should return a single user' do
	      get "/user/#{@user_id}"
	      #last_response.status.should == 200
	      expect(last_response).to be_ok

	      user = JSON.parse(last_response.body)
	      #expect(user['username']).to eq 'female.0.0.1'
	      #expect(user['email']).to eq '_14_50_13@g.com'
	    end
	end

	describe "DELETE /user/:id/delete =>" do
		context "When User have NOT Photo =>" do
			it "delete a user" do	    	
		      delete "/user/#{@deletedUserId}/delete"
		      expect(last_response.status).to eq(202)      
		    end
		end
	    context "When User have Photo =>" do
	    	it "delete a user NOT Successful" do	    	
		      delete "/user/1/delete"
		      expect(last_response.status).to eq(400)	      
		    end
		end
	end

	describe "PUT on /user/:id/update =>" do
	    it "should update a user" do
	    	
	      put "/user/#{@user_id}/update", { gender: 1 }  # giong nhu: { :gender => 1 } ; { "gender" => 1 }
	      expect(last_response.status).to eq(202)
	      #expect(last_response).to be_ok

	      # lay du lieu tu DB
	      get "/user/#{@user_id}"
	      user = JSON.parse(last_response.body)
	      #expect(user['gender']).to eq true
	    end
	end

	describe "PUT on /user/:id/update =>" do
	    it "should update Gender = 3 to a user => will ERROR" do
	    	
	      put "/user/#{@user_id}/update", { gender: 3 }
	      #expect(last_response.body).to eq(("truyen sai tham so Gender, gender chi duoc la 0 hoac 1").to_json)
	      expect(last_response.status).to eq(400)
	    end
	end

	describe "POST on /user/new =>" do
		let!(:newUser) { { username: "NewUser_#{@newIdIndex}", email: "newuser_#{@newIdIndex}@gmail.com" } }
	    it "should create a user" do		      
	      post '/user/new', newUser  # @newUser
	      #expect(last_response).to be_ok
	      expect(last_response.status).to eq(202)

	      user = JSON.parse(last_response.body) # last_response.body tra ve nhung thu duoc return o ham POST
	      # Chu y: chi get ve duoc tu "last_response.body" nhung param da return o ham POST
	      #expect(user['res_u_name']).to eq "NewUser_#{@newIdIndex}"
	    end

	end
      
	describe "POST on /user/new =>" do
	    it "try create am EXISTS user => will ERROR" do	      
	      #pending "> Tam thoi bo qua, ko test case nay."
	      post '/user/new', { username: "male01", email: "" }
	      expect(last_response.status).to eq(400)
	    end

	end

end

