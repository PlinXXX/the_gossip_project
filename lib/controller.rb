class ApplicationController < Sinatra::Base
	
	get '/' do
		erb :index, locals: {gossips: Gossip.all}
	end


	get '/gossips/new/' do
    erb :new_gossip
  end
  

	post '/gossips/new/' do
		Gossip.new("#{params["gossip_author"]}" , "#{params["gossip_content"]}").save
		#puts "Salut, je suis dans le serveur"
		#puts "Ceci est mon super params : #{params}"
		#puts "Trop bien ! Et ceci est ce que l'utilisateur a passé dans le champ gossip_author : #{params["gossip_author"]}"
  	#puts "De la bombe, et du coup ça ça doit être ce que l'utilisateur a passé dans le champ gossip_content : #{params["gossip_content"]}"
  	#puts "ça déchire sa mémé, bon allez je m'envais du serveur, ciaos les BGs !"
  	redirect '/'
  end  

  
  get '/gossips/:n' do |x|
  	params = Gossip.find(x.to_i)
  	id = Gossip.select_id(params)
  	erb :potin_page, locals: {params: Gossip.find(x.to_i), id: Gossip.select_id(params)}
	end
  
end