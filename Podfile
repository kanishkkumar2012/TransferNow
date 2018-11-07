# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TransferNow' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TransferNow

def testing_pods
    pod 'Quick', :git => 'https://github.com/Quick/Quick.git', :branch => 'master'
    pod 'Nimble', :git => 'https://github.com/Quick/Nimble.git', :branch => 'master'
end

  target 'TransferNowTests' do
    inherit! :search_paths
    testing_pods
  end

  target 'TransferNowUITests' do
    inherit! :search_paths
    testing_pods
  end

end
