class Gossip

	attr_accessor :author, :content, :id

	def initialize(author, content)
		@author = author
		@content = content
	end


	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author , @content]
		end
	end


	def self.all
		all_gossips = []
		CSV.foreach("./db/gossip.csv") do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
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


	def edit
		all_gossips = Gossip.id_creator

	end

end
