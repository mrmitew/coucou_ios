import Foundation

class AppleBonjour : NSObject, Driver {
    func getName() -> String {
        return "Apple Bonjour"
    }
    
    func createBroadcast() -> BroadcastEngine {
        return AppleBroadcast()
    }
    
    func createDiscovery() -> DiscoveryEngine {
        return AppleDiscovery()
    }
}
