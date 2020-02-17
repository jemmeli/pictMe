module Docs
  module V1
    module Photos
      extend Dox::DSL::Syntax

      document :api do
        resource 'Photos' do
          endpoint '/photos'
          group 'API Résultat de Courses'
          desc "Photos prises lors de course. La photo n'est pas nécessairement associé à un coureur de la base (runner)"
        end
      end

      document :index do
        action "Obtenir toutes les photos d'une course ou d'une édition"
      end

      document :show do
        action "Obtenir une photo"
      end

      document :update do
        action "Mettre à jour une photo"
      end

      document :create do
        action "Ajouter une photo à une course ou à une édition"
      end

      document :destroy do
        action "Supprimer une photo"
      end
    end
  end
end