class Post < ApplicationRecord
    #belongs_to :User
    validates_presence_of :date, :rationale
end
