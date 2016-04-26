platform :ios, '9.0'
use_frameworks!

def common_pods

  pod 'ObjectMapper'
  pod 'RxSwift'
  pod 'Moya/RxSwift'
  pod 'Moya-ObjectMapper/RxSwift'
  pod 'RxCocoa'
  pod 'NSObject+Rx'

end

target 'Reddit' do

  common_pods

  pod 'Kingfisher'
  pod 'SnapKit'
  pod 'Device'
  pod 'Fabric'
  pod 'Crashlytics'

end

target 'RedditTests' do

  common_pods

  pod 'Quick'
  pod 'Nimble'

end
