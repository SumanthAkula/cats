import SwiftUI

struct CatListView: View {
    @ObservedObject var catListVM = CatListViewModel()
    
    var body: some View {
        if let cats = catListVM.cats {
            List(cats) { cat in
                CatView(cat: cat)
            }
            .listStyle(.plain)
            .refreshable {
                self.catListVM.getData()
            }
        } else {
            Text("Loading cats!!")
                .onAppear() {
                    self.catListVM.getData()
                }
        }
    }
}
