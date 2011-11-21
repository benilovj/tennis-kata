require 'tennis_score'

RSpec::Matchers.define :have_a_score_of do |expected_score|
  chain :after_points_won_by do |*winners|
    @winners = winners
  end

  match do |game|
    (@winners || []).each {|player| game.point_to(player)}
    @actual_score = game.score
    @actual_score == expected_score
  end

  failure_message_for_should do
    "be '#{expected_score}', but is '#{@actual_score}'"
  end
end

describe Game do
  subject {Game.new("J", "B")}
  
  it { should have_a_score_of("Love all") }
  it { should have_a_score_of("Fifteen, love").after_points_won_by("J") }
  it { should have_a_score_of("Love, fifteen").after_points_won_by("B") }
  it { should have_a_score_of("Thirty, love").after_points_won_by("J", "J") }
  it { should have_a_score_of("Thirty, fifteen").after_points_won_by("J", "J", "B") }
  it { should have_a_score_of("Forty, fifteen").after_points_won_by("J", "J", "B", "J") }
end