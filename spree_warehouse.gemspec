# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_warehouse'
  s.version     = '0.0.1'
  s.summary     = 'Warehouse management system based on Spree'
  s.description = 'Warehouse management system based on Spree'
  s.required_ruby_version = '>= 1.8.7'

  s.authors           = ['Rei Kagetsuki', 'Vassil Kalkov']
  s.email             = 'info@genshin.org'
  s.homepage          = 'http://github.com/Genshin/spree_warehouse'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.1.1'
  s.add_dependency 'spree_api', '~> 1.1.1'
  s.add_dependency 'rainbow'
  s.add_dependency 'rqrcode'
  s.add_dependency 'mini_magick'
  s.add_development_dependency 'sqlite3'
end
