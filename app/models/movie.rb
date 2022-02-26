class Movie < ActiveRecord::Base
    
    # All the available ratings
    def self.ratings
       return ['G','PG','PG-13','R'] 
    end
    
    # Something to keep track of what the user has checked
    def self.user_checks
        return {
            'G' => true,
            'PG' => true,
            'PG-13'=>true,
            'R'=>true
        } 
    end
    
    def self.update_checks(current_checks, ratings_that_the_user_has_checked)
        
        # Resetting everythign first
        current_checks.each {|key, val| current_checks[key] = false}
        
        # Setting the new checked values
        ratings_that_the_user_has_checked.keys.each do |k|
            current_checks[k] = true
        end
        
        return current_checks
    end
    
    def self.with_ratings(ratings)
        where(rating: ratings.keys)
    end
    
end