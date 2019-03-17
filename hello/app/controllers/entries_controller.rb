class EntriesController < ApplicationController
    def sign_in
        #retrieve name from HTML form entered by user
        @name = params[:visitor_name]
        
        #if not blank, then create new database entry
        unless @name.blank?
            @entry = Entry.create({ :name => @name })
        end
        
        #retrieve all rows from table
        #to retrieve certain rows Entry.where( conditions )
        @entries = Entry.all
    end
end
