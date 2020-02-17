require "test_helper"

describe DecodeResults do

  describe "It loads a new file for the first time" do
    before do
      @race = Race.create(name: 'test')
      DecodeResults.new.call(@race, "#{Rails.root}/test/fixtures/results.csv")
      @runner = @race.results.where(name: 'Adeline Leydet').first
    end
    it "loads all the rows" do
      assert_equal 10, @race.results.count
    end
    it "loads all the name" do
      assert_equal 'FRA', @runner.country
    end
    it "loads all the phone" do
      assert_equal '33682568000', @runner.phone
    end
    it "loads all the mail" do
      assert_equal 'adeline.leydet@example.com', @runner.mail
    end
    it "loads all the rank" do
      assert_equal 145, @runner.rank
    end
    it "loads all the bib" do
      assert_equal '2', @runner.bib
    end
    it "loads all the categ_rank" do
      assert_equal 23, @runner.categ_rank
    end
    it "loads all the categ" do
      assert_equal 'SE', @runner.categ
    end
    it "loads all the sex" do
      assert_equal 'F', @runner.sex
    end
    it "loads all the sex_rank" do
      assert_equal 38, @runner.sex_rank
    end
    it "loads all the time" do
      assert_equal '01:29:44', @runner.time
    end
    it "loads all the speed" do
      assert_equal '8,02', @runner.speed
    end
    it "loads all the message" do
      assert_nil @runner.message
    end
    it "loads all the race_detail" do
      assert_equal "12", @runner.race_detail
    end
    it "sets uploaded_at" do
      refute_nil @runner.uploaded_at
    end
  end

  describe "It loads a twice the same file" do
    it "it loads all the rows" do
      race = Race.create(name: 'test')
      DecodeResults.new.call(race, "#{Rails.root}/test/fixtures/results.csv")
      DecodeResults.new.call(race, "#{Rails.root}/test/fixtures/results.csv")
      assert_equal 10, race.results.count
    end
  end

  describe "It loads a file with new rows and updated data" do
    before do

      @race = Race.create(name: 'test')
      DecodeResults.new.call(@race, "#{Rails.root}/test/fixtures/results.csv")
      @adeline_before_update = @race.results.where(name: 'Adeline Leydet').first
      @adrien_before_update = @race.results.where(name: 'Adrien Peigne').first
      Timecop.travel(@adrien_before_update.updated_at + 5.minutes)
      DecodeResults.new.call(@race, "#{Rails.root}/test/fixtures/results_updated_and_new_times.csv")
    end
    it "loads all the rows" do
      assert_equal 11, @race.results.count
    end
    it "updates times for Adeline" do
      @adeline = @race.results.where(name: 'Adeline Leydet').first
      refute_equal @adeline_before_update.time, @adeline.time
    end
    it "updates uploaded_at for adeline" do
      @adeline = @race.results.where(name: 'Adeline Leydet').first
      refute_equal @adeline_before_update.time, @adeline.time
    end
    it "doesn't change uploaded_at for adrien" do
      @adrien = @race.results.where(name: 'Adrien Peigne').first
      assert_equal @adrien_before_update.uploaded_at, @adrien.uploaded_at
    end
  end

end
