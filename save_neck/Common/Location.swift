import CoreLocation

final class Location: NSObject, CLLocationManagerDelegate {
    
    static let shared = Location()
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.showsBackgroundLocationIndicator = true
        locationManager.pausesLocationUpdatesAutomatically = false
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
    
    func stop() {
        locationManager.stopUpdatingLocation()
    }
    
    func requestPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
}
