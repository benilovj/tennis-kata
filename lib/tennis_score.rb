class Game
  SCORING = ["love", "fifteen", "thirty", "forty"]

  def initialize(server, receiver)
    @server = server
    @receiver = receiver
    @points_won_by = {server => 0, receiver => 0}
  end

  def score
    value = case
    when no_points_played? then "love all"
    when game_won? then "game, #{player_in_front}"
    when (in_deuce? and scores_even?) then "deuce"
    when in_deuce? then "advantage, #{player_in_front}"
    else "#{decode_for(@server)}, #{decode_for(@receiver)}"
    end
    value[0].upcase + value[1..-1]
  end

  def point_to(player)
    @points_won_by[player] += 1
    self
  end

  def with_points_to(*players)
    players.inject(self) {|game, winner| game.point_to(winner)}
  end

  protected
  def game_won?
    game_won_normally? or game_won_in_deuce?
  end

  def game_won_normally?
    not scores_even? and not in_deuce? and @points_won_by[player_in_front] == 4
  end

  def game_won_in_deuce?
    in_deuce? and not scores_even? and gap_between_scores > 1
  end

  def in_deuce?
    @points_won_by.values.all? {|v| v >= 3}
  end

  def player_in_front
    @points_won_by.keys.sort_by {|key| @points_won_by[key]}.last
  end

  def gap_between_scores
    @points_won_by.values.max - @points_won_by.values.min
  end

  def scores_even?
    @points_won_by[@server] == @points_won_by[@receiver]
  end

  def no_points_played?
    @points_won_by[@server] == 0 and @points_won_by[@receiver] == 0
  end

  def decode_for(player)
    SCORING[@points_won_by[player]]
  end
end
