# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


%w(Adaptability
Aerilate
Aftermath
Air\ Lock
Analytic
Anger\ Point
Anticipation
Arena\ Trap
Aroma\ Veil
Aura\ Break
Bad\ Dreams
Battle\ Armor
Big\ Pecks
Blaze
Bulletproof
Cacophony
Cheek\ Pouch
Chlorophyll
Clear\ Body
Cloud\ Nine
Color\ Change
Competitive
Compound\ Eyes
Contrary
Cursed\ Body
Cute\ Charm
Damp
Dark\ Aura
Defeatist
Defiant
Delta\ Stream
Desolate\ Land
Download
Drizzle
Drought
Dry\ Skin
Early\ Bird
Effect\ Spore
Fairy\ Aura
Filter
Flame\ Body
Flare\ Boost
Flash\ Fire
Flower\ Gift
Flower\ Veil
Forecast
Forewarn
Friend\ Guard
Frisk
Fur\ Coat
Gale\ Wings
Gluttony
Gooey
Grass\ Pelt
Guts
Harvest
Healer
Heatproof
Heavy\ Metal
Honey\ Gather
Huge\ Power
Hustle
Hydration
Hyper\ Cutter
Ice\ Body
Illuminate
Illusion
Immunity
Imposter
Infiltrator
Inner\ Focus
Insomnia
Intimidate
Iron\ Barbs
Iron\ Fist
Justified
Keen\ Eye
Klutz
Leaf\ Guard
Levitate
Light\ Metal
Lightning\ Rod
Limber
Liquid\ Ooze
Magic\ Bounce
Magic\ Guard
Magician
Magma\ Armor
Magnet\ Pull
Marvel\ Scale
Mega\ Launcher
Minus
Mold\ Breaker
Moody
Motor\ Drive
Moxie
Multiscale
Multitype
Mummy
Natural\ Cure
No\ Guard
Normalize
Oblivious
Overcoat
Overgrow
Own\ Tempo
Parental\ Bond
Pickpocket
Pickup
Pixilate
Plus
Poison\ Heal
Poison\ Point
Poison\ Touch
Prankster
Pressure
Primordial\ Sea
Protean
Pure\ Power
Quick\ Feet
Rain\ Dish
Rattled
Reckless
Refrigerate
Regenerator
Rivalry
Rock\ Head
Rough\ Skin
Run\ Away
Sand\ Force
Sand\ Rush
Sand\ Stream
Sand\ Veil
Sap\ Sipper
Scrappy
Serene\ Grace
Shadow\ Tag
Shed\ Skin
Sheer\ Force
Shell\ Armor
Shield\ Dust
Simple
Skill\ Link
Slow\ Start
Sniper
Snow\ Cloak
Snow\ Warning
Solar\ Power
Solid\ Rock
Soundproof
Speed\ Boost
Stall
Stance\ Change
Static
Steadfast
Stench
Sticky\ Hold
Storm\ Drain
Strong\ Jaw
Sturdy
Suction\ Cups
Super\ Luck
Swarm
Sweet\ Veil
Swift\ Swim
Symbiosis
Synchronize
Tangled\ Feet
Technician
Telepathy
Teravolt
Thick\ Fat
Tinted\ Lens
Torrent
Tough\ Claws
Toxic\ Boost
Trace
Truant
Turboblaze
Unaware
Unburden
Unnerve
Victory\ Star
Vital\ Spirit
Volt\ Absorb
Water\ Absorb
Water\ Veil
Weak\ Armor
White\ Smoke
Wonder\ Guard
Wonder\ Skin
Zen\ Mode).each{|a| Ability.create(name: a) }


abilities=Ability.all
1000.times do |n|
  name=rand(2)==1 ? "#{Faker::Name.female_last_name} #{Faker::Name.female_first_name} #{Faker::Name.female_middle_name}" :  "#{Faker::Name.male_last_name} #{Faker::Name.male_first_name} #{Faker::Name.male_middle_name}" 
  contact_info= ( rand(2)==1 ? "+7" + Faker::PhoneNumber.phone_number  : Faker::Internet.free_email)  
  ab=[]
  rand(60..100).times{|n| ab.push (abilities[rand(abilities.size)])}
  
  ab.uniq!
  Candidate.create(name: name,
    contact_info: contact_info,
    is_active: rand(2),
    salary: rand(40)*5000,
    abilities: ab
  )
  
end


1000.times do |n|
  contact_info= Faker::Lorem.sentence + "\n\nEmail: " + Faker::Internet.free_email + "\nPhone: " + Faker::PhoneNumber.phone_number + "\n"
  ab=[]
  rand(3..7).times{|n| ab.push (abilities[rand(abilities.size)])}
  ab.uniq!
  
  Vacancy.create(title: Faker::Hacker.say_something_smart,
    contact_info: contact_info,
    added_at: rand(0..30).days.ago,
    expires_at: rand(-30..30).days.from_now,
    salary: rand(40)*5000,
    abilities: ab
  )
  
end


  
