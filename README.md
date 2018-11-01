[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Coucou.svg)](https://img.shields.io/cocoapods/v/Coucou.svg)
[![Platform](https://img.shields.io/cocoapods/p/Coucou.svg?style=flat)](https://github.com/mrmitew/coucou_ios/)

# Coucou (iOS)
A highly modular network service discovery and broadcast library for iOS. For Android, go to [coucou_android](https://github.com/mrmitew/coucou_android) repo.

## Coucou API
```swift
func startDiscovery(ofType type: String,
                    domain: String,
                    _ onResolved: (DiscoveryEvent) -> Void) -> Disposable
```

## How to use

### Creation
```swift
let coucou = Coucou.Builder()
        .driver(AppleBonjour())
        .logger(StandardLogger())
        .build()
}
```
#### Network Service Discovery
```swift
let disposable = coucou.startDiscovery(ofType: "_http._tcp.") { (event) in
  // TODO something with the DiscoveryEvent

  if(event is ServiceResolved) {
    // TODO something with event.service
  } else if (event is ServiceLost) {
    // TODO something with event.service
  } else if (event is DiscoveryFinished) {
    // TODO
  } else if (event is ResolvingFinished) {
    // TODO
  } else if (event is DiscoveryFailure) {
    // TODO
  }
}

// when discovery isn't needed, dispose

disposable.dispose()
```

`DiscoveryService` provides the following information:
```swift
public struct DiscoveryService {
    let name: String
    let ipaddress: String?
    let port: Int
}
```

For more insights, please refer to the source code.

#### Network Service Broadcast
- Yet to be done.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate Coucou into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'

target 'ENTER_YOUR_TARGET_NAME_HERE' do
    pod 'Coucou', '~> ENTER_COUCOU_VERSION_HERE'
end
```

Then, run the following command:

```bash
$ pod install
```

Done.

### Carthage
Unsupported at the moment.

## To do
* Support for Network Service Broadcast
* Write unit tests 
* Complete sample
* More documentation
* Improve the README
