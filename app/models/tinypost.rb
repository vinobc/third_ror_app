# == Schema Information
#
# Table name: tinyposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tinypost < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  
  validates :content, :presence=>true,
                      :length=>{:maximum=>140}
  validates :user_id, :presence=>true
  
  default_scope :order => 'tinyposts.created_at DESC'
end
