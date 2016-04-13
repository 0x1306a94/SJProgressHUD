Pod::Spec.new do |s|
  s.name         = "SJProgressHUD"
  s.version      = "0.0.1"
  s.ios.deployment_target = '9.0'
  s.summary      = "A short description of SJProgressHUD."
  s.description  = <<-DESC 纯swift HUD提示框 使用简单
                   DESC
  s.homepage     = "https://github.com/king129/SJProgressHUD"
  s.license      = "MIT"
  s.author             = { "king129" => "king129@vip.163.com" }
  s.source       = { :git => "https://github.com/king129/SJProgressHUD.git", :tag => "#{s.version}" }
  s.source_files  = "SJProgressHUD"

end
