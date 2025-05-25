#
#  OpenAI.podspec
#  Compatible with CocoaPods 1.12+
#

Pod::Spec.new do |s|
  # --- 基本信息 --------------------------------------------------------------
  s.name         = 'OpenAI'                       # 与 SwiftPM 产品同名
  s.version      = '2.3.0'                        # ← 换成最新 tag
  s.summary      = 'Swift SDK for the OpenAI REST API (Chat, Assistants, Images, Audio, Files, Moderations).'
  s.description  = <<-DESC
A type-safe, async/await–friendly Swift wrapper around the OpenAI REST endpoints.
Supports streaming Chat Completion, Assistants (run & threads), Vision,
Images, Audio (TTS / STT), Files, Moderations, Fine-tuning, and more.
  DESC

  s.homepage     = 'https://github.com/MacPaw/OpenAI'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'MacPaw' => 'https://github.com/MacPaw' }

  # --- 源代码 ----------------------------------------------------------------
  s.source       = { :git => 'https://github.com/MacPaw/OpenAI.git',
                     :tag => s.version }

  # SwiftMonorepo：所有 .swift 都在 Sources/OpenAI/…
  s.source_files = 'Sources/OpenAI/**/*.{swift}'
  s.swift_version            = '5.9'        # Swift 5.9/5.10 兼容
  s.module_name              = 'OpenAI'

  # --- 平台最低支持 -----------------------------------------------------------
  s.ios.deployment_target     = '15.0'
  s.macos.deployment_target   = '12.0'
  s.tvos.deployment_target    = '15.0'

  # --- 依赖与编译设置 ---------------------------------------------------------
  # 库本身只依赖 Foundation & URLSession；无需其它 Pods
  s.frameworks = 'Foundation'

  # （可选）如果你需要 Combine 扩展：
  # s.user_target_xcconfig = { 'SWIFT_ACTIVE_COMPILATION_CONDITIONS' => '$(inherited) OPENAI_COMBINE_EXTENSIONS' }
end