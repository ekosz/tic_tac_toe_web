require 'rake'
include Rake::DSL
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = '**/*_test.rb'
end

task :default => :test
