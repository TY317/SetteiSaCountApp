# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'

target 'SetteiSaCountApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SetteiSaCountApp
  pod 'Google-Mobile-Ads-SDK'
  pod 'GoogleMobileAdsMediationInMobi'    # 260204_add
  pod 'Firebase/Analytics'     # 250518_add
  pod 'Firebase/Crashlytics'   # 250621_add

  target 'SetteiSaCountAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SetteiSaCountAppUITests' do
    # Pods for testing
  end

end

# 以下の「おまじない」を追加
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        # Xcode 16.2 のエラーを回避するための設定
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
      end
    end
    # プロジェクト自体のオブジェクトバージョンを強制的に下げる
    project.instance_variable_set(:@object_version, '63')
    project.save
  end
end
