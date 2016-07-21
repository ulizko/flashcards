# Deploy with Ansible on a new server:
#   $ (cd config/provision && ansible-playbook -i178.62.254.62, playbook.yml)
#   $ bundle exec cap production deploy
#   $ bundle exec cap production rake task=db:seed

# lock '3.3.3'

set :application, 'flashcards'
set :repo_url, 'https://github.com/ulizko/flashcards.git'
set :branch, 'master'
set :deploy_to, '/home/deploy/applications/flashcards'

set :log_level, :info
set :linked_files, %w{config/database.yml config/settings.yml .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :rbenv_type, :user
set :rbenv_ruby, '2.2.2'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all

set :puma_init_active_record, true

desc 'Run rake tasks on server'
task :rake do
  on roles(:app), in: :sequence, wait: 5 do
    within release_path do
      with rails_env: :production do
        execute :rake, ENV['task'], 'RAILS_ENV=production'
      end
    end
  end
end
