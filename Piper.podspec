Pod::Spec.new do |s|
  s.name         = "Piper"
  s.version      = "1.0.0"
  s.summary      = "Sequential Queue-Oriented Operations"
  s.description  = <<-DESC
                    Piper allows you to simplify your multi-threaded code for sequential operations.
                   DESC
  s.homepage     = "https://github.com/bradhilton/Piper"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad@skyvive.com" }
  s.source       = { :git => "https://github.com/bradhilton/Piper.git", :tag => "1.0.0" }

  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"

  s.source_files  = "Sources", "Sources/**/*.{swift,h,m}"
  s.requires_arc = true

end
