Pod::Spec.new do |s|
  s.name         = "QiscusStreaming"
  s.version      = "0.1.4"
  s.summary      = "Qiscus Video Streaming."

    s.description  = <<-DESC
    Qiscus SDK for iOS Video Streaming.
    DESC

  s.homepage     = "https://qisc.us"
  s.license      = "MIT"
  s.author       = { "ashari juang" => "asharijuang@me.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/qiscus/qiscus-streaming-sdk-ios.git", :tag => "#{s.version}" }

  s.source_files  = "QiscusLive", "QiscusLive/**/*.{h,m,swift,xib}"
  s.resources = "QiscusLive/**/*.xcassets"
  s.resource_bundles = {
   'QiscusLive' => ['QiscusLive/**/*.{lproj,xib,xcassets,imageset,png,mp3}']
  }

  s.frameworks = "VideoToolbox", "AudioToolbox","AVFoundation","Foundation","UIKit"
  s.libraries = "c++", "z"

  s.requires_arc = true
  s.dependency 'LFLiveKit', '2.6'
  s.dependency 'Alamofire', '4.5.1'
  s.dependency 'SwiftyJSON', '3.1.4'
end
