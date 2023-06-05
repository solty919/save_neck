import Foundation
import UserNotifications
import SwiftUI
import Combine

final class MainObserver: NSObject, ObservableObject {
    
    @Published var quaternionX = 0.0
    @Published var isConnect = false
    @Published var error = ""
    @Published var state: State = .standard
    @AppStorage("outRange") var outRange = 80.0
    @AppStorage("isFirstLaunch") var isFirstLaunch = true
    
    enum State { case standard; case outRange; case notify }
    
    var isDeviceMotionAvailable = AirPods.shared.isDeviceMotionAvailable
    
    private var task: Task<Void, Error>?
    private var crashTask: Task<Void, Error>?
    
    override init() {
        super.init()
        
        guard !isFirstLaunch else {
            return
        }
        
        start()
    }
    
    func onRollSet() {
        outRange = quaternionX
    }
    
    func start() {
        AirPods.shared.onUpdate = { quaternionX in
            self.quaternionX = quaternionX * -180
            self.check()
        }
        AirPods.shared.onConnect = { isConnect in
            if !isConnect {
                self.quaternionX = 0.0
                self.state = .standard
                self.task?.cancel()
                self.exitTimer()
            } else {
                self.crashTask?.cancel()
            }
            self.isConnect = isConnect
        }
        AirPods.shared.onError = { error in
            self.error = error
        }
        
        AirPods.shared.start()
        Location.shared.start()
    }
    
    private func check() {
        let abs = fabs(quaternionX)
        if abs > outRange {
            switch state {
            case .standard:
                state = .outRange
                task = Task { @MainActor in
                    try await Task.sleep(for: .seconds(3))
                    state = .notify
                    Notification.shared.local()
                }
            case .outRange: return
            case .notify: return
            }
            
        } else {
            task?.cancel()
            state = .standard
        }
    }
    
    private func exitTimer() {
        crashTask = Task.detached {
            try await Task.sleep(for: .seconds(60 * 10)) //10m
            await UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
            try await Task.sleep(for: .seconds(0.2)) //0.2s
            exit(0)
        }
    }
    
}
