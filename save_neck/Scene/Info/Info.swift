import SwiftUI

struct Info: View {
    @State var isOpenSafari = false
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    Image("neck")
                    
                    VStack(alignment: .leading, spacing: 8) {
                        head
                        detail
                    }
                    
                    main
                    
                    Spacer()
                        .frame(minHeight: 16)
                    
                    headsUp
                }
                .padding(.horizontal)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("ストレートネック")
        }
        .sheet(isPresented: $isOpenSafari) {
            SafariView(url: URL(string: "https://pubmed.ncbi.nlm.nih.gov/32878184/")!)
        }
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
    
    private var headsUp: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("注意喚起")
                .font(.headline)
                .bold()
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("本アプリは以下情報に基づいて健康をサポートします")
                .font(.callout)
                .fixedSize(horizontal: false, vertical: true)
            
            Button {
                isOpenSafari = true
            } label: {
                Text("「屈曲弛緩現象（Flexion Relaxation Phenomenon：FRP）と頭蓋脊椎角（Craniovertebral Angle：CVA）を用い、モニターの種類（自動昇降式モニターと固定式モニター）による頭部及び首の姿勢と疲労度に与える影響の比較研究」")
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
