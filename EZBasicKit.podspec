#
# Be sure to run `pod lib lint EZBasicKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'EZBasicKit'
    s.version          = '0.1.0'
    s.summary          = 'A short description of EZBasicKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com/cgwangding@163.com/EZBasicKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'cgwangding@163.com' => 'wangding@ezbuy.com' }
    s.source           = { :git => 'https://github.com/cgwangding@163.com/EZBasicKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

  # s.source_files = 'EZBasicKit/Classes/**/*'

  # s.resource_bundles = {
  #   'EZBasicKit' => ['EZBasicKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

    s.subspec 'Identifiable' do |a|
        a.source_files = 'EZBasicKit/Classes/Identifiable/*.swift'
    end

#   s.subspec 'EZI' do |a| 
#     a.source_files = 'EZBasicKit/Classes/EZI/*.swift'
#   end

    s.subspec 'ObjectsController' do |a|
        a.source_files = 'EZBasicKit/Classes/ObjectsController/*.swift'
    end

    s.subspec 'Selection' do |a|
        a.source_files = 'EZBasicKit/Classes/Selection/*.swift'
    end

    s.subspec 'Animator' do |a|
        a.source_files = 'EZBasicKit/Classes/Animator/*.swift'
    end
end
