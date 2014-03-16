#!/usr/bin/ruby

require 'rack'
require 'sqlite3'
require 'ERB'

class SimpleApp
	include ERB::Util
	
	def initialize()
    # can set up variables that will be needed later
		@time = Time.now
		@db = SQLite3::Database.new( "books.sqlite3.db" )
	end

	def call(env)
    # create request and response objects
		request = Rack::Request.new(env)
		response = Rack::Response.new
    # include the header
		File.open("header.html", "r") { |head| response.write(head.read) }
		case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/form.*/
        # serve up a form response
        render_form(request, response)
	  when /\/list.*/
        # serve up a list response
        render_list(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
      end	# end case

	  File.open("footer.html", "r") { |foot| response.write(foot.read) }
      response.finish
    end
	
	def render_form(req, response)
		response.write(ERB.new(File.read("form.html.erb")).result(binding))
	end
	
  # try http://localhost:8080/list?author
	def render_list(req, response)
		sortType = req.GET["sort"]
				
		if sortType == "author"
			books = @db.execute( "select * from Books order by author" )
		elsif sortType == "language"
			books = @db.execute( "select * from Books order by language" )
		elsif sortType == "title"
			books = @db.execute( "select * from Books order by title" )
		elsif sortType == "year"
			books = @db.execute( "select * from Books order by published" )
		elsif sortType == "rank"
			books = @db.execute( "select * from Books order by id" )
		end
		
		response.write(ERB.new(File.read("list.html.erb")).result(binding))
	end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
