require 'tennis_score'

module GameHelpers
  def game_with(server, receiver)
    Game.new(server, receiver)
  end
end

RSpec.configure do |c|
  c.include GameHelpers
end

describe Game do
  context "initially" do
    subject { game_with("J", "B") }
    
    its(:score) { should == "Love all"}
  end

  context "after one point won by the server" do
    subject { game_with("J", "B").point_to("J") }
    its(:score) { should == "Fifteen, love"}
  end

  context "after one point won by the receiver" do
    subject { game_with("J", "B").point_to("B") }
    its(:score) { should == "Love, fifteen"}
  end
end