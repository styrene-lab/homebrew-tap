# typed: false
# frozen_string_literal: true

cask "flynt" do
  version "0.10.7"
  sha256 "e51868e5e2fc74a41dcba536cd4eaefe16a8cbddf43769be2ba0c602d6ec51bd"

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
