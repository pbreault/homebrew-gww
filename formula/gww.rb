class Gww < Formula
  desc "A gradle wrapper \"wrapper\" for deeply nested projects"
  homepage "https://github.com/pbreault/gww"
  url "https://github.com/pbreault/gww/releases/download/0.1.0/gww-0.1.0.zip"
  sha256 "cb8e113b44d18750249a86797873f0f21ce8923a0f1811811185154862b05c2c"
  head "https://github.com/pbreault/gww.git"

  def install
    bin.install "bin/gww"
    prefix.install "lib"
  end

  test do
    (testpath/"gradlew").write <<~EOS
      #!/bin/sh
      echo $@
    EOS
    chmod 0755, "gradlew"
    tool_output = shell_output("#{bin}/gww a/b/c:d//e", 0)
    assert_includes tool_output, ":a:b:c:d :a:b:c:e"
  end
end