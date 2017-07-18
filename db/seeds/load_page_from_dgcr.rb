require 'open-uri'
require 'nokogiri'
require 'pg'

base_url = "https://www.dgcoursereview.com/"
url = "https://www.dgcoursereview.com/scorebook.php?vall=1&mid=70191"
page = Nokogiri::HTML(open(url))

links = page.xpath('//*[@id="browse_menu"]/ul/li[1]/a')[1..-1].map { |link| link['href'] }

links.each do |link|
  doc = Nokogiri::HTML(open(base_url + link))
  title = doc.css("span.score")

  # Get info needed to create the round
  print course_name = title.text.split("at")[-1].split("in")[0].strip
  print weather = doc.css("tr")[1].css("td")[4].text.strip
  puts holes_played = doc.css("tr")[1].css("td")[1].text.split("/")[1].strip

  # Find the course and user
  course = Course.find_by(name: course_name)
  user = User.find_by(email: "mmcquinn77@gmail.com")

  round = Round.create(user: user, course: course, weather: weather)

  scores_table = doc.css("table")[1]
  scores_rows = scores_table.css("tr")[1..-2]
  scores_rows.each_with_index do |row, index|
    stroke = row.css("td")[3].text
    Score.create(round: round, hole: course.holes.find_by(number: index+1), strokes: stroke)
  end
end
