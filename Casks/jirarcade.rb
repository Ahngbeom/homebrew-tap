cask "jirarcade" do
  version "0.1.0"
  sha256 "39ee745ab63098c160837f9273645a5b8e4e3a3066c500536ac4285419acb48e"

  url "https://github.com/Ahngbeom/jirarcade/releases/download/v#{version}/Jirarcade-#{version}.zip",
      verified: "github.com/Ahngbeom/jirarcade/"

  name "Jirarcade"
  desc "macOS app that shows Jira tickets as an arcade game"
  homepage "https://github.com/Ahngbeom/jirarcade"

  # Info.plist의 LSMinimumSystemVersion 15.0과 같은 값이어야 한다. 어긋나면
  # cask는 설치를 허용하는데 앱이 켜지지 않는다.
  depends_on macos: ">= :sequoia"

  livecheck do
    skip "Auto-generated on release."
  end

  app "Jirarcade.app"

  # 이 앱은 공증을 받지 않았다. Homebrew는 내려받은 자산에 격리 표시를 붙이고,
  # 6.x에서 --no-quarantine 플래그가 제거돼 사용자가 뺄 방법이 없다. 여기서 뺀다.
  #
  # staged_path가 아니라 appdir인 이유: app stanza는 번들을 /Applications로 옮긴
  # 뒤에 postflight를 돌린다. staged_path는 그 시점에 비어 있어 아무 효과 없이 성공한다.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Jirarcade.app"]
  end

  zap trash: [
    "~/Library/Application Support/Jirarcade",
    "~/Library/Preferences/dev.jirarcade.app.plist",
  ]

  caveats "Jira 자격증명은 Keychain의 'Jirarcade' 항목에 남습니다 — zap이 지우지 못합니다."
end
