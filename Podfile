# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'random-dogs' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for random-dogs

  # pod 'RealmSwift', '~>10'
  pod 'Alamofire'
  pod 'Tabman', '~> 3.0'
  pod 'Toast-Swift', '~> 5.0.0'
  
  target 'random-dogsTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'random-dogsUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
