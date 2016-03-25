class Question < ActiveRecord::Base
    belongs_to :post, dependent: :destroy
end
