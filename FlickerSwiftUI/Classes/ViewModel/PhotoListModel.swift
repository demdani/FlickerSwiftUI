import Foundation

struct PhotoListModel {
	let total: String
	let photos: [PhotoModel]
}

struct PhotoModel: Identifiable {
	let id: String
	let title: String
	let imageURL: URL?
}

// MARK: Example

extension PhotoListModel {
	
	static var example: PhotoListModel {
		var array = [PhotoModel]()
		array.append(PhotoModel.example)
		array.append(PhotoModel(id: "2",
							   title: "Ide megpróbálok egy viszonylag hosszú szöveget írni. Lehetőleg úgy, hogy több sorba törtelődjön.",
							   imageURL: URL(string: "https://www.bol-dog.com/files/image/boldog_kutyak/2019/vassviktoriabono_kics_r300.jpg")))
		return PhotoListModel(total: "Found: \(array.count)", photos: array)
	}
	
	static var empty: PhotoListModel {
		PhotoListModel(total: "", photos: [PhotoModel]())
	}
}

extension PhotoModel {
	
	static var example: PhotoModel {
		PhotoModel(id: "1",
				   title: "Rövidke szöveg",
				   imageURL: URL(string: "https://i.dailymail.co.uk/1s/2019/11/23/09/21370544-7717313-image-a-1_1574501083030.jpg"))
	}
}
