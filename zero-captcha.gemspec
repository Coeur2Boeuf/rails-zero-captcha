# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = %q{zero-captcha}
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['lunaru']
  s.date = %q{2014-10-25}
  s.description = %q{A simple way to add zero friction captchas to Rails forms}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "VERSION",
     "zero-captcha.gemspec",
     "lib/zero-captcha.rb",
     "lib/zero-captcha/form_tag_helper.rb"
  ]
  s.homepage = %q{http://github.com/lunaru/rails-zero-captcha}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A simple way to add zero friction captchas to Rails forms}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

