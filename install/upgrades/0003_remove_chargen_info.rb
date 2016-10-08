module AresMUSH
  bootstrapper = AresMUSH::Bootstrapper.new
  AresMUSH::Global.plugin_manager.load_all
  
  # Fixes errors like undefined method `chargen_stage=' for #<AresMUSH::Character:0x007fcca57994f0>
  # resulting from deleting an attribute from the code when there's still data in the database.
  
  # First you have to re-define the fields you deleted.
  class Character
    attribute :chargen_stage
    attribute :chargen_locked
    attribute :background
  end
  
  puts "======================================================================="
  puts "Remove chargen fields."
  puts "======================================================================="
  
  # Then wipe out the field on all affected objects.
  Character.all.each do |c|
    c.chargen_stage = nil
    c.chargen_locked = nil
    c.background = nil
    c.save
  end
  
  puts "Upgrade complete!"
end