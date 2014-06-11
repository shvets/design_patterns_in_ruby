#! /usr/bin/env ruby

# http://georgedrummond.com/monty-hall-problem-in-ruby/

NUMBER_OF_GAMES = 1_000_000

won_staying  = 0
won_changing = 0

def percent(games)
  percent = (games.to_f / NUMBER_OF_GAMES.to_f) * 100
  percent.round(3)
end

def won_staying?
  doors = (1..3).to_a
  chosen_door  = doors.sample
  correct_door = doors.sample

  chosen_door == correct_door
end

(1..NUMBER_OF_GAMES).each do
  if won_staying?
    won_staying += 1
  else
    won_changing += 1
  end
end

puts "Number of runs: #{NUMBER_OF_GAMES}"
puts "Won staying: #{percent won_staying}% (#{won_staying})"
puts "Won changing: #{percent won_changing}% (#{won_changing})"