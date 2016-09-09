Pod::Spec.new do |s|
  s.name             = "LionheartExtensions"
  s.version          =  "2.0.0"
  s.summary          = "Swift Extensions you probably will find useful."

  s.homepage         = "https://github.com/lionheart/LionheartExtensions"
  s.license          = 'Apache 2.0'
  s.author           = { "Dan Loewenherz" => "dloewenherz@gmail.com" }
  s.source           = { :git => "https://github.com/lionheart/LionheartExtensions.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dwlz'

  s.platform     = :ios, '8.4'
  s.requires_arc = true

  s.default_subspec = 'Core'

  s.subspec 'Core' do |spec|
    spec.source_files = ['Pod/Classes/Core/*', 'Pod/Classes/*.swift']
  end
end
