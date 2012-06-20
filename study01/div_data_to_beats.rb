require "scissor/echonest"
require "pit"
require "yaml"

#Scissor.echonest_api_key = Pit.get("developer.echonest.com", :require => {
#  "api_key" => "your api key"
#})["api_key"]


info = YAML.load_file("a.rb.result.trimed")
scissor = Scissor(info[:file])
info[:beats].each_with_index do |beat, i|
  f = beat.fragments[0]
  scissor[f.start, f.duration] > "./_beats/beat_%05d.wav" % i
end
