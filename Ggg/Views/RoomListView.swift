

import SwiftUI

struct RoomListView: View {
    @ObservedObject var viewModel: RoomDataViewModel
    @EnvironmentObject var coordinator: AppCoordinator
    
//MARK: - init
    init(viewModel: RoomDataViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            RoomDetailView(rooms: viewModel.roomData?.rooms ?? [])
        }
    }
}
struct BNumberView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RoomDataViewModel()
        return RoomListView(viewModel: viewModel)
    }
}
