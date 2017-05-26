version = "2.0";

Pod::Spec.new do |s|
        s.name         = "YJBannerView"
        s.version      = version
        s.summary      = "YJBannerView 是一款超级好用的 BannerView 控件, Author's email:houmanager@Hotmail.com 工作地点:BeiJing 欢迎骚扰。"
        s.description      = <<-DESC
                                YJBannerView 是一款超级好用的 BannerView 控件, Author's email:houmanager@Hotmail.com 工作地点:BeiJing 欢迎骚扰. 欢迎一起交流.
                                DESC
        s.homepage     = "https://github.com/YJManager/YJBannerViewOC"

        s.license      = { :type => "MIT", :file => "LICENSE" }

        s.author       = { "houmanager" => "houmanager@Hotmail.com" }
        s.platform     = :ios, "7.0"
        s.ios.deployment_target = "7.0"
        s.requires_arc = true
        s.frameworks = 'Foundation', 'UIKit'
        s.source       = { :git => "https://github.com/YJManager/YJBannerViewOC.git", :tag => "#{version}", :submodules => true }
        # s.public_header_files = 'YJCategories/*.{h}'
        s.source_files        = 'YJBannerView/*.{h,m}'

        # PageControls 配置模块
        s.subspec 'PageControls' do |ss|
            # 1. YJHollowPageControl 配置模块
            ss.subspec 'YJHollowPageControl' do |sss|
            sss.source_files        = 'YJBannerView/PageControls/YJHollowPageControl/*.{h,m}'
            # sss.public_header_files = 'YJCategories/UIKit/UIApplication/*.{h}'
            end

        end

        # Tools 配置模块
        s.subspec 'Tools' do |ss|
            ss.source_files        = 'YJBannerView/Tools/*.{h,m}'
            # ss.public_header_files = 'YJCategories/Foundation/NSString/*.{h}'
        end

        # Views 配置模块
        s.subspec 'Views' do |ss|
            ss.source_files        = 'YJBannerView/Views/*.{h,m}'
            # ss.public_header_files = 'YJCategories/Foundation/NSString/*.{h}'
        end

        #s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
end
