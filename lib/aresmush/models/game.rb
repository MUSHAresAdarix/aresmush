module AresMUSH
  class Game
    
    include MongoMapper::Document
    
    # There's only one game document and this is it!
    def self.master
      Game.all.first
    end
  end
end
