# KTLoadingView

[![Version](https://img.shields.io/cocoapods/v/KTLoadingView.svg?style=flat)](http://cocoapods.org/pods/KTLoadingView)
[![License](https://img.shields.io/cocoapods/l/KTLoadingView.svg?style=flat)](http://cocoapods.org/pods/KTLoadingView)
[![Platform](https://img.shields.io/cocoapods/p/KTLoadingView.svg?style=flat)](http://cocoapods.org/pods/KTLoadingView)

<br>

![Banner](Resources/banner.png)

<br>

## Intro

`KTLoadingView` is a subclass of `UIView` which embedded [`KTLoadingLabel`](https://github.com/kokitang/KTLoadingLabel) and [`NVActivityIndicator`](https://github.com/ninjaprox/NVActivityIndicatorView) to provide a one-line loading view solution.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

#### Basic

```Swift
import KTLoadingView

KTLoadingView.show()
```

![](Resources/basic_show.gif)

#### Basic (with text)

```Swift
import KTLoadingView

KTLoadingView.show(text: "Loading", animateText: "...")
```

![](Resources/basic_show_with_text.gif)

#### Customize

If you want to do some customization. You can get the instance of `KTLoadingView`

```Swift
let shared = KTLoadingView.shared

// Customize
shared.type = .pacman
And more to discover...
//

shared.show() // or KTLoadingView.show()
```

You can also customize the  [`KTLoadingLabel`](https://github.com/kokitang/KTLoadingLabel) by simply set the attributes of it.

```Swift
let shared = KTLoadingView.shared

// Customize
shared.label.animationType = .reverse
shared.label.stringType = .fullString
shared.label.repeats = false
And more to discover...
//

shared.show()
```

## Requirements

- iOS 9.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+
- Xcode 8.3+
- Swift 4

## Installation

KTLoadingView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'KTLoadingView'
```

## Custom Font

You can set any font to text label as you want. Just set  `textFont` as your dedicated font.

```Swift
KTLoadingView.shared.textFont = UIFont.systemFont(ofSize: 40)
KTLoadingView.show() // Same as KTLoadingView.shared.show()
```

If you want to use the font in the sample gif, you can  [**download here**](https://osdn.net/projects/setofont/releases/).
Or you can find this font file inside `/Example/KTLoadingLabel`.

## Author

[Koki Tang](https://www.linkedin.com/in/kokitang/)

## License

KTLoadingView is available under the MIT license. See the LICENSE file for more info.
