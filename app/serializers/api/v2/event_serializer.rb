module API
  module V2
    class EventSerializer < Blueprinter::Base
      identifier :id
      fields  :name,
              :place
    end
  end
end
