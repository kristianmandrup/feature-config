guard :rspec, cmd: "rspec" do
  watch(%r{^spec/.+_spec\.rb$})
  watch('lib/feature-config/engine.rb')               { 'spec' }
  watch(%r{^spec/dummy/config/features/(.+)\.yml$})   { 'spec' }
  watch(%r{^lib/feature-config/(.+)\.rb$})            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                        { 'spec' }
end
