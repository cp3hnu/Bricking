<p align="center"> 
<img src="https://raw.githubusercontent.com/cp3hnu/Bricking/master/Bricking.jpg", width="301">
</p>



**Bricking** is Inspired by [Stevia](https://github.com/freshOS/Stevia). The function is similar to Stevia. But supports the following features.

- Supports iOS and macOS
- Supports [dynamical or conditional layout(issues#53)](https://github.com/freshOS/Stevia/issues/53)
- Supports **topLayoutGuide(iOS 9)** , **bottomLayoutGuide(iOS 9)**  and **safeAreaLayoutGuide(iOS 11)** 
- Support setting priority
- Supports center-based layout
- Supports view shrink(hide view and compress the space occupied by the view)
- Supports NSLayoutAnchor equation (iOS 9+)
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


### Swift Package

File -> Swift Packages -> Add Package Dependency,  then search bricking.

## Usage

#### Example

```swift
asv(
    portraitImgView,
    idLabel,
    dateLabel
)
        
layout(
    15,
    |-15-portraitImgView.size(30)-idLabel-15-|,
    10,
    |-15-dateLabel-15-|,
    15
)
```

#### Layout dynamically

```swift
let views = [Any]()
if isTrue {
    views += [view1, view2]
} else {
    views += [view3, view4]
}
asv(views)
layoutDynamically(views)
```

#### topLayoutGuide, bottomLayoutGuide

```swift
view.layout(
    topLayoutGuide.bottomAnchor,
    10,
    |subview1| ~ 50,
    10,
    |subview2|,
    bottomLayoutGuide.topmAnchor
)
```

#### safeAreaLayoutGuide

```swift
view.layout(
    view.safeAreaLayoutGuide.topAnchor,
    10,
    |subview1| ~ 50,
    10,
    |subview2|,
    view.safeAreaLayoutGuide.bottomAnchor
)
```

#### Center-based layout

```swift
label1-(>=4)-Bricking.centerX-(>=4)-label2

layout(
    |-15-label1-15-|,
    10,
    Bricking.centerY,
    10,
    |-15-label2-15-|
)
```

#### Shrink

```swift
layout(
    64,
    |nameView|,
    |cityView|,
    20,
    |-15-button-15-| ~ 40
)
cityView.shrinkVertically = true

is equal to
cityView.isHidden = true
layout(
    64,
    |nameView|,
    20,
    |-15-button-15-| ~ 40
)
```

#### Equation

```swift
label.laTop == 100
label2.laLeft == label1.laLeft + 20
label1.laWidth <= 50 % label2.laWidth
```

#### Priority

```swift
label.laBottom == 15 !! UILayoutPriorityRequired - 1
```

#### Percentage

```swift
label.width(40%)
```

#### Fill, Center and Align

```swift
tableView.fillContainer()
button.centerInContainer()
alignLefts(label1, label2)
```

#### Array Chainning

```swift
[label1, label2].alignLefts().alignTops()
```

#### More other

...

## Requirements

- Swift 5.0+
- Xcode 10.0+
- iOS 9+
- macOS 10.12+



## License

Released under the MIT license. See LICENSE for details.