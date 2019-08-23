#
# Be sure to run `pod lib lint EZBasicKit.podspec" to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = "EZBasicKit"
    s.version          = "1.0.5"
    s.summary          = "EZBasicKit is framework from ezbuy"

    s.description      = <<-DESC
    A ezbuy iOS basic develop framework.
                       DESC

    s.homepage         = "https://github.com/ezbuy-ios/EZBasicKit"
    s.license          = { :type => "MIT", :file => "LICENSE" }
    s.author           = { "cgwangding@163.com" => "wangding@ezbuy.com" }
    s.source           = { :git => "https://github.com/ezbuy-ios/EZBasicKit.git", :tag => s.version.to_s }

    s.ios.deployment_target = "9.0"
    s.swift_version = "5.0"
    
    s.resource_bundles = {
        "EZBasicKit" => ["EZBasicKit/Assets/*.*"]
    }

    s.frameworks = "UIKit", "Foundation"

    s.source_files = 'EZBasicKit/Classes/*.swift'
    

    s.subspec "Identifiable" do |a|
        a.source_files = "EZBasicKit/Classes/Identifiable/*.swift"
    end

    s.subspec "EZI" do |a| 
        a.source_files = "EZBasicKit/Classes/EZI/*.swift"
        a.dependency "EZBasicKit/Utilities"
        
    end

    s.subspec "ObjectsController" do |a|
        a.source_files = "EZBasicKit/Classes/ObjectsController/*.swift"
    end

    s.subspec "Selection" do |a|
        a.source_files = "EZBasicKit/Classes/Selection/*.swift"
    end

    s.subspec "Animator" do |a|
        a.source_files = "EZBasicKit/Classes/Animator/*.swift"
    end

    s.subspec "Extension" do |a|
        a.subspec "UIKitExtension" do |b|
            b.source_files = "EZBasicKit/Classes/Extension/UIKit/*.swift"
            b.dependency "EZBasicKit/Extension/FoundationExtension"
            b.dependency "EZBasicKit/CustomUIKit"
        end

        a.subspec "FoundationExtension" do |b|
            b.source_files = "EZBasicKit/Classes/Extension/Foundation/*.swift"
        end
    end

    s.subspec "CustomUIKit" do |a|
        a.source_files = "EZBasicKit/Classes/CustomUIKit/*.swift"
        a.dependency "EZBasicKit/Extension/FoundationExtension"
        
    end

    s.subspec "Utilities" do |a|
        a.source_files = "EZBasicKit/Classes/Utilities/*.swift"
    end

    s.subspec "EZPresentation" do |a|
        a.source_files = "EZBasicKit/Classes/EZPresentation/*.swift"
        a.dependency "EZBasicKit/Animator"
    end

    s.subspec "EZMenu" do |a|
        a.source_files = "EZBasicKit/Classes/EZMenu/*.swift"
        a.dependency "EZBasicKit/Extension/FoundationExtension"
        
    end
end
