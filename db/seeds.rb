if Rails.env.development?
  ActiveRecord::Base.transaction do
    puts "On casse tout"
    Photo.destroy_all
    Result.destroy_all
    Race.destroy_all
    Edition.destroy_all
    Event.destroy_all
    Runner.destroy_all

    puts "Que la fête commence ..."
    ## CREATION OF RUNNERS
    60.times do
      sex    = ["male", "female"].sample
      runner = Runner.new(
        first_name: FFaker::Name.send("first_name_#{sex}"),
        last_name:  FFaker::Name.last_name,
        dob:        FFaker::Time.between(60.years.ago, 18.years.ago),
        sex:        sex.first.upcase,
        category:   FFaker::Airline.name,
      )
      runner.save(validate: false)
      puts "Runner #{runner.first_name} #{runner.last_name} created"
    end

    ## CREATION OF EVENTS
    20.times do 
      eve = Event.new(
        name: "Event #{FFaker::Product.brand}",
        place: FFaker::AddressFR.city,
        phone: FFaker::PhoneNumberFR.phone_number,
        website: FFaker::Internet.http_url,
      )
      eve.save(validate: false)
      puts "#{eve.name} created"
    end

    ## CREATION OF EDITIONS
    Event.all.each do |event|
      2.times do
        edi = Edition.new(
          event: event,
          date: Date.new(rand(2005..2020), rand(1..12), rand(1..28)),
          description: "Edition #{FFaker::Product.brand}",
        )
        edi.save(validate: false)
        puts "#{edi.description} created"
      end
    end

    ## CREATION OF RACES
    Edition.all.each do |edition|
      2.times do
        rac = Race.new(
          edition:   edition,
          name:      "Race #{FFaker::Product.brand}",
          race_type: ['trail', 'route', 'funrace'].sample,
        )
        rac.save(validate: false)
        puts "#{rac.name} created"
      end
    end

    ## CREATION OF RESULTS
    Race.all.each do |race|
      Runner.all.sample(50).each do |runner|
        res = Result.new(
          race: race,
          edition: race.edition,
          runner: runner,
          rank: rand(1..50),
          speed: rand(8..16),
          time: "#{rand.to_s[2..3]}:#{rand.to_s[2..3]}:#{rand.to_s[2..3]}",
        )
        res.save(validate: false)
        puts "New result created"
      end
    end

    ## CREATION OF PHOTOS
    fifty_photos = ["http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff0/f25/dc-/original/DSC_0569.jpg?1539998873",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff0/fc8/79-/original/DSC_0468.jpg?1540091728",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/2c0/31-/original/Reduite_202_20%28138%29.jpg?1540036298",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/37d/5f-/original/DSC_0099.jpg?1540091657",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/4fa/91-/original/P1020487_20-_20Copie_20%282%29.jpg?1546179711",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/995/85-/original/LOL_3276.jpg?1499688793",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/ac9/86-/original/DSC_0017.jpg?1540016252",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/be8/a9-/original/DSC_0433.jpg?1540091716",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff1/bf5/d3-/original/DSC_0025.jpg?1540016272",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff2/689/96-/original/P1020629.jpg?1546179762",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff2/f23/e7-/original/reduite_200_20%28803%29.jpg?1540049997",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff3/872/b4-/original/DSC_0717.jpg?1540001037",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff3/8c8/ec-/original/DSC_0427.jpg?1540001706",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff4/458/09-/original/DSC_0437.jpg?1540017671",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff5/06c/df-/original/DSC_0110.jpg?1540016548",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff5/5dc/2f-/original/DSC_0964.jpg?1540015737",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff5/6b1/57-/original/Reduite_202_20%28473%29.jpg?1540036402",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff5/78f/6d-/original/DSC_0718.jpg?1540134759",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff5/f68/f0-/original/LOL_3488.jpg?1499866524",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff6/91b/9d-/original/BAP_4226.jpg?1493031625",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff6/c79/59-/original/P1060795.jpg?1539957733",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff6/fdb/1d-/original/Reduite_202_20%28742%29.jpg?1540048373",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff7/e33/d1-/original/LOL_4104.jpg?1499866776",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff9/66f/af-/original/P1030085.jpg?1546179894",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff9/743/11-/original/LOL_2703.jpg?1499684471",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff9/873/65-/original/P1010283.jpg?1546182819",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff9/bee/0f-/original/DSC_0160.jpg?1539998125",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff9/c3d/f3-/original/DSCN7437.jpg?1539956413",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ff9/ef2/78-/original/reduite_200_20%28429%29.jpg?1540049703",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffa/3a8/a7-/original/BAP_4233.jpg?1493031625",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffa/a39/0c-/original/DSC_0992.jpg?1539999652",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffa/a82/1e-/original/IMG_3765.jpg?1546183351",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffa/c1f/8a-/original/P1020570.jpg?1546179737",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffa/c5e/e2-/original/DSC_0031.jpg?1539997756",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffa/e17/ed-/original/DSC_0986.jpg?1540015825",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffb/b65/30-/original/IMG_3974.jpg?1546183412",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffc/04f/15-/original/DSC_0229.jpg?1539998212",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffc/0a7/6c-/original/DSCN7649.jpg?1540091779",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffc/93f/99-/original/DSC_0014.jpg?1540016227",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffc/a47/0c-/original/P1060471.jpg?1539957271",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffc/a85/ce-/original/BAP_4542.jpg?1493126314",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffd/251/b3-/original/DSC_0491.jpg?1540022068",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffd/844/8e-/original/DSC_0519.jpg?1539998794",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffe/0a3/8f-/original/IMG_3869.jpg?1546183385",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffe/5c7/56-/original/P1060054.jpg?1539956725",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffe/5f0/3e-/original/P1060570.jpg?1539957472",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/ffe/d8c/8f-/original/IMG_3798.jpg?1546183358",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/fff/0c2/3c-/original/DSCN7178.jpg?1539956060",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/fff/b01/c3-/original/DSCN7269.jpg?1539956219",
    "http://s3-eu-west-1.amazonaws.com/kapp10finishline/photos/images/fff/d38/d4-/original/P1010262.jpg?1546182813"]

    Result.all.each_with_index do |result, index|
      random_bib = rand(1..999)
      photo = Photo.new(
        bib:              random_bib,
        edition:          result.edition,
        direct_image_url: fifty_photos.sample,
      )

      photo.save(validate: false)

      result.update(
        bib: random_bib,
      )

      puts "Photo #{index + 1} created"
    end

    ## RESULTS CATEG
    categ = ['xxs', 'xs', 's', 'm', 'l', 'xl', 'xxl', 'xxxl']

    Result.all.each {|r| r.update(categ: categ.sample)}
  end
  puts "Et voilà c'est seedé !"
else
  puts "Your not in development mode!"
end
