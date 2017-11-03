# Bricking

Bricking is Inspired by [Stevia](https://github.com/freshOS/Stevia). The function is similar to Stevia. But supports the following features.

- Supports MacOS
- Supports [dynamical or conditional layout(issues#53)](https://github.com/freshOS/Stevia/issues/53)
- Supports topLayoutGuide and bottomLayoutGuide
- Supports center based layout
- Supports view shrink(hide view and compress the space occupied by the view)
- The architecture and code are more clear



## Installation

### Carthage

```swift
github "cp3hnu/Bricking"
```

- Drag and drop *Bricking.framework* from /Carthage/Build/iOS/ to *Linked Frameworks and Libraries* in Xcode (Project>Target>General>Linked Frameworks and Libraries)
- Add new run script

```ruby
  /usr/local/bin/carthage copy-frameworks
```

- Add Input files *$(SRCROOT)/Carthage/Build/iOS/Bricking.framework*



## Usage

 Similar to Stevia



## Requirements

- Swift 3.0+

- Xcode 8.0+

- iOS 9+




## License

Released under the MIT license. See LICENSE for details.