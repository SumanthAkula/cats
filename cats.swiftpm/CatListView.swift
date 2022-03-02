import SwiftUI

struct CatListView: View {
    @ObservedObject var catListVM = CatListViewModel()
    
    var body: some View {
        if let cats = catListVM.cats {
            VStack {
                List(cats) { cat in
                    CatView(cat: cat)
                        .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .refreshable {
                    self.catListVM.getData()
                }
                Text("Average load time: \(self.catListVM.averageLoadTime)")
            }
        } else {
            Text("Loading cats!!")
                .onAppear() {
                    self.catListVM.getData()
                }
        }
    }
}
