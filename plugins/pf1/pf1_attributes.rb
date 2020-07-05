module AresMUSH
   module Pf1
     class Pf1Attributes < Ohm::Model
       include ObjectModel
       attribute :name
       attribute :shortname
       reference :character, "AresMUSH::Character"
       index :name
     end
   end
end   
