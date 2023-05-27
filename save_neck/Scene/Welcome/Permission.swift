import SwiftUI

struct Permission: View {
    @Binding var isFirstLaunch: Bool
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                Image("alert")
                    .padding()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("本アプリは以下の機能を利用します")
                        .font(.callout)
                    
                    Spacer()
                        .frame(height: 8)
                    
                    motion
                    gps
                    notify
                }
                .padding(.horizontal)
            }
            
            VStack {
                Button {
                    AirPods.shared.requestPermission()
                    Notification.shared.authorization()
                    isFirstLaunch = false
                } label: {
                    Text("はじめる")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
            }
            .background(Color.accentColor)
            .cornerRadius(8)
            .padding()
        }
        .toolbarRole(.editor)
        .navigationTitle("はじめよう")
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
    private var motion: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("AirPodsPro モーションセンサ")
                .font(.headline)
                .bold()
            Text("姿勢を検知するためにモーションセンサを利用します")
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var gps: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("位置情報")
                .font(.headline)
                .bold()
            Text("どの場所で姿勢が変動しているかを検知するのに利用します")
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    private var notify: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("通知")
                .font(.headline)
                .bold()
            Text("姿勢が悪くなっている時に通知機能を利用します")
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
    
}

struct Permission_Previews: PreviewProvider {
    @State static var isFirstLaunch = true
    static var previews: some View {
        Permission(isFirstLaunch: $isFirstLaunch)
    }
}
