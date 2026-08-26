# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.13.0"
  sha256 "50f08e59219d5bcdbed88a76c284d7d90bb0a8995b3a85ee6d5de79913ca3716"

  url "https://github.com/styrene-lab/flynt/releases/download/v#{version}/Flynt-#{version}-macos.dmg"
  name "Flynt"
  desc "Local-first knowledge workspace"
  homepage "https://github.com/styrene-lab/flynt"

  depends_on macos: ">= :monterey"

  app "Flynt.app"

  zap trash: [
    "~/Library/Application Support/io.styrene.codex",
    "~/Library/Caches/io.styrene.codex",
    "~/Library/Preferences/io.styrene.codex.plist",
  ]
end
