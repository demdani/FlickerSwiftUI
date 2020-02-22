import SwiftUI

class Assembly {
	
	static func createList() -> some View {
		let viewModel = ListViewModel(searchText: "dog", listModel: PhotoListModel.empty)
		return PhotoListView(viewModel: viewModel)
	}
	
	static func createDetail(with model: PhotoModel) -> some View {
		let viewModel = DetailViewModel(stringURL: model.imageURL?.absoluteString)
		return ItemDetailView(viewModel: viewModel)
	}
}
