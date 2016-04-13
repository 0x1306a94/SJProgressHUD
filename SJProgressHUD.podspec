Pod::Spec.new do |s|
  s.name         = "SJProgressHUD"
  s.version      = “0.0.1”
  s.ios.deployment_target = '9.0'
  s.summary      = “纯swift HUD提示框”
  s.homepage     = "https://github.com/king129/SJProgressHUD"
  s.license      = "MIT"
  s.author             = { "king" => "king129@vip.163.com" }
  s.social_media_url   = "http://weibo.com/CoderKing"
  s.source       = { :git => "https://github.com/king129/SJProgressHUD.git”, :tag => s.version }
  s.source_files  = "SJProgressHUD"
  s.requires_arc = true
end
