require 'rails_helper'

RSpec.describe Api::V1::BabysittersController, type: :controller do

	before(:all) do
    load "#{Rails.root}/db/seeds.rb" 
	end
	
	after(:all) do
		Babysitter.destroy_all
	end

	describe "GET #index" do

		context "when second pagination happens after one new record in entered to database" do # для проверки правильности работы самой cursor pagination
	
			it "should return two arrays with no duplicate id" do
				get :index, params: {direction:"forward", end_cursor: ""}, format: :json
				responce_hash = JSON.parse(response.body)
				end_cursor = responce_hash["end_cursor"]
				first_page_ids = responce_hash["babysitters"].pluck("id")
				post :create, params: {first_name:"Hi", last_name: "Hi"}, format: :json
				get :index, params: {direction:"forward", end_cursor: end_cursor}, format: :json
				responce_hash = JSON.parse(response.body)
				second_page_ids = responce_hash["babysitters"].pluck("id")
				duplicate_ids = first_page_ids & second_page_ids
				expect(duplicate_ids.count).to eq(0)
			end
	
		end
			
	end

	describe "POST #create" do

		context "when first_name is empty" do
	
			it "should not be saved" do
				post :create, params: {first_name: "", last_name: ""}, format: :json
				expect(response.body["errors"].present?).to be(true)
			end
	
		end
	
		context "when first_name is not empty" do
				
			it "should be saved" do
				post :create, params: {first_name: "Juma", last_name:""}, format: :json
				expect(response.body["errors"].present?).to be(false)
			end
		end
		
	end

end
