class FiguresController < ApplicationController

	get '/figures' do 
		@figures = Figure.all
		erb :'figures/index'
	end

	get '/figures/new' do
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'figures/new'
	end

	post '/figures' do
		# binding.pry
		figure = Figure.new(name: params[:figure][:name])

		if params[:title][:name].empty? && params[:figure][:title_ids].nil?
		elsif !params[:title][:name].empty?
			figure.titles.build(name: params[:title][:name])
		else 
			figure.titles << Title.find(params[:figure][:title_ids])
		end

		if params[:landmark][:name].empty? && params[:figure][:landmark_ids].nil?
		elsif !params[:landmark][:name].empty?
			figure.landmarks.build(name: params[:landmark][:name])
		else 
			figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
		end

		figure.save

		redirect '/figures'
	end

	get '/figures/:id' do
		
		@figure = Figure.find(params[:id])
		binding.pry
		erb :'figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		@figure_titles = @figure.titles
		@figure_landmarks = @figure.landmarks

		@titles = Title.all
		@landmarks = Landmark.all


		erb :'figures/edit'
	end

	patch '/figures/:id' do 
	

		figure = Figure.find(params[:id])

		figure.name = params[:figure][:name]

		if params[:title][:name].empty? && params[:figure][:title_ids].nil?
		elsif !params[:title][:name].empty?
			figure.titles.build(name: params[:title][:name])
		else 
			figure.titles << Title.find(params[:figure][:title_ids])
		end

		if params[:landmark][:name].empty? && params[:figure][:landmark_ids].nil?
		elsif !params[:landmark][:name].empty?
			figure.landmarks.build(name: params[:landmark][:name])
		else 
			figure.landmarks << Landmark.find(params[:figure][:landmark_ids])
		end
		
		figure.save

		redirect "/figures/#{figure.id}"
	end
end