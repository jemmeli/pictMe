module Docs
  module V1
    module Runners
      extend Dox::DSL::Syntax

      document :api do
        resource 'Coureur' do
          endpoint '/runner'
          group 'API des coureurs'
          desc "Un coureur possède plusieurs résultats de courses et plusieurs photos."
        end
      end

      document :index do
        action "Obtenir tous les coureurs"
      end

      document :show do
        action "Obtenir un coureur"
      end

      document :update do
        action "Mettre à jour un coureur"
      end

      document :create do
        action "Ajouter une coureur"
      end

      document :destroy do
        action "Supprimer une coureur"
      end
    end
  end
end