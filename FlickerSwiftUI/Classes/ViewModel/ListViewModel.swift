import Foundation
import Combine

class ListViewModel: ObservableObject {
	
	private let service = FlickrService()
	private var cancellables = Set<AnyCancellable>()
	
	// MARK: input
	@Published var searchText: String
	
	// MARK: output
	@Published var listModel: PhotoListModel
	@Published var isLoading: Bool = false
	
	init(searchText: String, listModel: PhotoListModel) {
		self.searchText = searchText
		self.listModel = listModel
		
		subscribeForTextChanges()
	}
	
	/*
	 * No need for this
	 */
	deinit {
		cancellables.forEach { $0.cancel() }
	}
	
	private func subscribeForTextChanges() {
		/*$searchText
			.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
			.flatMap({ text -> AnyPublisher<PhotoResponse, Never> in
				guard text.count >= 3 else {
					return self.service.emptyResponse
				}
				return self.service.photos(with: text, page: 0)
			})
			.map(map(response:))
			.receive(on: DispatchQueue.main)
			.assign(to: \.listModel, on: self)
			.store(in: &cancellables)*/
		
		$searchText
		.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
		.flatMap({ [weak self] text -> AnyPublisher<PhotoResponse, Never> in
			guard let self = self, text.count >= 3 else {
				return FlickrService.emptyResponse
			}
			self.isLoading = true
			return self.service.photos(with: text, page: 0)
		})
		.map(map(response:))
		.receive(on: DispatchQueue.main)
		.sink(receiveValue: { [weak self] in
			self?.listModel = $0
			self?.isLoading = false
		})
		.store(in: &cancellables)
	}
	
	private func map(response: PhotoResponse) -> PhotoListModel {
		guard let photoPage = response.photoPage else {
			return PhotoListModel(total: "Found: 0", photos: [PhotoModel]())
		}
		
		let photos: [PhotoModel] = photoPage.photos.map { data in
			let id = "https://farm\(data.farm).staticflickr.com/\(data.server)/\(data.id)_\(data.secret)_z.jpg"
			return PhotoModel(id: id, title: data.title, imageURL: URL(string: id))
		}
		return PhotoListModel(total: "Found: \(photoPage.pages)", photos: photos)
	}
}

// MARK: Example

extension ListViewModel {
	
	static var example: ListViewModel {
		ListViewModel(searchText: "dog", listModel: PhotoListModel.example)
	}
}
