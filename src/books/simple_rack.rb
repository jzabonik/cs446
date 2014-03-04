#!/usr/bin/ruby

require 'rack'
require 'csv'

class SimpleApp
	def initialize()
    # can set up variables that will be needed later
		@time = Time.now
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
        # serve up a list response
        render_form(request, response)
	  when /\/list.*/
        # serve up a list response
        render_list(request, response)
      else
        [404, {"Content-Type" => "text/plain"}, ["Error 404!"]]
      end	# end case

	  File.open("footer.html", "r") { |head| response.write(head.read) }
      response.finish
    end
	
	def render_form(req, response)
		response.write("<form action=\"list\">")
		response.write("<select name=\"sort\">")
		response.write("<option value=\"author\">Author</option>")
		response.write("<option value=\"language\">Language</option>")
		response.write("<option value=\"title\">Title</option>")
		response.write("<option value=\"year\">Year</option>")
		response.write("</select>")
		response.write("<input type=\"submit\" value=\"Display List\">")
		response.write("</form>")
	end
	
  # try http://localhost:8080/list?author
	def render_list(req, response)
		sortType = req.GET["sort"]
		row = 0
		books = CSV.read('books.csv')
		booksRank = book_rankings()
		
		if sortType == "author"
			books.sort_by!{|k| k[1]}
		elsif sortType == "language"
			books.sort_by!{|k| k[2]}
		elsif sortType == "title"
			books.sort_by!{|k| k[0]}
		elsif sortType == "year"
			books.sort_by!{|k| k[3]}
		end
		response.write("<h2>Sorted by #{sortType}</h2>\n")
		response.write("<table>")
		response.write("<tr>")
		response.write("<th>Rank</th>")
		response.write("<th>Title</th>")
		response.write("<th>Author</th>")
		response.write("<th>Language</th>")
		response.write("<th>Year</th>")
		response.write("<th>Copies</th>")
		response.write("</tr>")
		books.each { |book|
			response.write("<tr>")
			response.write("<td>#{(booksRank.index(book[0]) - 50).abs}</td>")
			response.write("<td>#{book[0]}</td>")
			response.write("<td>#{book[1]}</td>")
			response.write("<td>#{book[2]}</td>")
			response.write("<td>#{book[3]}</td>")
			response.write("<td>#{book[4]}</td>")
			response.write("<tr>") }
		response.write("</table>")
	end
	
	def book_rankings()
		booksRank = CSV.read('books.csv')
		booksRank.each { |book|
			copies = book[4].split(" ")
			rank = copies[0].to_i
			book[4] = rank
		}
		booksRank.sort_by!{|k| k[4]}.reverse
		newBooks = []
		booksRank.each { |book|
			newBooks.push(book[0])
		}
		
		return newBooks
	end
end


Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run SimpleApp.new, :Port => 8080
