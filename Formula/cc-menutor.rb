class CcMenutor < Formula
  desc "Unofficial macOS menu bar monitor for Claude Code 5-hour block usage"
  homepage "https://github.com/Ahngbeom/cc-menutor"
  url "https://github.com/Ahngbeom/cc-menutor/archive/refs/tags/v1.8.tar.gz"
  sha256 "9f3263af4719c684b0981467b52932c92a3902efd6793df595afde0226b64100"
  license "Apache-2.0"

  depends_on macos: :monterey # 12+, swiftc는 CLT/Xcode가 제공

  def install
    system "swiftc", "-O", "-framework", "Cocoa", "-o", "cc-menutor", "ClaudeMonitor.swift"
    bin.install "cc-menutor"
  end

  service do
    run [opt_bin/"cc-menutor"]
    keep_alive true
    run_at_load true
    log_path var/"log/cc-menutor.log"
    error_log_path var/"log/cc-menutor.log"
  end

  def caveats
    <<~EOS
      cc-menutor is an unofficial tool and is not affiliated with Anthropic.
      Start it (and enable auto-start at login) with:
        brew services start cc-menutor
      It reads local Claude Code usage data only; nothing is sent over the network.
    EOS
  end

  test do
    assert_match "All tests passed", shell_output("#{bin}/cc-menutor --test")
  end
end
