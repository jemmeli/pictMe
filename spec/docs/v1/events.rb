module Docs
  module V1
    module Events
      extend Dox::DSL::Syntax

      document :api do
        resource 'Évènements' do
          endpoint '/events'
          group 'API Résultat de Courses'
          desc "Un évènement contient plusieurs éditions."
        end

        group 'API Résultat de Courses' do
          desc "L'API Courses est organisée hiérarchiquement : Évènements > Éditions > Courses > Résultats."
        end
      end

      document :index do
        action 'Obtenir tous les évènements'
      end

      document :show do
        action 'Obtenir un évènement particulier'
      end

      document :update do
        action 'Mettre à jour un évènement'
      end

      document :create do
        action 'Créer un évènement'
      end

      document :destroy do
        action 'Supprimer un évènement'
      end
    end
  end
end