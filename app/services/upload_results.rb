require 'charlock_holmes'
require 'irb'
require 'utils'
require 'open-uri'

class UploadResults
  #définition des index pour le parsing CSV
  PHONE_INDEX = 0
  MAIL_INDEX = 1
  RANK_INDEX = 2
  FIRST_NAME_INDEX = 3
  LAST_NAME_INDEX = 4
  DOB_INDEX = 5
  COUNTRY_INDEX = 6
  NUMBER_INDEX = 7
  CATEG_RANK_INDEX = 8
  CATEG_INDEX = 9
  SEX_RANK_INDEX = 10
  SEX_INDEX = 11
  TIME_INDEX = 12
  SPEED_INDEX = 13
  LENGTH_INDEX = 14
  RACE_DETAIL_INDEX = 15
  MESSAGE_INDEX = 16
  RACE_NAME_INDEX = 17
  POINTS_INDEX = 18

  def initialize(edition_id)
    @edition = Edition.find(edition_id)
    @filename = @edition.raw_results.url
  end

  def call
    nb = 0
    open(@filename) do |file|
      file.each_line do |line|
        nb += 1
        next if nb == 1
        CSV.parse(utf8_encoded_content(line), col_sep: CSV_SEPARATOR) do |row|
          if row
            p row
            race = @edition.races.where(name: row[RACE_NAME_INDEX]).first
            if race
              p 'race found'
              p race.id
            else
              p 'race not found'
              p row[RACE_NAME_INDEX]
            end
            return unless race

            existing_rows_in_db = @edition.results.where(
              bib: row[NUMBER_INDEX],
              race_id: race.id
            )
            if existing_rows_in_db.any?
              p 'existing row'
              if there_are_differences?(existing_rows_in_db.first, row)
                existing_rows_in_db.first.update_attributes(
                    phone: row[PHONE_INDEX],
                    mail: row[MAIL_INDEX],
                    rank: row[RANK_INDEX],
                    first_name: Utils.titlecase(row[FIRST_NAME_INDEX]),
                    last_name: Utils.titlecase(row[LAST_NAME_INDEX]),
                    dob: Date.parse(row[DOB_INDEX]),
                    country: row[COUNTRY_INDEX],
                    bib: row[NUMBER_INDEX],
                    categ_rank: row[CATEG_RANK_INDEX],
                    categ: row[CATEG_INDEX],
                    sex_rank: row[SEX_RANK_INDEX],
                    sex: row[SEX_INDEX],
                    time: row[TIME_INDEX],
                    speed: row[SPEED_INDEX],
                    message: row[MESSAGE_INDEX],
                    uploaded_at: Time.now,
                    race_detail: row[RACE_DETAIL_INDEX],
                    points: row[POINTS_INDEX]
                )
              end
            else
              if row[NUMBER_INDEX].nil?
                row[NUMBER_INDEX] = -nb
              end

              if row[FIRST_NAME_INDEX].present? && row[LAST_NAME_INDEX].present? && row[DOB_INDEX].present?
                p 'first name present'
                id_key = "#{I18n.transliterate(row[FIRST_NAME_INDEX]).downcase}-#{I18n.transliterate(row[LAST_NAME_INDEX]).downcase}-#{Date.parse(row[DOB_INDEX]).strftime('%d-%m-%Y')}"
                runner = Runner.find_or_create_by(id_key: id_key) do |runner|
                  runner.first_name = row[FIRST_NAME_INDEX]
                  runner.last_name = row[LAST_NAME_INDEX]
                  runner.dob = Date.parse(row[DOB_INDEX])
                  runner.sex = ['m', 'h'].include?(row[SEX_INDEX].downcase) ? 'M' : 'F'
                  runner.category = row[CATEG_INDEX]
                end
                p runner.errors
                p runner.id
                p runner.id
                p runner.id
              else
                p 'no runner'
                runner = nil
              end

              r = @edition.results.create(
                  phone: row[PHONE_INDEX],
                  mail: row[MAIL_INDEX],
                  rank: row[RANK_INDEX],
                  first_name: Utils.titlecase(row[FIRST_NAME_INDEX]),
                  last_name: Utils.titlecase(row[LAST_NAME_INDEX]),
                  dob: Date.parse(row[DOB_INDEX]),
                  country: row[COUNTRY_INDEX],
                  bib: row[NUMBER_INDEX],
                  categ_rank: row[CATEG_RANK_INDEX],
                  categ: row[CATEG_INDEX],
                  sex_rank: row[SEX_RANK_INDEX],
                  sex: ['m', 'h'].include?(row[SEX_INDEX].downcase) ? 'M' : 'F',
                  time: row[TIME_INDEX],
                  speed: row[SPEED_INDEX],
                  message: row[MESSAGE_INDEX],
                  uploaded_at: Time.now,
                  race_detail: row[RACE_DETAIL_INDEX],
                  runner_id: runner.try(:id),
                  race_id: race.id,
                  points: row[POINTS_INDEX]
              )
              p r.errors
            end
          end
        end
      end
    end
  end

  private

  def there_are_differences?(old, row)
    changes = []
    changes << :phone if (old.phone != row[PHONE_INDEX])
    changes << :mail if (old.mail != row[MAIL_INDEX])
    changes << :rank if (old.rank != Integer(row[RANK_INDEX]) rescue nil)
    changes << :first_name if (old.first_name != Utils.titlecase(row[FIRST_NAME_INDEX]))
    changes << :last_name if (old.first_name != Utils.titlecase(row[LAST_NAME_INDEX]))
    changes << :dob if (old.dob != Date.parse(row[DOB_INDEX]))
    changes << :contry if (old.country != row[COUNTRY_INDEX])
    changes << :categ_rank if (old.categ_rank != Integer(row[CATEG_RANK_INDEX]) rescue nil)
    changes << :categ if (old.categ != row[CATEG_INDEX])
    changes << :sex_rank if (old.sex_rank != Integer(row[SEX_RANK_INDEX]) rescue nil)
    changes << :sex if (old.sex != row[SEX_INDEX])
    changes << :time if (old.time != row[TIME_INDEX])
    changes << :speed if (old.speed != row[SPEED_INDEX])
    changes << :message if (old.message != row[MESSAGE_INDEX])
    changes.any?
  end


  def detection(line)
    CharlockHolmes::EncodingDetector.detect(line)
  end

  def utf8_encoded_content(line)
    encoding = detection(line)[:encoding]
    if encoding == 'IBM424_ltr'
      encoding = 'ISO-8859-1'
    end
    CharlockHolmes::Converter.convert line, encoding, 'UTF-8'
  end
end
