require "scissor/echonest"
require "yaml"
require "pp"

start_segment_index = 0
last_segment_index = 674
segments = []

file = ARGV[0]
info = YAML.load_file(file)
scissor = Scissor(info[:file])
info[:segments][0..last_segment_index].each_with_index do |segment, i|
  f = segment.fragments[0]
  segments.push(scissor[f.start, f.duration])
end

segments.sort!{|a, b| a.duration <=>  b.duration}
segments.reduce(:+) > "_results/edit3.#{Time.now.to_i}.wav"
puts "end"

