class ResourcesController < ApplicationController
  def save
    if !params[:close]
    	@search = Search.find(params[:search_id])
    	@link = Link.find_by(url: params[:url])

    	if !@link
    		@link = Link.create(url: params[:url], title: params[:title])
    		@resource = Resource.new(search_id: @search.id, link_id: @link.id)
    			if @resource.save
    				@message = "Save Completed"
    			end
    	else
    		links = @search.links
    		exist = false
    		links.each do |link|
    			if link.url == params[:url]
    				exist = true
    			end
    		end
    		if !exist
    			@resource = Resource.new(search_id: @search.id, link_id: @link.id)
    			if @resource.save
    				@message = "Save Completed"
    			end
    		end
    	end
    end
  end

  def destroy
    @resource = Resource.find(params[:resource])
    @resource.destroy
  end
  def update
    @resource = Resource.find(params[:id])
    @resource.note = params[:resource][:note]
    @resource.save
    respond_to do |format|
      format.json {respond_with_bip(@resource)}
    end
  end
end

