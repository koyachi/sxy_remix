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
last_segment_index = 300
short_segments = segments[0..last_segment_index]

def my_sequence
  results = []

  one_segment = 16
  #rand_max = 16
  rand_max = 4
  sequence = one_segment

  loop do
    v = rand(rand_max)
    results.push(v)
    sequence = sequence - v
    break if sequence <= 0
  end
  if sequence > 0
    results.push(sequece)
  end
  tmp = results[0..-2].inject(0){|r,i| r + i}
  if tmp + results[-1] > one_segment
    results[-1] = one_segment - tmp
  end

  results
end

results = []
(0..16).each do |v|
  results.push(my_sequence)
end

puts "[results array]"
pp results

last_segments = []
results.each_with_index do |one_segment, i|
  one_segment.each_with_index do |duration, j|
    puts "[i,j] = [#{i}, #{j}]"
    segment_index = start_segment_index + i * one_segment.length + j
    if segment_index > last_segment_index
      segment_index = segment_index % last_segment_index
    end
    if segment_index < start_segment_index
      segment_index = start_segment_index + segment_index % start_segment_index
    end
    segment = segments[segment_index]
    #last_segments.push(segment.stretch(duration * 100).pitch((1.0 / duration) * 100))
    last_segments.push(segment.stretch(duration * 100))
  end
end

last_segments.reduce(:+) > "_results/edit3.1.#{Time.now.to_i}.wav"
puts "end"

