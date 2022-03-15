# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first) 

# # Phase.create(phase_one)
all_phases = (1..4).to_a.map.with_index(1) do |num, phase_id|
    url = "https://api.github.com/repos/learn-co-curriculum/phase-#{num}-syllabus-flex-60-week/contents/README.md"
    resp = HTTParty.get(url)
    download = HTTParty.get(resp["download_url"])
    renderer = Redcarpet::Render::HTML.new(prettify: true)
    markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
    html = Nokogiri::HTML(markdown.render(download.body))

    # binding.pry
    # Need to find a way to get the amount of weeks
    # Using breakdown to figure it out
    


    def next_content(element)
        if !element
            nil
        else
            element.next_element ? element.next_element.inner_html : nil
        end
    end

    def create_lessons(node, id, phase_id)
        # binding.pry
        return [] if (!node)
        mods = node.css('li').map.with_index(1) do |li, index|
            mod = li.inner_html.split(/[()]+/)
            if(mod.length > 1 && !mod[0].blank?)
                title = mod[0]
                amount_check = mod[1].split(" - ")
                # binding.pry
                if(amount_check.length > 1)
                    amount = amount_check[0]
                    optional = true
                else
                    amount = mod[1]
                    optional = false
                end
                {title: title, amount: amount, optional: optional, breakdown_id: id, phase_id: phase_id} 
            elsif(mod.length > 1)
                if(mod.include?("Optional"))
                    amount = mod[3]
                    title = mod[2]
                    optional = true
                end
                {title: title, amount: amount, optional: optional, breakdown_id: id, phase_id: phase_id } 
            end
        end.compact

    end

    def create_hash(element, index, phase_id)
        head = element.inner_html
        description = next_content(element)
        total_assignments = next_content(element.next_element)
        if head.split(" ")[0] == "Weeks" || head.split(" ")[0] == "Week"
            node = element
            while node && node.css('li').length == 0 do
                node = node.next_element
            end
        end

        lis = create_lessons(node, index, phase_id)
        {head: head, description: description, total_assignments: total_assignments, lis: lis, phase_id: phase_id}
        

    end
    system('clear')
    
    

    week_headers = html.css('h2').map.with_index(0) do |head, index|
       create_hash(head, index, phase_id)
    end
end
numStringArr = ["One", "Two", "Three", "Four"]
phases = all_phases.map.with_index(0) do |breakdownArr, index|
    num = numStringArr[index]
    phase = Phase.create(num: num)
    breakdownArr.map do |bd|
        # binding.pry
        Breakdown.create(week_range: bd[:head], total_assignments: bd[:total_assignments] ,phase_id: bd[:phase_id], description: bd[:description], mods: bd[:lis].map{|mod| Mod.find_or_create_by(mod)} )
    end
end
binding.pry

# binding.pry


# Goal: FINISH Additional Practices (11 Labs)
# Last Week: FINISH CONTEXT (x)
# Blockers: What were the blockers?
# Got stuck thinking he should know this. Started to do something different. He started to do the readings and then went through the labs. He wants to keep that in mind.
# Knowledge: What concepts did you struggle with?
# Form - but got a sense of it now
# Single page application
# Timing: Did you have enough time to complete assignments in your life?
# Had enough time and was able to make adjustment.
# Goal: Was the goal too much or too little?
# Inconsistent I screwed up numbering.


# Goal.create({goal: "FINISH Additional Practices (11 Labs)", blockers: "Got stuck thinking he should know this. Started to do something different. He started to do the readings and then went through the labs. He wants to keep that in mind.", knowledge: "Form - but got a sense of it now", timing: "Had enough Time and was able to make adjustment.", amount: "Incosistent I screwed up numbering", user_id: 1})
