import SwiftUI
import KingfisherSwiftUI

struct ListItemView: View {
	
	var item: PhotoModel
	
    var body: some View {
		NavigationLink(destination: Assembly.createDetail(with: item)) {
			HStack(spacing: 20) {
				KFImage(item.imageURL)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 150, height: 150)
				Text(item.title)
					.font(.body)
					.multilineTextAlignment(.center)
					.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
		}
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
		ListItemView(item: PhotoModel.example)
    }
}
