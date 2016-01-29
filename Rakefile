task :gen_strings do
    path = "./eureception/SwiftGen/String.swift"
    FileUtils.mkdir_p(path) unless FileTest.exist?(path)
    sh "swiftgen strings --output #{path} ./eureception/en.lproj/Localizable.strings"
end

task :gen_colors do
    path = "./eureception/SwiftGen/Colors.swift"
    sh "swiftgen colors --output #{path} ./eureception/SwiftGen/colors.txt"
end
