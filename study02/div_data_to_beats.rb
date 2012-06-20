require "scissor/echonest"
require "pit"
require "yaml"

file = ARGV[0]
info = YAML.load_file(file)
scissor = Scissor(info[:file])
info[:beats].each_with_index do |beat, i|
  f = beat.fragments[0]
  scissor[f.start, f.duration] > "./_beats/beat_%05d.wav" % i
end
