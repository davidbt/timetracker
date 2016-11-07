# README

Create database
sudo -u postgres -i createdb timetracker_development
Create db user
sudo -u postgres -i createuser timetracker -s
Configure your postgresql server to allow connections to the DB. Something like this:
  host    timetracker_development             timetracker             127.0.0.1/32            trust
