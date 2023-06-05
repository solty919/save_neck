import CoreLocation
import CoreMotion

final class AirPods: NSObject, CLLocationManagerDelegate {
    
    static let shared = AirPods()
    
    var onUpdate: ((Double) -> Void)?
    var onConnect: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var isDeviceMotionAvailable: Bool { motionManager.isDeviceMotionAvailable }
    
    private let motionManager = CMHeadphoneMotionManager()
    private let isMock = false
    
    private override init() {
        super.init()
        
        motionManager.delegate = self
    }
    
    func start() {
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion = motion else {
                self.onError?("Strings.Error.motion")
                return
            }
            
            if let error {
                self.onError?(error.localizedDescription)
            }
            print(motion.attitude.quaternion.x)
            self.onUpdate?(motion.attitude.quaternion.x)
        }
        
        //デバッグ用
        if isMock { mock() }
    }
    
    func stop() {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func requestPermission() {
        CMHeadphoneMotionManager.authorizationStatus()
    }
    
    private func mock() {
        Task {
            try await Task.sleep(for: .seconds(1))
            self.onConnect?(true)
            self.onUpdate?(-0.485)
            mock()
        }
    }
}

extension AirPods: CMHeadphoneMotionManagerDelegate {
    
    func headphoneMotionManagerDidConnect(_ manager: CMHeadphoneMotionManager) {
        onConnect?(true)
    }
    
    func headphoneMotionManagerDidDisconnect(_ manager: CMHeadphoneMotionManager) {
        onConnect?(false)
    }
    
}
