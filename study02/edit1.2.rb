require "scissor/echonest"
require "yaml"
require "pp"

start_beat_index = 0
last_beat_index = 209
beats = []

file = ARGV[0]
info = YAML.load_file(file)
scissor = Scissor(info[:file])
info[:beats][0..last_beat_index].each_with_index do |beat, i|
  f = beat.fragments[0]
  beats.push(scissor[f.start, f.duration])
end


def my_sequence
  results = []

  duration_map = [
    0.1,
    0.2,
    0.25,
    0.3,
    0.5,
    0.8,
    1.0,
    1.2,
    1.5,
    1.75,
    1.8,
    1.9,
    2.0,
    6.0,
    10.0
  ]

  one_segment = 8
  rand_max = duration_map.length
  sequence = one_segment

  loop do
    v = duration_map[rand(rand_max)]
    results.push(v)
    sequence = sequence - 1
    break if sequence <= 0
  end

  results
end

results = []
(0..16).each do |v|
  results.push(my_sequence)
end

puts "[results array]"
pp results

last_beats = []
results.each_with_index do |one_segment, i|
  one_segment.each_with_index do |duration, j|
    puts "[i,j] = [#{i}, #{j}]"
    beat_index = start_beat_index + i * one_segment.length + j
    if beat_index > last_beat_index
      beat_index = beat_index % last_beat_index
    end
    if beat_index < start_beat_index
      beat_index = start_beat_index + beat_index % start_beat_index
    end
    beat = beats[beat_index]
    #last_beats.push(beat.stretch(duration * 100).pitch((1.0 / duration) * 100))
    last_beats.push(beat.stretch(duration * 100))
  end
end

first_beat = last_beats.shift
last_beats.inject(first_beat){|r, b| r + b} > "_results/edit1.2.#{Time.now.to_i}.wav"
puts "end"
