
class Gossip

	attr_accessor :author, :content, :id

	def initialize(author, content)
		@author = author
		@content = content
	end


	def save
		CSV.open("./db/gossip.csv", "a+") do |csv|
			csv << [@author , @content]
		end
	end


	def overwrite
		CSV.open("./db/gossip.csv", "w+") do |csv|
			csv << [@author , @content]
		end
	end
	

	def self.all
		all_gossips = []
		CSV.foreach("./db/gossip.csv") do |csv_line|
			all_gossips << [csv_line[0], csv_line[1]]
		end
		all_gossips
	end


	def self.id_creator
		params = Hash.new
		i = 1
		CSV.foreach("./db/gossip.csv") do |csv_line|
			params[i] = Gossip.new(csv_line[0], csv_line[1])
			i += 1
		end
		params
	end


	def self.find(x)
		gossips = Gossip.id_creator

  	gossips.each do |id , gossip|
			if x == id
				@id = id
				@gossip = gossip				
			end
		end

		params = {@id => @gossip}
	end


	def self.select_id(params)
		params.each {|i , g| @id = i}
		@id
	end


	def reload
		# puts $params
		newg = [@author , @content]
		puts "Potin #{Gossip.select_id($params)} modifié!"

		all_gossips = Gossip.id_creator
		all_gossips.each do |gossip|
			if Gossip.select_id($params) == gossip[0]
				gossip[1].author = newg[0]
				gossip[1].content = newg[1]
			end
		end
		i = 1
		all_gossips.each do |idgossip|
			idgossip[1].overwrite if i == 1
			idgossip[1].save if i != 1
			i += 1
		end
	end

end
