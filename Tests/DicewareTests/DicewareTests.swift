import XCTest
@testable import Diceware

final class DicewareTests: XCTestCase {
    func testWordlists() {
        // Define test vectors
        let testVectors = [
            (Wordlists.effLargeList, 7776),
            (Wordlists.effShortListUniquePrefix, 1296)
        ]
        
        // Test test vectors
        for (list, expected) in testVectors {
            XCTAssertEqual(list.count, expected)
        }
    }
    
    func testBitsToWords() {
        // Define test vectors
        let testVectors = [
            ((256, 7776), 20),
            ((192, 7776), 15),
            ((80, 7776), 7),
            
            ((256, 1296), 25),
            ((192, 1296), 19),
            ((80, 1296), 8)
        ]
        
        // Test test vectors
        for ((bits, size), expected) in testVectors {
            let list = [String](repeating: "", count: size)
            let words = Diceware.bitsToWords(securityBits: bits, list: list)
            XCTAssertEqual(words, expected)
        }
    }
    
    func testExample() {
        /// Generate a random password with at least 2^256 possibilities
        let password = Diceware.random(securityBits: 256)
        print("Password:", password)
    }

    static var allTests = [
        ("testWordlists", testWordlists),
        ("testBitsToWords", testBitsToWords),
        ("testExample", testExample)
    ]
}
