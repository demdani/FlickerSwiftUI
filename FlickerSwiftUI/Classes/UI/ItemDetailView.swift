import SwiftUI
import KingfisherSwiftUI

struct ItemDetailView: View {
	
	private static let defaultScale: CGFloat = 1
	
	@ObservedObject var viewModel: DetailViewModel
	
	@State var duration: Double = 0
	@State var scale: CGFloat = Self.defaultScale
	@State var lastScale: CGFloat = Self.defaultScale
	
	var body: some View {
		KFImage(viewModel.url)
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.scaleEffect(scale)
			.gesture(MagnificationGesture().onChanged {
				self.duration = 0
				let delta = $0 / self.lastScale
				self.lastScale = $0
				self.scale = self.scale * delta
			}.onEnded { _ in
				self.lastScale = Self.defaultScale
			})
			.animation(.linear(duration: duration))
			.onTapGesture(count: 2) {
				self.duration = 0.2
				self.scale = self.scale == Self.defaultScale ?
					3 : Self.defaultScale
			}
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
		ItemDetailView(viewModel: DetailViewModel.example)
    }
}
