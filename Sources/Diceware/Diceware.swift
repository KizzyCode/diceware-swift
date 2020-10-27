import Foundation


/// A concatenation style
public enum ConcatenationStyle {
    /// Concatenate the words using spaces (`alpha beta gamma`)
    case space
    /// Concatenate the words using hyphens (`alpha-beta-gamma`)
    case hyphen
    /// Concatenate the words using dots (`alpha.beta.gamma`)
    case dot
    /// Concatenate the words using commas (`alpha,beta,gamma`)
    case comma
    /// Concatenate the words using camel-case notation (`AlphaBetaGamma`)
    case camelCase
    /// Concatenate the words using snake-case notation (`alpha_beta_gamma`)
    case snakeCase
    
    /// Concatenate a string using the given style
    ///
    ///  - Parameter array: The words to concatenate
    internal func apply(_ array: [String]) -> String {
        switch self {
            case .space:
                return array.joined(separator: " ")
            case .hyphen:
                return array.joined(separator: "-")
            case .dot:
                return array.joined(separator: ".")
            case .comma:
                return array.joined(separator: ",")
            case .camelCase:
                return array.map({ $0.prefix(1).capitalized + $0.dropFirst() }).joined()
            case .snakeCase:
                return array.joined(separator: "_")
        }
    }
}


/// The diceware implementation
public struct Diceware {
    /// Generates a random diceware string with
    ///
    ///  - Parameters:
    ///     - count: The amount of words to generate
    ///     - list: The wordlist to pick from
    ///     - style: The concatenation style to use
    ///  - Returns: The randomly generated password
    ///
    ///  - Discussion: This function uses `arc4random` which is considered safe because all modern OS' have replaced the
    ///    underlying permutation with a secure alternative (e.g. AES or ChaCha20). If your OS still uses ARC4, you
    ///    should probably upgrade or stop using this OS.
    public static func random(count: Int, list: [String] = Wordlists.effShortListUniquePrefix,
                              style: ConcatenationStyle = .dot) -> String {
        // Select random words
        var rng = SystemRandomNumberGenerator()
        let words = (0 ..< count).map({ _ -> String in
            let choice = Int.random(in: 0 ..< list.count, using: &rng)
            return list[choice]
        })
        
        // Concatenate words
        return style.apply(words)
    }
    
    /// Generates a random diceware string with the amount of words needed to provide at least
    /// `2 ^ securityBits` possibilities
    ///
    ///  - Parameters:
	///     - securityBits: The minimum amount of possible passwords as `2 ^ securityBits` (i.e. the size of the
    ///       password space)
    ///     - list: The wordlist to pick from
    ///     - style: The concatenation style to use
    ///  - Returns: The randomly generated password
    ///
    ///  - Discussion: This function uses `arc4random` which is considered safe because all modern OS' have replaced the
    ///    underlying permutation with a secure alternative (e.g. AES or ChaCha20). If your OS still uses ARC4, you
    ///    should probably upgrade or stop using this OS.
    public static func random(securityBits: Int, list: [String] = Wordlists.effShortListUniquePrefix,
                              style: ConcatenationStyle = .dot) -> String {
        // Compute the security-bits to word count equivalent
        let wordCount = Self.bitsToWords(securityBits: securityBits, list: list)
        return Self.random(count: wordCount, list: list, style: style)
    }
    
    /// Computes the amount of words needed to provide at least `2 ^ securityBits` possible passwords
    ///
    ///  - Parameters:
    ///     - securityBits: The minimum amount of possible passwords as `2 ^ securityBits` (i.e. the size of the
    ///       password space)
    ///     - list: The wordlist to pick from
    ///  - Returns: The amount of words needed to provide at least `2 ^ securityBits` possible passwords
    internal static func bitsToWords(securityBits: Int, list: [String]) -> Int {
        // Solve `listSize ^ x = 2 ^ securityBits`
        let words = (Double(securityBits) * log(2.0)) / log(Double(list.count))
        return Int(ceil(words))
    }
}
