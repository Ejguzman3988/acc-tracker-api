# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# phase_one = {
#     num: 'one',
#     mods_attributes: [
#         {
#             title: "JavaScript Fundamentals", 
#             amount: 11,
#         },
#         {
#             title: "Functions in JavaScript",
#             amount: 10
#         },
#         {
#             title: "Scope", 
#             amount: 6
#         },
#         {
#             title: "Working with Data Structures in JavaScript", 
#             amount: 13
#         },
#         {
#             title: "Video Series: Array Iteration", 
#             amount: 7
#         },
#         {
#             title: "Array Iteration",
#             amount: 12
#         },
#         {
#             title: "JavaScript Advanced Syntax",
#             amount: 3
#         }
#     ]
# }

# Phase.create(phase_one)
all_phases = (1..4).to_a.map do |num|
    url = "https://api.github.com/repos/learn-co-curriculum/phase-#{num}-syllabus-flex-60-week/contents/README.md"
    resp = HTTParty.get(url)
    download = HTTParty.get(resp["download_url"])
    
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    html = Nokogiri::HTML(markdown.render(download.body))
    
    mods = html.css('li').map do |li|
        mod = li.inner_html.split(/[()]+/)
        if(mod.length > 1 && !mod[0].blank?)
            title = mod[0]
            amount_check = mod[1].split(" - ")
            if(amount_check.length > 1)
                amount = amount_check[0]
                optional = true
            else
                amount = mod[1]
                optional = false
            
            end
            {title: title, amount: amount, optional: optional} 
        end
    end.compact
    alpha_num = ['one','two','three','four']
    { 
        num: alpha_num[num-1],
        mods_attributes: mods
    }
end

all_phases.each do |phase|
    Phase.create(phase)
end
