require 'redmine'
require 'readme_listener'

Redmine::Plugin.register :redmine_readme do
  name 'Redmine Readme plugin'
  author 'suer'
  description 'display readme in project top pages'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://d.hatena.ne.jp/suer/'
end
