import PackageDescription

let package = Package(
    name: "DemoVaporWithMySQL",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
        
        //Package for MySQL provider for Vapor
        .Package(url: "https://github.com/vapor/mysql-provider", majorVersion: 1, minor: 1)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
    ]
)

