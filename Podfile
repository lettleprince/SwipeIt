platform :ios, '9.0'
use_frameworks!

abstract_target 'SwipeItCommon' do

  pod 'ObjectMapper', :git => 'https://github.com/ivanbruel/ObjectMapper', :branch => 'compile_time'
  pod 'RxSwift'
  pod 'Moya/RxSwift'
  pod 'Moya-ObjectMapper/RxSwift'
  pod 'NSObject+Rx'
  pod 'RxOptional'
  pod 'Result'
  pod 'Kanna'

  target 'SwipeIt' do

    pod 'RxCocoa'
    pod 'Kingfisher'
    pod 'SnapKit'
    pod 'Device'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'KeychainSwift', '~> 3.0'
    pod 'RxDataSources'
    pod 'DateTools'
    pod 'RxAlamofire'
    pod 'Cell+Rx'
    pod 'AsyncSwift'
    pod 'SwiftGen'
    pod 'MarkdownKit'
    pod 'TTTAttributedLabel', :git => 'https://github.com/ivanbruel/TTTAttributedLabel'
    pod 'RxTimer'
    pod 'RxResult'
    pod 'RxColor'
    pod 'ZLSwipeableViewSwift', :git => 'https://github.com/zhxnlai/ZLSwipeableViewSwift'
    pod 'Localizable'

  end

  target 'SwipeItTests' do

    pod 'Quick'
    pod 'Nimble'

  end

end

# Adding Build Time Analyzer compatibility
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      other_swift_flags = config.build_settings['OTHER_SWIFT_FLAGS'] || ['$(inherited)']
      other_swift_flags << '-Xfrontend'
      other_swift_flags << '-debug-time-function-bodies'
      config.build_settings['OTHER_SWIFT_FLAGS'] = other_swift_flags
    end
  end
end