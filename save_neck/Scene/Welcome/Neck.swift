import SwiftUI

struct Neck: View {
    @Binding var isFirstLaunch: Bool
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 16) {
                        Image("neck")
                        
                        VStack(alignment: .leading, spacing: 8) {
                            head
                            detail
                        }
                        
                        Spacer()
                        main
                        Spacer()
                    }
                    .padding(.horizontal)
                }
                
                NavigationLink(destination: Function(isFirstLaunch: $isFirstLaunch)) {
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
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("はじめよう")
        }
        .interactiveDismissDisabled()
    }
    
    private var head: some View {
        Text("スマホ首、別名「ストレートネック」")
            .font(.headline)
            .bold()
            .fixedSize(horizontal: false, vertical: true)
    }
    
    private var detail: some View {
        Text("成人の頭の重さは平均約4〜6キロと言われています。\n\nその重い頭を支えるために首は頚椎（けいつい）と呼ばれる7本の骨で支えられています。その首の骨がまっすぐに(ストレートに)なってしまった状態が、スマホ首です。\n\nスマホやパソコンを使うとき、首を前に出した姿勢をとり続けることで、本来、カーブを描いているはずの首の骨がまっすぐになってしまうと考えられています。")
            .font(.callout)
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private var main: some View {
        Text("本アプリは姿勢の改善を手助けし\n健康な体をサポートします")
            .font(.headline)
            .multilineTextAlignment(.center)
            .bold()
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct Neck_Previews: PreviewProvider {
    @State static var isFirstLaunch = true
    static var previews: some View {
        Neck(isFirstLaunch: $isFirstLaunch)
    }
}
