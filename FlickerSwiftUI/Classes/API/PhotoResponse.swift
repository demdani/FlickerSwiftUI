import Foundation

struct PhotoResponse: Codable {
	let photoPage: PhotoPageResponse?
	
    enum CodingKeys: String, CodingKey {
		case photoPage = "photos"
    }
}

struct PhotoPageResponse: Codable {
	let page: Int
	let pages: Int
	let perPage: Int
	let total: String
	let photos: [PhotoDataResponse]
	
    enum CodingKeys: String, CodingKey {
        case page
        case pages
		case perPage = "perpage"
		case total
		case photos = "photo"
    }
}

struct PhotoDataResponse: Codable {
	let farm: Int
	let id: String
	let isFamily: Int
	let isFriend: Int
	let isPublic: Int
	let owner: String
	let secret: String
	let server: String
	let title: String
	
    enum CodingKeys: String, CodingKey {
        case farm
        case id
		case isFamily = "isfamily"
		case isFriend = "isfriend"
		case isPublic = "ispublic"
		case owner
		case secret
		case server
		case title
    }
}

// MARK: Empty value

extension PhotoResponse {
	
	static var emptyValue: PhotoResponse {
		PhotoResponse(photoPage: nil)
	}
}
