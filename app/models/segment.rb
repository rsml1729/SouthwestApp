class Segment < ApplicationRecord
  belongs_to :pnr#, :primary_key => 'rcrd_loc'
end
