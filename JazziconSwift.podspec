#
# Be sure to run `pod lib lint JazziconSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JazziconSwift'
  s.version          = '0.1.2'
  s.summary          = 'Jazzy Identicons written in pure swift.'

  s.description      = <<-DESC
  Say goodbye to boring blocky identicons that look like they came out of the 70s, and replace them with jazzy, colorful collages that more likely came out of the 80's.
                       DESC

  s.homepage         = 'https://github.com/bigearsenal/JazziconSwift'
  s.screenshots     = 'https://raw.githubusercontent.com/MetaMask/jazzicon/HEAD/example.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bigearsenal' => 'bigearsenal@gmail.com' }
  s.source           = { :git => 'https://github.com/bigearsenal/JazziconSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bigearsenal'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'

  s.source_files = 'JazziconSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JazziconSwift' => ['JazziconSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
