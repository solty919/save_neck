import SwiftUI

struct Function: View {
    @Binding var isFirstLaunch: Bool
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 32) {
                    Image("airpodspro")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        head
                        detail
                    }
                    Spacer()
                }
                .padding(.horizontal)
            }
            
            NavigationLink(destination: Permission(isFirstLaunch: $isFirstLaunch)) {
                VStack {
                    Text("次へ")
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 44)
                }
                .background(Color.accentColor)
                .cornerRadius(8)
            }
            .padding()
        }
        .toolbarRole(.editor)
        .navigationTitle("はじめよう")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var head: some View {
        Text("傾きを設定しましょう")
            .font(.headline)
            .bold()
    }
    
    private var detail: some View {
        Text("""
            設定した傾きのまま一定時間経過するとユーザへ通知します
            自由に傾きを設定しましょう
            """)
        .font(.callout)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct Function_Previews: PreviewProvider {
    @State static var isFirstLaunch = true
    static var previews: some View {
        Function(isFirstLaunch: $isFirstLaunch)
    }
}
