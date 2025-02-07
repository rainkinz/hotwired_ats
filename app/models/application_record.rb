class ApplicationRecord < ActiveRecord::Base
  include CableReady::Updatable
  include CableReady::Broadcaster
  primary_abstract_class

  # Since ordering by uuid is not so useful
  self.implicit_order_column = 'created_at'
end
