require 'open-uri'
require 'nokogiri'
require 'pg'

mo_url = "https://www.dgcoursereview.com/browse.php?cname=&designer=&holes=0&length_min=&length_max=&holetype=0&coursetype=a%3A2%3A%7Bi%3A0%3Bs%3A1%3A%221%22%3Bi%3A1%3Bs%3A1%3A%222%22%3B%7D&terrain=a%3A3%3A%7Bi%3A0%3Bi%3A1%3Bi%3A1%3Bi%3A2%3Bi%3A2%3Bi%3A3%3B%7D&landscape=a%3A3%3A%7Bi%3A0%3Bi%3A1%3Bi%3A1%3Bi%3A2%3Bi%3A2%3Bi%3A3%3B%7D&teetype=0&mtees=&mpins=&num_reviews=&rating_min=&rating_max=&yem=&yex=&country=1&state=30&city=&photos=&videos=&tourneys=&camping=&restrooms=&nopets=&private=1&paytoplay=1&on_bg=&extinct=&zipcode=&zip_distance=&sort=name&order=ASC&page="

all_url = "https://www.dgcoursereview.com/browse.php?cname=&designer=&holes=0&length_min=&length_max=&holetype=0&coursetype=a%3A2%3A%7Bi%3A0%3Bs%3A1%3A%221%22%3Bi%3A1%3Bs%3A1%3A%222%22%3B%7D&terrain=a%3A3%3A%7Bi%3A0%3Bi%3A1%3Bi%3A1%3Bi%3A2%3Bi%3A2%3Bi%3A3%3B%7D&landscape=a%3A3%3A%7Bi%3A0%3Bi%3A1%3Bi%3A1%3Bi%3A2%3Bi%3A2%3Bi%3A3%3B%7D&teetype=0&mtees=&mpins=&num_reviews=&rating_min=&rating_max=&yem=&yex=&country=1&state=&city=&photos=&videos=&tourneys=&camping=&restrooms=&nopets=&private=1&paytoplay=1&on_bg=&extinct=&zipcode=&zip_distance=&sort=name&order=ASC&page="

# loop through all pages of the courses
285.times do |i|
  doc = Nokogiri::HTML(open(all_url + (i+1).to_s))
  # get all courses on the page
  course_links = doc.css("tr.note")
  # loop through the courses
  course_links.each do |course_link|
    course = course_link.text.each_line.reject{|x| x.strip == ""}.collect{|x| x.strip}
    name = course[0]
    city = course[1].split(",")[0]
    state = course[1].split(",")[1].strip
    num_holes = course[2]
    basket_type = course[3]
    tee_type = course[4]
    Course.create(name: name,
               city: city,
               state: state,
               num_holes: num_holes,
               basket_type: basket_type,
               tee_type: tee_type)
  end
end
