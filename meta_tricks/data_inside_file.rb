
DATA.each do |line|
  first, last, phone, email = line.split('|')
  puts <<-EOM
First name: #{first}
Last name: #{last}
Phone: #{phone}
Email: #{email}
  EOM
end

__END__
David|Black|123-456-7890|dblack@...
Someone|Else|321-888-8888|someone@else