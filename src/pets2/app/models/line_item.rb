class LineItem < ActiveRecord::Base
  belongs_to :animal
  belongs_to :consideration
end
