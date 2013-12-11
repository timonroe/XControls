
Pod::Spec.new do |s|
  s.name          = “XControls”
  s.version       = “0.1.0”
  s.author        = { “Tim Monroe” => “timonroe12@gmail.com” }
  s.license       = ‘MIT’
  s.homepage      = "https://github.com/timonroe/XControls”
  s.source        = { :git => "https://github.com/timonroe/xcontrols.git", :tag => “0.1.0” }
  s.summary       = "Controls for rapid iOS UI development.”
  s.description   = <<-DESC
                    DESC
  s.platform      = :ios, ‘7.0’
  s.ios.deployment_target = ‘7.0’
  s.requires_arc  = true
  s.frameworks    = ‘CoreGraphics’, ‘UIKit’, ‘Foundation’
  s.source_files  = ‘XControls’, ‘XCVCells’, ‘XTVCells’
  subspec “XControls” do |ss|
    ss.source_files = “XControls”
  end
end
