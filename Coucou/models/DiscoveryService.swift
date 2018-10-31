import Foundation

public struct DiscoveryService {
    let name: String
    let ipaddress: String?
    let port: Int
}

public extension DiscoveryService {
    public func getHost() -> String? {
        if(ipaddress == nil) {
            return nil
        }
        return String(format: "%@:%d", ipaddress!, port)
    }
    
    public func toDictionary() -> Dictionary<String, Any> {
        return [
            "name": name,
            "ipaddress": ipaddress,
            "port": port
        ]
    }
}
