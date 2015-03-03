
sent_emails_path = '../data/sent_emails.txt'
# read in list of emails already sent
sent_emails = []
File.open(sent_emails_path).each do |email|
  email = email.strip
  unless email == '' or email == 'email'
    sent_emails << email
  end
end

# read in full list from spreadsheet
emails = []
File.open('../data/emaillist.txt').each do |email|
  email = email.strip
  unless email == '' or email == 'email'
    unless sent_emails.include? email
      emails << email
    end
  end
end

emails.sort!

# create new lines
while emails.length > 0
  nowlist = emails.shift(5)
  outline = ''
  while nowlist.length > 0
    nowemail = nowlist.shift
    outline = "#{outline} #{nowemail}"
    sent_emails << nowemail
    outline += ','
  end
  puts outline
end

File.open(sent_emails_path, 'w') do |f|
  sent_emails.each {|email| f.puts(email)}
end
