class Iconforge < Formula
  desc "Convert any image into a macOS .icns icon bundle from the terminal"
  homepage "https://github.com/villagealchemist/iconforge"
  url "https://github.com/villagealchemist/iconforge/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "c3017ff6bb2d786b30b69f5b6a0a4d0e9d04af6ffc561f143546b5ded3ac5f18"
  license "MIT"
  version "1.0.0"

  depends_on :macos

  def install
    # Install directly from the nested directory without cd
    bin.install "iconforge-#{version}/bin/iconforge.sh" => "iconforge"
  end

  test do
    output = shell_output("#{bin}/iconforge --version")
    assert_match "iconforge v#{version}", output
  end
end
