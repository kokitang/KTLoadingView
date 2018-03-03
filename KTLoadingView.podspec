#
# Be sure to run `pod lib lint KTLoadingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KTLoadingView'
  s.version          = '0.1.0'
  s.summary          = 'KTLoadingView is a subclass of UIView that provides animated loading page.'
  s.description      = <<-DESC
KTLoadingView is a nice and easy-to-use library for iOS. It is highly customizable and userfriendly. Works perfectly on anywhere in your app by just one line of code to provide awesome loading view.
                       DESC
  s.homepage         = 'https://github.com/kokitang/KTLoadingView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kokitang' => 'kokitangwaichun@gmail.com' }
  s.source           = { :git => 'https://github.com/kokitang/KTLoadingView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'KTLoadingView/Classes/**/*'
  s.swift_version = '4.0'
  s.frameworks = 'UIKit'
  s.dependency 'KTLoadingLabel'

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.resource_bundles = {
  #   'KTLoadingView' => ['KTLoadingView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
end
