import Foundation

public protocol DiscoveryEngine : Engine {
    func discover(ofType type: String,
                  inDomain domain: String,
                  callback: @escaping (DiscoveryEvent) -> Void)
}
