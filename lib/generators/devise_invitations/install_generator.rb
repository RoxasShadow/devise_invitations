module DeviseInvitations
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def install
        %w(migrations models mailers controllers routes).each do |m|
          invoke "devise_invitations:#{m}"
        end
      end
    end

    class MigrationsGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../migrations/templates', __FILE__)

      def copy_migration
        migration_template('migration.rb', 'db/migrate/create_invitations.rb')
      end

      def self.next_migration_number(path)
        if @prev_migration
          @prev_migration += 1
        else
          @prev_migration = Time.now.utc.strftime('%Y%m%d%H%M%S').to_i
        end

        @prev_migration.to_s
      end
    end

    class ModelsGenerator < Rails::Generators::Base
      source_root File.expand_path('../models/templates', __FILE__)

      def copy_model
        copy_file('model.rb', 'app/models/invitation.rb')
      end

      def inject_associations
        inject_into_file('app/models/user.rb', after: 'ActiveRecord::Base') do
          File.read(
            File.join(
              File.expand_path('../models/templates', __FILE__),
              'associations.rb'
            )
          )
        end
      end
    end

    class MailersGenerator < Rails::Generators::Base
      source_root File.expand_path('../mailers/templates', __FILE__)

      def copy_mailer
        copy_file('mailer.rb', 'app/mailers/invitation_mailer.rb')
      end

      def copy_view
        copy_file('view.html.erb', 'app/views/invitation_mailer/instructions.html.erb')
      end
    end

    class ControllersGenerator < Rails::Generators::Base
      source_root File.expand_path('../controllers/templates', __FILE__)

      def copy_controller
        copy_file('controller.rb', 'app/controllers/invitations_controller.rb')
      end
    end

    class RoutesGenerator < Rails::Generators::Base
      source_root File.expand_path('../routes/templates', __FILE__)

      def inject_routes
        inject_into_file('config/routes.rb', after: 'devise_for :users') do
          File.read(
            File.join(
              File.expand_path('../routes/templates', __FILE__),
              'routes.rb'
            )
          )
        end
      end
    end
  end
end
