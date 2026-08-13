class Iconforge < Formula
  desc "Forge, inspect, apply, restore, and refresh macOS app icons"
  homepage "https://github.com/villagealchemist/iconforge"
  url "https://github.com/villagealchemist/iconforge/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "75925c3cf4145c8128c2d6fbb3f2eedc50c2f90d1e3298fcd1a0a635672b8ff0"
  license "MIT"

  depends_on "go" => :build
  depends_on :macos

  def install
    cd "iconforge-processor" do
      system "go", "build", "-ldflags", "-s -w -X main.version=#{version}", "-o", "iconforge-processor"
    end
    system "xcrun", "clang", "-fobjc-arc", "-Wall", "-Wextra",
           "-framework", "AppKit", "-framework", "Foundation",
           "iconforge-native-icon/main.m", "-o", "iconforge-native-icon/iconforge-native-icon"

    libexec.install "VERSION"
    libexec.install "iconforge.sh" => "iconforge"
    libexec.install "iconforge-processor/iconforge-processor" => "iconforge-processor"
    (libexec/"iconforge-native-icon").install "iconforge-native-icon/iconforge-native-icon"
    libexec.install "lib"

    (bin/"iconforge").write_env_script libexec/"iconforge", ICONFORGE_ROOT: libexec
  end

  test do
    assert_match "iconforge v#{version}", shell_output("#{bin}/iconforge --version")
    assert_match "iconforge-processor v#{version}", shell_output("#{libexec}/iconforge-processor version")
    assert_match "usage:", shell_output("#{libexec}/iconforge-native-icon/iconforge-native-icon 2>&1", 64)
  end
end
