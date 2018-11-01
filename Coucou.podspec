Pod::Spec.new do |spec|
  spec.name         = "Coucou"
  spec.version      = "0.0.6"
  spec.summary      = "A highly modular network service discovery and broadcast library."
  spec.description  = <<-DESC
A highly modular network service discovery and broadcast library. Note: Still under development.
                   DESC

  spec.homepage     = "https://github.com/mrmitew/coucou_ios"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Stefan Mitev" => "mr.mitew@gmail.com" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/mrmitew/coucou_ios.git", :tag => "#{spec.version}" }
  spec.source_files  = "Coucou/*.swift", "Coucou/driver/*", "Coucou/driver/impl/*", "Coucou/engine/*", "Coucou/engine/impl/*", "Coucou/internal/*", "Coucou/logger/*", "Coucou/logger/impl/*", "Coucou/models/*"
  spec.swift_version = "4.2"
end
