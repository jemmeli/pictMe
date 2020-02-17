task :complete_results_info => :environment do
  p '*** START CONVERTING RESULTS INFO ***'
  results = Result.where(first_name: nil).first(40000)
  p results.count

  results.each do |result|
    p "### Result : #{result.id} ###"
    begin
      result.update(first_name: result.name.split(' ')[0],
                    last_name: result.name.split(' ')[1],
                    processed: true)
    rescue => e
      p "## ERROR ## : #{result.id}"
      p result.errors
      p e
      next
    end
  end
end


task :convert_results_into_runners => :environment do
  p '*** START CONVERTING RESULTS ***'
  results = Result.where(runner_id: nil).first(20000)
  p results.count

  results.each do |result|
    p "### Result : #{result.id} ###"
    begin
      if result.first_name.present? && result.last_name.present? && result.dob.present?

        id_key = "#{I18n.transliterate(result.first_name).downcase}-#{I18n.transliterate(result.last_name).downcase}-#{result.dob.strftime('%d-%m-%Y')}"

        runner = Runner.where(id_key: id_key).first

        if runner.blank?
          runner = Runner.new(first_name: result.first_name,
                                 last_name: result.last_name,
                                  dob: result.dob)
          runner.save!
        end

        result.update(runner_id: runner.id)
      end
    rescue => e
      p "## ERROR ## : #{result.id}"
      p result.errors
      p runner.errors if runner
      p e
      next
    end
  end
end




