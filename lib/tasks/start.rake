desc "Starts a development server running at localhost:5000"
task :start do
  exec "bundle install && rails s -p 5000"
end