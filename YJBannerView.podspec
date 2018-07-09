version = "2.4.0";

Pod::Spec.new do |s|

    s.name         = "YJBannerView"
    s.version      = version
    s.summary      = "YJBannerView 多功能轮播控件, Author's email:houmanager@Hotmail.com"
    s.description      = <<-DESC
                        YJBannerView 多功能轮播控件, Author's email:houmanager@Hotmail.com. Form Beijing
                            DESC
    s.homepage     = "https://github.com/stackhou/YJBannerView"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "houmanager" => "houmanager@Hotmail.com" }
    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://github.com/stackhou/YJBannerView.git", :tag => "#{version}"}
    s.source_files  = "YJBannerViewDemo/YJBannerView/**/*.{h,m}"
    s.resource     = 'YJBannerViewDemo/YJBannerView/Resource/YJBannerView.bundle'
    s.requires_arc = true

end
