require 'nokogiri'
require 'httparty'

base_url = "https://www.dgcoursereview.com/browse.php?country=1&state=7&page="
end_page = 8

end_page.times do |index|
  current_page = index + 1
  puts "On page #{current_page}"
  course_results = HTTParty.get(base_url + current_page.to_s)
  doc = Nokogiri::HTML(course_results)

  # Grab all course links on the page
  courses = doc.css("tr.note")
  courses.each do |course|
    row = course.text.each_line.reject{|x| x.strip == ""}.collect{|x| x.strip}
    link = course.css("a")[0]['href']
    id = link.split('=')[1]

    name = row[0]
    city = row[1].split(",")[0]
    state = row[1].split(",")[1].strip
    num_holes = row[2]
    basket_type = row[3]
    tee_type = row[4]

    # save the course as CSV
    puts "On #{name}: #{link}"
    saved_course = Course.create(name: name,
                 city: city,
                 state: state,
                 num_holes: num_holes,
                 basket_type: basket_type,
                 tee_type: tee_type,
                 latitude: nil,
                 longitude: nil)

    # get all of the Holes for the course we just saved
    hole_page = HTTParty.get(link + "&mode=hi")
    hole_doc = Nokogiri::HTML(hole_page)
    hole_rows = hole_doc.css("table")[0].css("tr").select { |row| row['style'] == nil }[1..-3]
    puts "Found #{hole_rows.count} holes"
    hole_rows.each do |hole_row|
      number = hole_row.css("span").text
      # special case
      if number == "Bask"
        number = 1
      end

      # if the course has multiple layouts we need to do things different
      if hole_row.css("td")[3] != nil
        distance = hole_row.css("td")[3].children[0].text.tr(' ft', '')
      elsif hole_row.css("td")[2] != nil
        distance = hole_row.css("td")[2].children[0].text.tr(' ft', '')
      else
        distance = ""
      end

      # special case
      if distance == "--"
        distance = ""
      end

      if hole_row.css("td sup")[0] == nil
        par = nil
      else
        par = hole_row.css("td sup")[0].text.tr('()', '').strip
      end

      # save the hole
      Hole.create(course: saved_course,
                 number: number,
                 par: par,
                 distance: distance)
    end
  end
end
