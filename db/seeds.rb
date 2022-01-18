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

# Phase.create(phase_one)
all_phases = (1..4).to_a.map do |num|
    url = "https://api.github.com/repos/learn-co-curriculum/phase-#{num}-syllabus-flex-60-week/contents/README.md"
    resp = HTTParty.get(url)
    download = HTTParty.get(resp["download_url"])
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    html = Nokogiri::HTML(markdown.render(download.body))

    # binding.pry
    # Need to find a way to get the amount of weeks
    # Using breakdown to figure it out
    
    breakdown1 = Breakdown.create(week_range: 1)
    breakdown2 = Breakdown.create(week_range: 2)
    breakdown3 = Breakdown.create(week_range: 3)
    breakdown4 = Breakdown.create(week_range: 4)
    def next_content(element)
        if !element
            nil
        else
            puts "FLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAGFLAG"
            puts element.next_element
            element.next_element ? element.next_element.inner_html : nil
        end
    end

    def create_hash(element)
        head = element.inner_html
        description = next_content(element)
        total_assignments = next_content(element.next_element)
        lis = element.next_element.next_element)
        {head: head, description: description, total_assignments: total_assignments, lis: lis}

    end
    system('clear')
    week_headers = html.css('h2').map.with_index(0) do |head, index|
        puts head.inner_html
       create_hash(head)
    end

    def create_lessons(list_li_elements)
        mods = list_li_elements.map do |li|
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
                {title: title, amount: amount, optional: optional, breakdown: breakdown} 
            end
        end.compact
    end

    # LOOP THROUGH LIS AND CREATE A LESSONS OBJECT FOR EACH
end

all_phases.each do |phase|
    Phase.create(phase)
end
