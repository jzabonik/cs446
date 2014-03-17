#!/usr/bin/ruby

require 'sinatra'
require 'data_mapper'
require_relative 'book'

configure do
  DataMapper.setup :default, "sqlite3://#{Dir.pwd}/books.sqlite3.db"
end

get '/' do
  erb :'form'
end

post '/list' do
  @sort = params[:sort]
  if @sort == "author"
	@books = Book.all(:order => [ :author ])
  elsif @sort == "language"
	@books = Book.all(:order => [ :language ])
  elsif @sort == "title"
	@books = Book.all(:order => [ :title ])
  elsif @sort == "year"
	@books = Book.all(:order => [ :published ])
  elsif @sort == "rank"
	@books = Book.all(:order => [ :id ])
  end
  erb :'list'
end
