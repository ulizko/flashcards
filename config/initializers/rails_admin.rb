RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  config.current_user_method(&:current_user)
  config.excluded_models = ["Authentication"]

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true
  config.model 'User' do
    list do
      field :email
      field :locale
      field :cards
    end
  end
  config.model 'Card' do
    list do
      exclude_fields :created_at, :updated_at
      field :user
      field :user_email do
        formatted_value do
          bindings[:object].user.email
        end
      end
    end
  end
  config.model 'Deck' do
    exclude_fields :created_at, :updated_at
  end
  config.model 'Role' do
    list do
      field :name
      field :users
      field :email do
        formatted_value do
          bindings[:object].users.first.email
        end
      end
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
