import SwiftUI

struct MainView: View {
    
    @ObservedObject var observer = MainObserver()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack {
                        airPods
                        threshold
                    }
                }
            }
            .navigationTitle("首守 Shushu")
        }
        .sheet(isPresented: observer.$isFirstLaunch) {
            Neck(isFirstLaunch: observer.$isFirstLaunch)
                .onDisappear {
                    observer.start()
                }
        }
    }
    
    private var airPods: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("AirPods Pro")
                    .font(.headline)
                    .bold()
                
                Spacer()
                
                isConnect
            }
            
            VStack(spacing: 32) {
                Image(systemName: "airpodspro")
                    .resizable()
                    .frame(width: 160, height: 120)
                    .foregroundColor(observer.isConnect ? .black : .black.opacity(0.5))
                    .rotationEffect(Angle.degrees(observer.quaternionX))
                
                Text(String(format: "%3.f", observer.quaternionX) + "°")
                    .font(.system(size: 64))
                    .bold()
            }
            .padding(32)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(observer.state.color, lineWidth: 4)
            )
        }
        .padding()
    }
    
    private var threshold: some View {
        VStack(alignment: .leading) {
            Text("通知する角度")
                .font(.headline)
                .bold()
            
            HStack(spacing: 32) {
                Text(String(format: "%3.f", observer.outRange) + "°")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                VStack(alignment: .trailing ,spacing: 32) {
                    Text("この角度以上傾くと\n通知します")
                        .font(.callout)
                        .font(.body)
                    
                    Button {
                        observer.onRollSet()
                    } label: {
                        Text("今の角度を設定")
                            .bold()
                    }
                }
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(8)
        }
        .padding()
    }
    
    private var isConnect: some View {
        observer.isConnect ?
            AnyView(
                HStack(spacing: 2) {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                    Text("接続中")
                        .bold()
                }
            )
        :
            AnyView(
                Text("未接続")
                    .bold()
                    .foregroundColor(Color(.secondaryLabel))
            )
    }
    
}

extension MainObserver.State {
    var color: Color {
        switch self {
        case .standard: return .clear
        case .outRange: return .yellow
        case .notify: return .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}