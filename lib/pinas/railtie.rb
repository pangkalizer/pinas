module Pinas
  class Railtie < Rails::Railtie

    rake_tasks do
      load "tasks/pinas_tasks.rake"
    end

  end
end
