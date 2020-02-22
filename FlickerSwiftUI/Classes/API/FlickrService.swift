import Foundation
import Combine

class FlickrService {
	
	private let decoder = JSONDecoder()
	
	private let baseURL = "https://www.flickr.com/services/rest"
	private let defaultParameters = [
		"api_key": "57f694132e4714c29a64c9af890b124e",
		"format": "json",
		"nojsoncallback": "1",
	]
	
	private func createURL(with parameters: [String: String]) -> URL? {
		var components = URLComponents(string: baseURL)
		
		components?.queryItems = parameters.reduce([URLQueryItem]()) {
			let item = URLQueryItem(name: $1.key, value: $1.value)
			var items = $0
			items.append(item)
			return items
		}
		
		return components?.url
	}
	
	func photos(with text: String, page: Int) -> AnyPublisher<PhotoResponse, Never> {
		var parameters = [
			"text": text,
			"method": "flickr.photos.search",
			"per_page": "50",
			"page": "\(page)"
		]
		parameters = parameters.merging(defaultParameters) { _, new in new }
		guard let url = createURL(with: parameters) else { return Self.emptyResponse }
		
		return URLSession.shared.dataTaskPublisher(for: url)
			.map { $0.data }
			.decode(type: PhotoResponse.self, decoder: decoder)
			.replaceError(with: PhotoResponse.emptyValue)
			.eraseToAnyPublisher()
	}
}

// Mark: Empty response

extension FlickrService {
	
	static var emptyResponse: AnyPublisher<PhotoResponse, Never> {
		Just(PhotoResponse.emptyValue).eraseToAnyPublisher()
	}
}
