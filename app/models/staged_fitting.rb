class StagedFitting < ApplicationRecord
  belongs_to :staging
  belongs_to :fitting

  after_save { |staged_fitting| staged_fitting.destroy if staged_fitting.target_quantity < 1 }
end
