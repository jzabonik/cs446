atom_feed do |feed|
	feed.title "Foster Parents"
		@foster_parenets.each do |foster_parent|
		feed.entry(foster_parent) do |entry|
			entry.title "FosterParent #{foster_parent.id}"
			entry.summary type: 'xhtml' do |xhtml|
				xhtml.p "#{Animal.find(foster_parent.pet_id).name} given to #{foster_parent.address}"
			end
			entry.author do |author|
				author.name foster_parent.name
				author.email foster_parent.email
			end
		end
	end
end