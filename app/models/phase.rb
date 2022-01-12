class Phase < ApplicationRecord
    has_many :mods
    accepts_nested_attributes_for :mods
end
