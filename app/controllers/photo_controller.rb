class PhotoController < ApplicationController
  def display
    @image_data = Photo.find(params[:id])
    if !@image_data.url.nil? and !@image_data.url.empty?
      open("#{@image_data.url}") {|img|
      tmpfile = Tempfile.new("download.jpg")
      File.open(tmpfile.path, 'wb') do |f| 
        f.write img.read
      end 
      send_file tmpfile.path, :filename => "db-image.jpg", :disposition => 'inline' 
      }
    else
      
      @image = @image_data.binary_data
      send_data @image, :type     => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline'
    end
  end

end
