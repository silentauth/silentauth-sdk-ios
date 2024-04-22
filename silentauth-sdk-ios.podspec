Pod::Spec.new do |spec|
    spec.name         = "silentauth-sdk-ios"
    spec.version      = "1.0.10"
    spec.summary      = "SDK for SilentAuth"
    spec.description  = <<-DESC
    iOS SDK for SilentAuth: SIM Based Authentication.
    DESC
    spec.homepage     = "https://github.com/silentauth/silentauth-sdk-ios"
    spec.license      = { :type => "MIT", :file => "LICENSE.md" }
    spec.author             = { "author" => "community@4auth.io" }
    spec.documentation_url = "https://github.com/silentauth/silentauth-ios/blob/main/README.md"
    spec.platforms = { :ios => "12.0" }
    spec.swift_version = "5.3"
    spec.source       = { :git => "https://github.com/silentauth/silentauth-sdk-ios.git", :tag => "#{spec.version}" }
    spec.source_files  = "Sources/SilentAuthSDK/**/*.swift"
    spec.resource_bundles ={ "silentauth-sdk-ios" => ["Sources/PrivacyInfo.xcprivacy"]}
    spec.xcconfig = { "SWIFT_VERSION" => "5.3" }
end
