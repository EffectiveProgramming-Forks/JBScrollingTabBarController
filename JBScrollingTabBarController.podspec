#
# Be sure to run `pod lib lint JBScrollingTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JBScrollingTabBarController'
  s.version          = '0.1.0'
  s.summary          = 'JBScrollingTabBarController is a Swift framework that allows the user to customize a scrollable UITabBarController.'
  s.description      = 'JBScrollingTabBarController is a Swift framework that allows the user to customize a scrollable UITabBarController that allows the user to display more than 5 tabs without showing the More navigation interface.'
  s.homepage         = 'https://github.com/jkbreunig/JBScrollingTabBarController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jeff Breunig' => 'jkbreunig@gmail.com' }
  s.source           = { :git => 'https://github.com/jkbreunig/JBScrollingTabBarController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.source_files = 'JBScrollingTabBarController/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JBScrollingTabBarController' => ['JBScrollingTabBarController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
