# Coucou
A highly modular network service discovery and broadcast library for iOS. For Android, search for coucou_android.

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
### Network Service Discovery
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

### Network Service Broadcast
- Yet to be done.

## To do
* Support for Network Service Broadcast
* Write unit tests 
* Complete sample
* More documentation
* Improve the README
