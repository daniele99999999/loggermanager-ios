Pod::Spec.new do |s|
  s.name             = "LoggerManager"
  s.version          = "1.0.4"
  s.summary          = "LoggerManager library DeeplyMadStudio"
  s.homepage         = "https://github.com/daniele99999999/loggermanager-ios"
  s.license          = { :type => 'MIT' }
  s.author           = { "DeeplyMadStudio" => "deeplymadstudio@gmail.com" }
  s.source           = { :git => "https://github.com/daniele99999999/loggermanager-ios", :tag => s.version }

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.frameworks   = 'Foundation'

  s.dependency 'CocoaLumberjack/Swift', '3.5.1'

  s.source_files = 'Classes/**/*'
end