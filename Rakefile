require 'rake'
require 'rake/testtask'

desc "Default Task"
task :default => :test

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/**/*test.rb']
  t.warning = true
  t.verbose = true
end

Rake::TestTask.new(:test_units) do |t|
  t.test_files = FileList['test/units/**/*test.rb']
  t.warning = true
  t.verbose = false
end

Rake::TestTask.new(:test_functional) do |t|
  t.test_files = FileList['test/functionals/**/*test.rb']
  t.warning = true
  t.verbose = false
end

require 'rcov/rcovtask'

Rcov::RcovTask.new(:courage) do |t|
  t.rcov_opts << '--text-report'
  t.rcov_opts << '-x/Library/Ruby'
  t.rcov_opts << '--xrefs'
  t.test_files = FileList[ 'test/**/*test.rb' ]
  t.verbose = true
end