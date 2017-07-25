require 'open-uri'
require 'nokogiri'
require 'pg'

base_url = "https://www.dgcoursereview.com/"
pages = 11

pages.times do |page_num|
  url = "https://www.dgcoursereview.com/scorebook.php?vall=1&vcrse=&ovcrse=&sort=date&order=&tee_filt=N%3B&mid=70191&fd=&sd=&sbmtd=1&page=#{page_num+1}"
  page = Nokogiri::HTML(open(url))

  links = page.xpath('//*[@id="browse_menu"]/ul/li[1]/a')[1..-1].map { |link| link['href'] }

  links.each do |link|
    doc = Nokogiri::HTML(open(base_url + link))
    title = doc.css("span.score")

    # Get info needed to create the round
    course_name = title.text.split("at")[-1].split("in")[0].strip
    state = title.text.split("at")[-1].split(",")[1].strip
    weather = doc.css("tr")[1].css("td")[4].text.strip
    holes_played = doc.css("tr")[1].css("td")[1].text.split("/")[1].strip

    # Find the course and user
    course = Course.find_by(name: course_name, state: state)
    user = User.find_by(email: "mmcquinn77@gmail.com")

    round = Round.create(user: user, course: course, weather: weather)

    scores_table = doc.css("table")[1]
    scores_rows = scores_table.css("tr")[1..-2]
    scores_rows.each_with_index do |row, index|
      if row.css("td")[3].nil?
        stroke = nil
      elsif
        stroke = row.css("td")[3].text
      end
      Score.create(round: round, hole: course.holes[index], strokes: stroke)
    end
  end
end
