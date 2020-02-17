module Docs
  module V1
    module Races
      extend Dox::DSL::Syntax

      document :api do
        resource 'Courses' do
          endpoint '/races'
          group 'API Résultat de Courses'
          desc "Une course contient plusieurs résultats."
        end
      end

      document :index do
        action "Obtenir toutes les courses d'une édition"
      end

      document :show do
        action "Obtenir une course"
      end

      document :update do
        action "Mettre à jour une course"
      end

      document :create do
        action "Ajouter une course à une édition"
      end

      document :destroy do
        action "Supprimer une course"
      end
    end
  end
end