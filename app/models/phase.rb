class Phase < ApplicationRecord
    has_many :mods
    accepts_nested_attributes_for :mods

    def total
        self.mods.reduce(0) do |acc, mod|
            mod.optional ? acc : acc + mod.amount 
        end
    end
end
