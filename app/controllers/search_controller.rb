class SearchController < ApplicationController

	def movies
		today = Time.new
		year 	= today.year.to_s
		month = sprintf '%02d', today.month
		day 	= sprintf '%02d', today.day

		movies = HTTParty.get("https://api.themoviedb.org/3/discover/movie?primary_release_date.gte=" +
			year + "-" + month + "-" + day + "?api_key=62a7eb6c7255fd75d2d7a0ce222f8896"
		)
		@movies = JSON.parse(movies).results
	end

	def tv
		today = Time.new
		year 	= today.year.to_s
		month = sprintf '%02d', today.month
		day 	= sprintf '%02d', today.day

		tv = HTTParty.get("https://api.themoviedb.org/3/discover/tv?air_date.gte=" +
			year + "-" + month + "-" + day + "?api_key=62a7eb6c7255fd75d2d7a0ce222f8896"
		)
		@tv = JSON.parse(tv).results
	end

	def nfl
		if logged_in?
			nfl = HTTParty.get("https://api.sportradar.us/nfl-ot1/games/2015/reg/schedule.json?api_key=#{ENV['nfl']}")
			@button = []
			for x in 0.. nfl["weeks"][0]["games"].length-1 do
				@button.push(nfl["weeks"][0]["games"][x]["home"]["alias"])
				@button.push(nfl["weeks"][0]["games"][x]["away"]["alias"])
			end
			@button = @button.sort
		else
			redirect_to root_path
		end
	end

	def nfl_search
		nfl_logos = {
			"ARI" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/ari.png",
			"ATL" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/atl.png",
			"BAL" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/bal.png",
			"BUF" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/buf.png",
			"CAR" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/car.png",
			"CHI" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/chi.png",
			"CIN" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/cin.png",
			"CLE" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/cle.png",
			"DAL" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/dal.png",
			"DEN" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/den.png",
			"DET" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/det.png",
			"GB" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/gb.png",
			"HOU" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/hou.png",
			"IND" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/ind.png",
			"JAC" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/jac.png",
			"KC" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/kc.png",
			"MIA" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/mia.png",
			"MIN" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/min.png",
			"NE" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/ne.png",
			"NO" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/no.png",
			"NYG" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/nyg.png",
			"NYJ" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/nyj.png",
			"OAK" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/oak.png",
			"PHI" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/phi.png",
			"PIT" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/pit.png",
			"SD" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/sd.png",
			"SEA" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/sea.png",
			"SF" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/sf.png",
			"STL" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/stl.png",
			"TB" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/tb.png",
			"TEN" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/ten.png",
			"WAS" => "http://i.nflcdn.com/static/site/7.1/img/logos/teams-gloss-81x54/was.png"
		}
		@title = []
		@event_date = []
		@id = []
		@away_image =[]
		@location = []
		@description = []

		nfl = HTTParty.get("https://api.sportradar.us/nfl-ot1/games/2015/reg/schedule.json?api_key=#{ENV['nfl']}")
			nfl["weeks"].each do |x|
				x["games"].each do |y|
					if y["home"]["alias"] == params[:nfl] || y["away"]["alias"] == params[:nfl]
						event_date = y["scheduled"]
						@event_date.push(event_date)

						puts event_date
						if y["home"]["alias"] == params[:nfl]
							description = "Vs The " + y["away"]["name"]
							@description.push(description)
							team = y["home"]["name"]
							title = "The #{team} #{description}" + " At "+y["venue"]["name"]
							@title.push(title)
							id = y["id"]
							@id.push(id)
							awayImg = y["away"]["alias"]
							@away_image.push(awayImg)
							location = y["venue"]["name"]
							@location.push(location)
						else
							description = "At The " + y["home"]["name"]
							@description.push(description)
							team = y["away"]["name"]
							title = "The #{team} #{description}" + " At "+y["venue"]["name"]
							@title.push(title)
							id = y["id"]
							@id.push(id)
							awayImg = y["home"]["alias"]
							@away_image.push(awayImg)
							location = y["venue"]["name"]
							@location.push(location)
						end
						puts description
						puts title
					end
				end
			end


		@button = []
		for x in 0.. nfl["weeks"][0]["games"].length-1 do
			@button.push(nfl["weeks"][0]["games"][x]["home"]["alias"])
			@button.push(nfl["weeks"][0]["games"][x]["away"]["alias"])
		end
		@button = @button.sort
		@image = nfl_logos[params[:nfl]]
		
		@final = []
		@away_image.each do |x|
			@final.push(nfl_logos[x])
		end

		render :nfl
	end#nfl_search end

	def mlb
		if logged_in?
			@teams = []
			mlb = HTTParty.get("http://api.sportradar.us/mlb-t5/games/2015/reg/schedule.json?api_key=#{ENV['mlb']}")
			mlb["league"]["season"]["games"].each do |x|
				@teams.push(x["home"]["abbr"])
			end
			@teams = @teams.uniq
			@teams.pop
			@teams = @teams.sort
		else
			redirect_to root_path
		end
	end#mlb end

	def mlb_search
		mlb_logos = {
			"ARI" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/ari.png&h=150&w=150",
			"ATL" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/atl.png&h=150&w=150",
			"BAL" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/bal.png&h=150&w=150",
			"BOS" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/bos.png&h=150&w=150",
			"CHC" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/chc.png&h=150&w=150",
			"CIN" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/cin.png&h=150&w=150",
			"CLE" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/cle.png&h=150&w=150",
			"COL" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/col.png&h=150&w=150",
			"CWS" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/chw.png&h=150&w=150",
			"DET" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/det.png&h=150&w=150",
			"HOU" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/hou.png&h=150&w=150",
			"KC" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/kc.png&h=150&w=150",
			"LAA" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/laa.png&h=150&w=150",
			"LAD" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/lad.png&h=150&w=150",
			"MIL" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/mil.png&h=150&w=150",
			"MIA" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/mia.png&h=150&w=150",
			"MIN" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/min.png&h=150&w=150",
			"NYM" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/nym.png&h=150&w=150",
			"NYY" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/nyy.png&h=150&w=150",
			"OAK" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/oak.png&h=150&w=150",
			"PHI" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/phi.png&h=150&w=150",
			"PIT" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/pit.png&h=150&w=150",
			"SD" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/sd.png&h=150&w=150",
			"SEA" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/sea.png&h=150&w=150",
			"SF" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/sf.png&h=150&w=150",
			"STL" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/stl.png&h=150&w=150",
			"TB" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/tb.png&h=150&w=150",
			"TEX" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/tex.png&h=150&w=150",
			"TOR" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/tor.png&h=150&w=150",
			"WSH" => "http://a.espncdn.com/combiner/i?img=/i/teamlogos/mlb/500/wsh.png&h=150&w=150"
		}
		@title = []
		@event_date = []
		@id = []
		@away_image =[]
		@location = []
		@description = []

		mlb = HTTParty.get("http://api.sportradar.us/mlb-t5/games/2015/reg/schedule.json?api_key=#{ENV['mlb']}")
		mlb["league"]["season"]["games"].each do |x|
			if (x["home"]["abbr"] == params[:mlb] && x["status"] == "scheduled") || (x["away"]["abbr"] == params[:mlb] && x["status"] == "scheduled")
				event_date = x["scheduled"]
				@event_date.push(event_date)
				puts x["scheduled"]
				if x["home"]["abbr"] == params[:mlb]
					description = "Vs The " + x["away"]["market"] + " " + x["away"]["name"]
					@description.push(description)
					team = x["home"]["market"] + " " + x["home"]["name"]
					title = "The #{team} #{description}" + " At " + x["venue"]["name"]
					@title.push(title)
					id = x["id"]
					@id.push(id)
					awayImg = x["away"]["abbr"]
					@away_image.push(awayImg)
					location = x["venue"]["name"]
					@location.push(location)
				else 
					description = "At The " + x["home"]["market"] + " " + x["home"]["name"]
					@description.push(description)
					team = x["away"]["market"] + " " + x["away"]["name"]
					title = "The #{team} #{description}" + " At " + x["venue"]["name"]
					@title.push(title)
					id = x["id"]
					@id.push(id)
					awayImg = x["home"]["abbr"]
					@away_image.push(awayImg)
					location = x["venue"]["name"]
					@location.push(location)
				end
				puts description
			end
		end

		@final = []
		@away_image.each do |x|
			@final.push(mlb_logos[x])
		end

		@description = @description.first(10)
		@final = @final.first(10)
		@id = @id.first(10)
		@event_date = @event_date.first(10)
		@title = @title.first(10)
		@location = @location.first(10)

		@teams = []
		mlb["league"]["season"]["games"].each do |x|
			@teams.push(x["home"]["abbr"])
		end
		@teams = @teams.uniq
		@teams.pop
		@teams = @teams.sort
		@image = mlb_logos[params[:mlb]]
		render :mlb
	end#mlb_search


	def mlb_show
		id = params[:id]
		mlb = HTTParty.get("http://api.sportradar.us/mlb-t5/games/2015/reg/schedule.json?api_key=#{ENV['mlb']}")
		mlb["league"]["season"]["games"].each do |x|
			if x["id"] == id
				@event_date = x["scheduled"]
				@title = x["home"]["market"] + " " + x["home"]["name"] + " Vs The " + x["away"]["market"] + " " + x["away"]["name"]
				@venue = x["venue"]["name"]
			end
		end
	end#mlb_show

	def nfl_show
		id = params[:id]
			nfl = HTTParty.get("https://api.sportradar.us/nfl-ot1/games/2015/reg/schedule.json?api_key=#{ENV['nfl']}")
			nfl["weeks"].each do |x|
				x["games"].each do |y|
					if y["id"] == id
						@event_date = y["scheduled"]
						@title = y["home"]["name"] +" Vs The " + y["away"]["name"]
						@venue = y["venue"]["name"]
					end
				end
			end
	end

	def event_save
		event = Event.new(event_params)
		if Event.find_by(unique_id: event[:unique_id])
			event = Event.find_by(unique_id: event[:unique_id])
		else
			event = Event.create(event_params)
		end
		user = User.find(session[:user_id])

		unless user.events.find_by(unique_id: event[:unique_id])
			user.events << event
		end
		redirect_to user_path(user)
	end

	def game

	end#game end

	def game_search
    @search = params[:name]
    result = HTTParty.get('http://www.giantbomb.com/api/search/?api_key=9a1589bbea869535bbf2840478d5656d7d53eb5c&format=json&query=%22'+@search+'%22&resources=game')
    array = []
    list = result["results"]
    list.each do |x|
      year = x["expected_release_year"].to_s  
      month = x["expected_release_month"].to_s
      split = month.split("")
      if split.length < 2 
        split = split.unshift("0")
      end
      joined = split.join("")
      date = (year + split.join("")).to_i
      if date > 201508
        array.push(x)
      end
    end
    @games = array

    render :show_game
  end#game_search end

  def game_add
    a = params[:date].split("/")
    array = []
    a.each do |x|
      array.push(x.to_i)
    end
    b = array.pop
    date = array.unshift(b).join("-").to_date

   
   event = Event.new(event_params)
		if Event.find_by(unique_id: event[:unique_id])
			event = Event.find_by(unique_id: event[:unique_id])
		else
			event_params = ({title: params[:title], description: params[:description], event_date: date, logo: params[:pic], event_type: "video game", unique_id: params[:unique_id]})
			event = Event.create(event_params)
		end
		user = User.find(session[:user_id])

		unless user.events.find_by(unique_id: event[:unique_id])
			user.events << event
		end
		redirect_to user_path(user)
    # redirect_to '/search/game'  
  end#game_add end


  def music_search
  end

  def music_show
  	  name = params['artist'].split(' ').join('+')
      response = HTTParty.get('http://api.eventful.com/json/events/search?keywords=' + name + '&location=new+york&image_sizes=large&sort_order=popularity&app_key=smgM7gtT4TD53Spx')
      @data = JSON.parse(response)
      puts "yooooooooooooooooo"
  end



  def music_save

  		event = Event.new(event_params)
		if Event.find_by(unique_id: event[:unique_id])
			event = Event.find_by(unique_id: event[:unique_id])
		else
			event_params = {title: params[:title], description: params[:description], event_date: params[:start_time], event_type: "music", location: params[:venue_name], unique_id: params[:unique_id]}
			event = Event.create(event_params)
		end
		user = User.find(session[:user_id])

		unless user.events.find_by(unique_id: event[:unique_id])
			user.events << event
		end
		redirect_to user_path(user)
  end




  
	private

	def event_params
    params.permit(:title, :description, :logo, :event_date, :event_type, :location, :unique_id) 
  end

end#controller end
