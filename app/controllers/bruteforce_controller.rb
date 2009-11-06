class BruteforceController < ApplicationController

 def index
 end
 
 def chunks
   @chunks = []
   string = ' '
   800.times do |i|
     string = string.succ
     @chunks << string
   end
   respond_to do |format|
     format.html { render :text => @chunks.inspect }
     format.js   { render :js => "chunks = #{@chunks.to_js_array};" }
     format.json { render :json => @chunks.to_json }
   end
 end
 
 
end
