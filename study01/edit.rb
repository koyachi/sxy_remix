require "scissor/echonest"
require "yaml"
require "pp"

start_beat_index = 36
last_beat_index = 188
beats = []

info = YAML.load_file("a.rb.result.trimed")
scissor = Scissor(info[:file])
info[:beats][0..last_beat_index].each_with_index do |beat, i|
  f = beat.fragments[0]
  beats.push(scissor[f.start, f.duration])
end


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
last_beats.inject(first_beat){|r, b| r + b} > "edited.wav"
puts "end"
