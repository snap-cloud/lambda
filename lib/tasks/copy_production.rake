namespace :db do

  desc "Copy production database to local"
  task :copy_production => :environment do

    # Download latest dump
    system(
      "wget -O tmp/latest.dump `heroku pg:backups public-url -q -r heroku`"
    )

    # get user and database name
    config   = Rails.configuration.database_configuration["development"]
    database = config["database"]
    user = config["username"]

    # import
    system("pg_restore --verbose --clean --no-acl --no-owner -h localhost -d #{database} #{Rails.root}/tmp/latest.dump")
  end

end