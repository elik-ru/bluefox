class CandidateAbility < ActiveRecord::Base
  
  belongs_to :candidate
  belongs_to :ability
  
end
