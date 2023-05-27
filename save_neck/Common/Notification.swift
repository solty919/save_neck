import NotificationCenter

final class Notification: NSObject {
    
    static let shared = Notification()
    
    override init() {
        super.init()
        
        UNUserNotificationCenter.current().delegate = self
    }
    
    func authorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { (isArrow, error) in
                
        }
    }
    
    func local() {
        let content = UNMutableNotificationContent()
        content.title = "姿勢に注意"
        content.body = "作業に集中していますか？姿勢を見直してみましょう"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        let request = UNNotificationRequest(identifier: "id", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in }
        
    }
    
}

extension Notification: UNUserNotificationCenterDelegate {
    
    /// アプリがフォアグラウンドにある状態で通知を受けた際に呼ばれる
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) { }
    
}
