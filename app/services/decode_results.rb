require 'charlock_holmes'
require 'irb'
require 'utils'
require 'open-uri'

class DecodeResults
  #définition des index pour le parsing CSV
  PHONE_INDEX = 0
  MAIL_INDEX = 1
  RANK_INDEX = 2
  NAME_INDEX = 3
  COUNTRY_INDEX = 4
  NUMBER_INDEX = 5
  CATEG_RANK_INDEX = 6
  CATEG_INDEX = 7
  SEX_RANK_INDEX = 8
  SEX_INDEX = 9
  TIME_INDEX = 10
  SPEED_INDEX = 11
  RACE_DETAIL_INDEX = 12
  MESSAGE_INDEX = 13

  def call(race, import_filename)
    @race = race
    @filename = import_filename
    nb = 0
    open(@filename) do |file|
      file.each_line do |line|
        nb += 1
        next if nb == 1
        CSV.parse(utf8_encoded_content(line), col_sep: CSV_SEPARATOR) do |row|
          if row
            existing_row_in_db = @race.results.where( bib: row[NUMBER_INDEX],race_detail: row[RACE_DETAIL_INDEX] )
            if existing_row_in_db.any?
              if there_are_differences?(existing_row_in_db.first, row)
                existing_row_in_db.first.update_attributes(
                  phone: row[PHONE_INDEX],
                  mail: row[MAIL_INDEX],
                  rank: row[RANK_INDEX],
                  name: Utils.titlecase(row[NAME_INDEX]),
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
                  race_detail: row[RACE_DETAIL_INDEX]
                )
              end
            else
							if row[NUMBER_INDEX].nil?
								row[NUMBER_INDEX] = -nb
							end
              @race.results.create(
                phone: row[PHONE_INDEX],
                mail: row[MAIL_INDEX],
                rank: row[RANK_INDEX],
                name: Utils.titlecase(row[NAME_INDEX]),
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
                race_detail: row[RACE_DETAIL_INDEX]
              )
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
    changes << :name if (old.name != Utils.titlecase(row[NAME_INDEX]))
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
