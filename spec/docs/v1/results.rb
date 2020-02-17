module Docs
  module V1
    module Results
      extend Dox::DSL::Syntax

      document :api do
        resource 'Résultats' do
          endpoint '/results'
          group 'API Résultat de Courses'
          desc "Résultat d'un coureur pour une course donnée. Attention ! Les résultats peuvent être associés à des coureurs qui ne sont pas dans la base coureurs !"
        end
      end

      document :index do
        action "Obtenir toutes les résultats d'une course, d'une édition ou d'un coureur"
      end

      document :show do
        action "Obtenir un résultat"
      end

      document :update do
        action "Mettre à jour un résultat"
      end

      document :create do
        action "Ajouter un résultat à une course, une édition ou un coureur"
      end

      document :destroy do
        action "Supprimer un résultat"
      end
    end
  end
end