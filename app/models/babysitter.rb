class Babysitter < ApplicationRecord
	scope :initial_paginate, -> (max_load){ order('created_at DESC').limit(max_load) }
	scope :forward_paginate, -> (end_cursor, max_load){ order('created_at DESC').where("id < :end_cursor", {end_cursor: end_cursor}).limit(max_load) }
	scope :backward_paginate, -> (start_cursor, max_load){ order('created_at ASC').where("id > :start_cursor", {start_cursor: start_cursor}).limit(max_load) }

	validates :first_name, presence: true # добвил просто чтобы демонстрировать автотест

end
