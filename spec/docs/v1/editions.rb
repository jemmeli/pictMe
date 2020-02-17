module Docs
  module V1
    module Editions
      extend Dox::DSL::Syntax

      document :api do
        resource 'Éditions' do
          endpoint '/editions'
          group 'API Résultat de Courses'
          desc "Une édition d'un évènement contient plusieurs courses."
        end
      end

      document :index do
        action "Obtenir toutes les éditions d'un évènement"
      end

      document :show do
        action "Obtenir une édition"
      end

      document :update do
        action "Mettre à jour une édition"
      end

      document :create do
        action "Ajouter une édition à un évènement"
      end

      document :destroy do
        action "Supprimer une édition"
      end
    end
  end
end