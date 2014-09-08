Pod::Spec.new do |s|

    s.name              = 'TGFoursquareLocationDetail'
    s.version           = '1.0.1'
    s.summary           = 'iOS project recreating Foursquare design and behaviour when presenting location details'
    s.homepage          = 'https://github.com/Tibolte/TGFoursquareLocationDetail-Demo'
    s.license           = {
        :type => 'MIT',
        :file => 'LICENSE'
    }
    s.author            = {
        'Thibault Guégan' => 'thibault.guegan@gmail.com'
    }
    s.source            = {
        :git => 'https://github.com/Tibolte/TGFoursquareLocationDetail-Demo.git',
        :tag => s.version.to_s
    }
    s.platform          = :ios, '7.0'
    s.frameworks        = ['UIKit']
    s.source_files      = 'Classes/*.{h,m}'
    s.requires_arc      = true

end