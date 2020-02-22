import Foundation
import Combine

class DetailViewModel: ObservableObject {
	
	@Published var url: URL?
	
	init(stringURL: String?) {
		url = Self.createURL(from: stringURL)
	}
	
	private static func createURL(from string: String?) -> URL? {
		guard let string = string else { return URL(string: "") }
		return URL(string: string.replacingOccurrences(of: "_z.jpg", with: "_b.jpg"))
	}
}

extension DetailViewModel {
	
	static var example: DetailViewModel {
		DetailViewModel(stringURL: "https://www.bol-dog.com/files/image/boldog_kutyak/2019/vassviktoriabono_kics_r300.jpg")
	}
}
