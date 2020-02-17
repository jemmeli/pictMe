module API
  module V2
    class RaceSerializer < Blueprinter::Base
      identifier :id

      view :with_edition do
        fields  :name,
                :race_type
        association :edition, blueprint: EditionSerializer, view: :with_event
      end
    end
  end
end
