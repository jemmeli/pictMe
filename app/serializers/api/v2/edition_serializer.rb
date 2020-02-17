module API
  module V2
    class EditionSerializer < Blueprinter::Base
      identifier :id

      view :with_event do
        fields :date
        association :event, blueprint: EventSerializer
      end
    end
  end
end
