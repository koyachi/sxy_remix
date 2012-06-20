require "scissor/echonest"
require "pit"
require "yaml"

Scissor.echonest_api_key = Pit.get("developer.echonest.com", :require => {
  "api_key" => "your api key"
})["api_key"]

file = "Chromatics - Tick Of The Clock.mp3"
scissor = Scissor("./#{file}")
info = {
  :file => file,
  :beats => scissor.beats,
  :bars => scissor.bars,
  :segments => scissor.segments,
}

puts YAML.dump(info)
