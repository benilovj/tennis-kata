class Game
  def initialize(server, receiver)
    @server = server
    @receiver = receiver
    @points_won_by = {server => 0, receiver => 0}
  end

  def score
    case
    when no_points_played? then "Love all"
    when @points_won_by[@server] > 0 then "Fifteen, love"
    when @points_won_by[@receiver] > 0 then "Love, fifteen"
    end
  end

  def point_to(player)
    @points_won_by[player] += 1
    self
  end

  protected
  def no_points_played?
    @points_won_by[@server] == 0 and @points_won_by[@receiver] == 0
  end
end
