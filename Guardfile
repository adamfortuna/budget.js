# A sample Guardfile
# More info at https://github.com/guard/guard#readme
require 'sprockets'

env = Sprockets::Environment.new
env.append_path('assets/javascripts')
env.append_path('spec/javascripts')

guard 'sprockets2', :sprockets => env, :digest => false, :assets_path => 'www/javascripts', :gz => false, :precompile => [ /\w+\.(?!js|css).+/, /application.(css|js)$/, /specs.(css|js)$/ ] do
  watch(%r{^assets/.+$})
  watch(%r{^spec/.+$})
end

guard 'haml', :output => 'www', :input => 'assets/haml' do
  watch(/^.+(\.html\.haml)/)
end
