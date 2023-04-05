import Foundation
import Diceware
import ArgumentParser


/// The wordlist to use
enum Wordlist: String, EnumerableFlag {
    case effLarge
    case effSmall
    case germanLarge
}


/// The concatenation style to use
enum Style: String, EnumerableFlag {
    case space
    case hyphen
    case dot
    case comma
    case camelCase
    case snakeCase
}


/// Whether the security argument specifies the amount of words or the security level in bits
enum SecurityFormat: String, EnumerableFlag {
    case words
    case bits
}


/// The main application
struct DicewareBin: ParsableCommand {
    @Flag(help: "The wordlist to use")
    var wordlist: Wordlist = .effLarge
    
    @Flag(help: "The concatenation style to use")
    var style: Style = .dot
    
    // swiftlint:disable:next line_length
    @Flag(help: "Whether <security> specifies the amount of words or the security level in bits (= the size of the password space in `2^security`)")
    var securityFormat: SecurityFormat = .bits
    
    @Argument(help: "The security level")
    var security = 128
    
    // swiftlint:disable:next cyclomatic_complexity
    func run() throws {
        // Get the wordlist
        let list: [String]
        switch self.wordlist {
            case .effLarge: list = Wordlists.effLargeList
            case .effSmall: list = Wordlists.effSmallListUniquePrefix
            case .germanLarge: list = Wordlists.germanLargeList
        }
        
        // Get the style
        let style: ConcatenationStyle
        switch self.style {
            case .space: style = .space
            case .hyphen: style = .hyphen
            case .dot: style = .dot
            case .comma: style = .comma
            case .camelCase: style = .camelCase
            case .snakeCase: style = .snakeCase
        }
        
        // Generate the password
        let password: String
        switch self.securityFormat {
            case .words: password = try! Diceware.random(count: self.security, list: list, style: style)
            case .bits: password = try! Diceware.random(securityBits: self.security, list: list, style: style)
        }
        
        print(password)
    }
}


DicewareBin.main()
