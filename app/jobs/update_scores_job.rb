class UpdateScoresJob < ActiveJob::Base
  queue_as :normal

  def perform
    Score.delete_all

    runner_points = Result.joins(:race).group("results.runner_id, races.race_type").order("SUM(points) DESC").pluck("results.runner_id, SUM(results.points), races.race_type")
    runner_points.each do |r|
      begin
        Score.create(runner_id: r[0], points: r[1].to_i, race_type: r[2])
      rescue => e
          p "## ERROR ## : #{r[0]}"
          p e
          next
      end
    end

    sql = "UPDATE Results SET processed = TRUE WHERE runner_id IS NOT NULL AND processed = FALSE"
    ActiveRecord::Base.connection.execute(sql)
  end
end
