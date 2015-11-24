class SearchesController < ApplicationController
	def new
		@search = Search.new
	end
	def create
		@search = Search.search(params[:q])
	end
	def custom
		@as_qdr = params[:as_qdr]
		@q = params[:q]
		@q = @q.gsub(" ","+")

		if params[:site]
			@sites = "+site%3A"
			params[:site].each do |site|
				@sites << site << "+OR+"
			end
			@q << @sites
		end
		if params[:q]
			@search_results = Search.search(@q, @as_qdr)
		end
	end
	def results
	end
	def show
	end
	def test
		@q =  params[:q]
		@as_qdr = params[:as_qdr]
	end
	def link
		url = params[:url]
		@page = fetch_url url
		
		if !@page
			@message = "We are not able to display the link."
		end
	end
	def fetch_url(url)
  		r = Net::HTTP.get_response(URI.parse(url))
  		if r.is_a? Net::HTTPSuccess
    		r.body.force_encoding("UTF-8")
  		else
    		nil
  		end
	end
end
