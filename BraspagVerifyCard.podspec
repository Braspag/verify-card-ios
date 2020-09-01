Pod::Spec.new do |spec|

  spec.name         = "BraspagVerifyCard"
  spec.version      = "0.0.3"
  spec.summary      = "Biblioteca de validação de cartões de crédito"

  spec.description  = <<-DESC
  Biblioteca Braspag de validação de cartões de crédito.
                   DESC

  spec.homepage     = "https://github.com/Braspag/verify-card-ios"

  spec.license      = "MIT"

  spec.author             = { "Jeferson F. Nazario" => "jefnazario@gmail.com" }
  spec.social_media_url   = "https://twitter.com/jefnazario"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/Braspag/verify-card-ios.git", :tag => "#{spec.version}" }
  spec.swift_version = "5.0"
  spec.ios.deployment_target = '9.0'

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "BraspagVerifyCard/BraspagVerifyCard/**/*.{h,m,swift,framework}"
  spec.dependency 'BraspagOAuth'
  spec.exclude_files = "Example/**/*.*"
end
