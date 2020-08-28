[![License BSD-2-Clause](https://img.shields.io/badge/License-BSD--2--Clause-blue.svg)](https://opensource.org/licenses/BSD-2-Clause)
[![License MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Travis CI](https://travis-ci.org/KizzyCode/diceware-swift.svg?branch=master)](https://travis-ci.org/KizzyCode/diceware-swift)

# Diceware

An implementation of the popular [diceware method](https://en.wikipedia.org/wiki/Diceware)


## Example

### Package
```swift
/// Generate a random password with at least 2^256 possibilities
let password = Diceware.random(securityBits: 256)
print("Password:", password)
```

### Binary
```sh
$ diceware
kebab.denture.deploy.devourer.unsaved.hungry.willing.unsmooth.contrite.resort
```
