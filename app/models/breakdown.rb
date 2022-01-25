class Breakdown < ApplicationRecord
    has_many :mods
    accepts_nested_attributes_for :mods
    belongs_to :phase
    
end
