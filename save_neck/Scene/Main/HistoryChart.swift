import SwiftUI
import Charts
import OrderedCollections

struct HistoryChart: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \NeckDay.date, ascending: false)],
        animation: .default
    )
    var neckDays: FetchedResults<NeckDay>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("姿勢の履歴")
                .font(.headline)
                .bold()
            
            VStack(spacing: 32) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("今日のカウント")
                            .font(.subheadline)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                        Text("6回")
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 4) {
                            Image(systemName: "arrow.down.circle.fill")
                            Text("前回との差は")
                                .font(.subheadline)
                        }
                        Text("0回")
                            .font(.subheadline)
                    }
                    .foregroundColor(Color(UIColor.secondaryLabel))
                    
                }
                
                chart
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(8)
        }
        .padding()
    }
    
    private var chart: some View {
        neckDays.isEmpty ?
            AnyView(
                Text("まだデータがありません")
                        .foregroundColor(Color(UIColor.secondaryLabel))
            )
        :
            AnyView(
                Chart {
                    ForEach(summary(neckDays), id: \.key) { group in
                        BarMark(
                            x: .value("日付",
                                      group.key),
                            y: .value("合計",
                                      group.value.count)
                        )
                    }
                }
            )
    }
    
    typealias Group = [OrderedDictionary<String, [FetchedResults<NeckDay>.Element]>.Element]
    private func summary(_ neckDays: FetchedResults<NeckDay>) -> Group {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "MM/dd"
        
        let group = OrderedDictionary(grouping: neckDays) {
            formatter.string(from: $0.date!)
        }.sorted(by: { $0.key < $1.key })
        
        return group
    }
    
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        HistoryChart()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
