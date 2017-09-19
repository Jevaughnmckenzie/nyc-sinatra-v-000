class LandmarksController < ApplicationController

	get '/landmarks' do 
		@landmarks = Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/new' do
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'landmarks/new'
	end

	post '/landmarks' do
		# binding.pry
		landmark = Landmark.new(name: params[:landmark][:name])

		# if params[:title][:name].empty? && params[:figure][:title_ids].nil?
		# elsif !params[:title][:name].empty?
		# 	figure.titles.build(name: params[:title][:name])
		# else 
		# 	figure.titles << Title.find(params[:figure][:title_ids])
		# end

		# if params[:landmark][:name].empty? && params[:figure][:landmark_ids].nil?
		# elsif !params[:landmark][:name].empty?
		# 	figure.landmarks.build(name: params[:landmark][:name])
		# else 
		# 	figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
		# end

		landmark.year_completed = params[:landmark][:year_completed]

		landmark.save

		redirect '/landmarks'
	end

	get '/landmarks/:id' do
		
		@landmark = Landmark.find(params[:id])

		erb :'landmarks/show'
	end

	get '/landmarks/:id/edit' do
		@landmark = Landmark.find(params[:id])

		erb :'landmarks/edit'
	end

	patch '/landmarks/:id' do 
	
		landmark = Landmark.find(params[:id])

		landmark.name = params[:landmark][:name]
		landmark.year_completed = params[:landmark][:year_completed]
		
		landmark.save

		redirect "/landmarks/#{landmark.id}"
	end
end
