import Foundation

public extension NetService {
    func toDiscoveryService() -> DiscoveryService {
        return DiscoveryService(name: self.name, ipaddress: self.getIpV4(), port: self.port)
    }
    
    func getIpV4() -> String? {
        if let ipData = self.addresses?.first {
            return (ipData as NSData).getIpV4()
        }
        return nil
    }
}

private extension NSData {
    func getIpV4(port: Int? = nil) -> String {
        var ip1 = UInt8(0)
        getBytes(&ip1, range: NSMakeRange(4, 1))
        
        var ip2 = UInt8(0)
        getBytes(&ip2, range: NSMakeRange(5, 1))
        
        var ip3 = UInt8(0)
        getBytes(&ip3, range: NSMakeRange(6, 1))
        
        var ip4 = UInt8(0)
        getBytes(&ip4, range: NSMakeRange(7, 1))
        
        if port != nil {
            return String(format: "%d.%d.%d.%d:%d", ip1, ip2, ip3, ip4, port!)
        } else {
            return String(format: "%d.%d.%d.%d", ip1, ip2, ip3, ip4)
        }
    }
}
