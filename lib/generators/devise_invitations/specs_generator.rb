module DeviseInvitations
  module Generators
    class SpecsGenerator < Rails::Generators::Base
      source_root File.expand_path('../specs/templates', __FILE__)

      def copy_factory
        copy_file('factory.rb', 'spec/factories/invitations.rb')
      end

      def copy_controller
        copy_file('controller.rb', 'spec/controllers/invitations_controller_spec.rb')
      end

      def copy_model
        copy_file('model.rb', 'spec/models/invitation_spec.rb')
      end

      def inject_association
        inject_into_file('spec/models/user_spec.rb', after: 'RSpec.describe User, type: :model do') do
          File.read(
            File.join(
              File.expand_path('../specs/templates', __FILE__),
              'association.rb'
            )
          )
        end
      end
    end
  end
end
