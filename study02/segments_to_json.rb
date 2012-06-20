require "scissor/echonest"
require "yaml"
require "json"

results = []

file = ARGV[0]
info = YAML.load_file(file)
info[:segments].each_with_index do |segment, i|
  f = segment.fragments[0]
  results.push({
    :index => i,
    :start => f.start,
    :duration => f.duration,
    :pitch => f.pitch,
    :confidence => segment.confidence,
    :loudness => {
      :time => segment.loudness.time,
      :value => segment.loudness.value,
    },
    :max_loudness => {
      :time => segment.max_loudness.time,
      :value => segment.max_loudness.value,
    },
    :pitches => segment.pitches,
    :timbre => segment.timbre
  })
end

puts results.to_json
