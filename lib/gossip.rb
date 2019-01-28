class Gossip

	def save
		CSV.open("../db/gossip.csv", "ab") do |csv|
			csv << ["Mon super auteur" , "Ma superbe description"]
		end
	end

end