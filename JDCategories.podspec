Pod::Spec.new do |s|
  s.name         = "JDCategories"
  s.version      = "0.1.1"
  s.summary      = "JDCategories"
  s.description  = <<-DESC
    JDCategories
                   DESC
  s.homepage     = "https://github.com/johannesd/JDCategories.git"
  s.license      = { 
    :type => 'Custom permissive license',
    :text => <<-LICENSE
          Free for commercial use and redistribution. No warranty.

        	Johannes Dörr
        	mail@johannesdoerr.de
    LICENSE
  }
  s.author       = { "Johannes Doerr" => "mail@johannesdoerr.de" }
  s.source       = { :git => "https://github.com/johannesd/JDCategories.git" }
  s.platform     = :ios, '8.0'
  s.source_files  = '*.{h,m}'

  s.exclude_files = 'Classes/Exclude'
  s.requires_arc = true

  s.dependency 'EDColor'

end
