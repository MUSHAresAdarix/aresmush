$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "aresmush"

module AresMUSH

  describe Game do
    describe :master do
      it "should return the master game object" do
        model = double
        Game.stub(:all) { [model] }
        Game.master.should eq model
      end
    end

  end
end