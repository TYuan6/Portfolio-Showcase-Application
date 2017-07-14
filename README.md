# SELT_TEAM_3_PROJECT

 
    
    Command for database setup:
    1. rake db:reset
    2. rake db:drop
    3. rake db:create
    4. rake db:migrate
    
    Command for running Solr server for searching:
    1. rails generate sunspot_rails:install
    2. rake sunspot:solr:stop
    3. rm -rvf solr
    4. rake sunspot:solr:start
    5. rake sunspot:solr:reindex
    
    
    Command for avoid RSolr::Error::Http - 500 Internal Server Error 
    1. ps aux | grep solr  
    2. kill -9 <process nunmber> 
    
    Testing with solr server:
    To avoid testing error --- RSolr::Error::Http: RSolr::Error::Http - 500 Internal Server Error
    We need to start sunspor:solr in test envorinment
    To do so, please use the following command before running rspec:
       
        -- bundle exec rake sunspot:solr:start RAILS_ENV=test --
    
    Then wait for around 5-10!!!! seconds untill solr server fully started
    
    Command for installing ImageMagick:
    1. sudo apt-get update
    2. sudo apt-get install imagemagick
    
    Command to start the rails server:
    1. rails server -p $PORT -b $IP
    
    command setup paperclips to 3s on heroku:
    $ heroku config:set S3_BUCKET_NAME=selt-pictures
    $ heroku config:set AWS_ACCESS_KEY_ID=AKIAJ6DVCB2BHWXQ6FLA
    $ heroku config:set AWS_SECRET_ACCESS_KEY=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
    $ heroku config:set AWS_REGION=us-east-1
    
    command to add Gemfile.lock when pushing to heroku:
    $ vim .gitignore # here I remove the line ignoring Gemfile.lock
    $ git add .gitignore Gemfile.lock -f
    $ git commit -m 'Stop ignoring Gemfile.lock so we can deploy to Heroku'
    $ git ls-files |grep Gemfile # you should see Gemfile and Gemfile.lock here
    $ git push heroku master
    
    
    https://github.com/Casecommons/pg_search
    rails g pg_search:migration:associated_against
    rake db:migrate
    