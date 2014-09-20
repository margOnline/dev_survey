Dev Survey (tbc)
=============

Survey application

Standard setup
--------------

1.  In Terminal, go to your projects directory and clone the project:

        cd ~/Documents/Projects/
        git clone git@github.com:margonline/dev_survey.git

2.  Install gem dependencies:

        bundle install

3.  Save a copy of `config/database.yml.example` as `config/database.yml`.
    In the `development` and `test` sections, update the username, password
    (optional), and database values. Do the same for any other `*.yml.example`
    files in `config/`.

4.  Create and set up the databases:

        rake db:create:all
        rake db:migrate
        rake db:seed

5.  Run tests to make sure they pass with your environment:

        rake test
