source("https://rubygems.org")
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby("3.0.3")

gem("rails", "~> 7.0.3")
gem("puma", "~> 5.0")
gem('omniauth')
gem("omniauth-rails_csrf_protection")
gem('omniauth-google-oauth2')
gem('cloudtasker')
gem("amazing_print")
gem("rails_semantic_logger")
gem("google-cloud-firestore")
gem("tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby])
gem("bootsnap", require: false)
gem("rack-cors")

group(:development, :test) do
  gem("debug", platforms: %i[mri mingw x64_mingw])
end

