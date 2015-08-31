class SearchController < ApplicationController

	def nfl
		nfl = HTTParty.get("https://api.sportradar.us/nfl-ot1/games/2015/reg/schedule.json?api_key=dkqbasagrb829fr3z9kx2yz8")
		@button = []
		for x in 0.. nfl["weeks"][0]["games"].length-1 do
			@button.push(nfl["weeks"][0]["games"][x]["home"]["alias"])
			@button.push(nfl["weeks"][0]["games"][x]["away"]["alias"])
		end
		@button = @button.sort

	end

	def nfl_search
		@title = []
		@event_date = []

		nfl = HTTParty.get("https://api.sportradar.us/nfl-ot1/games/2015/reg/schedule.json?api_key=dkqbasagrb829fr3z9kx2yz8")
			nfl["weeks"].each do |x|
				x["games"].each do |y|
					if y["home"]["alias"] == params[:nfl] || y["away"]["alias"] == params[:nfl]
						event_date = y["scheduled"]
						@event_date.push(event_date)

						puts event_date
						if y["home"]["alias"] == params[:nfl]
							description = "Vs The " + y["away"]["name"]
							team = y["home"]["name"]
							title = "The #{team} #{description}" + " At "+y["venue"]["name"]
							@title.push(title)
						else
							description = "At The " + y["home"]["name"]
							team = y["away"]["name"]
							title = "The #{team} #{description}" + " At "+y["venue"]["name"]
							@title.push(title)
						end
						puts description
						puts title
					end
				end
			end
		@description = description
		render :show
	end#nfl_search end

	def mlb
		@teams = []
		mlb = HTTParty.get("http://api.sportradar.us/mlb-t5/games/2015/reg/schedule.json?api_key=sg78ea9tjzv3va2qtrca4z4c")
		mlb["league"]["season"]["games"].each do |x|
			@teams.push(x["home"]["abbr"])
		end
		@teams = @teams.uniq
		@teams.pop
		@teams = @teams.sort
	end#mlb end

	def mlb_search
		@title = []
		@event_date = []

		mlb = HTTParty.get("http://api.sportradar.us/mlb-t5/games/2015/reg/schedule.json?api_key=sg78ea9tjzv3va2qtrca4z4c")
		mlb["league"]["season"]["games"].each do |x|
			if (x["home"]["abbr"] == params[:mlb] && x["status"] == "scheduled") || (x["away"]["abbr"] == params[:mlb] && x["status"] == "scheduled")
				event_date = x["scheduled"]
				@event_date.push(event_date)
				puts x["scheduled"]
				if x["home"]["abbr"] == params[:mlb]
					description = "Vs The " + x["away"]["market"] + " " + x["away"]["name"]
					team = x["home"]["market"] + " " + x["home"]["name"]
					title = "The #{team} #{description}" + " At " + x["venue"]["name"]
					@title.push(title)
				else 
					description = "At The " + x["home"]["market"] + " " + x["home"]["name"]
					team = x["away"]["market"] + " " + x["away"]["name"]
					title = "The #{team} #{description}" + " At " + x["venue"]["name"]
					@title.push(title)
				end
				puts description
			end
		end
		@event_date = @event_date.first(10)
		@title = @title.first(10)
		@description = description
		render :show
	end#mlb_search

	def game
	
	end#game end

	def game_search
		@search = params[:name]
    result = HTTParty.get('http://www.giantbomb.com/api/search/?api_key=9a1589bbea869535bbf2840478d5656d7d53eb5c&format=json&query=%22'+@search+'%22&resources=game',
    headers:{
        "X-Mashape-Key" => "fkL4Ay2aSUmshDSItLpIVOVLIs4Op1nS8LLjsnes8Ehvq9m825",
        "Accept" => "text/plain"
        })
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
		#Game.create({title: params[:title], description: params[:description], date: params[:date], pic: params[:pic]})
    #redirect_to '/'   -calendar page
	end#game_add end


end#controller end
