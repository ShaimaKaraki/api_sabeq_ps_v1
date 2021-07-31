module ApiSabeqPsV1
  class Railtie < Rails::Railtie
    initializer "controllers_include" do
      ActiveSupport.on_load(:action_controller) do
        include ApiSabeqPsV1::SabeqHelpers
      end
    end
  end
end
