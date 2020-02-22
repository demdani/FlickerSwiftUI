import SwiftUI

struct PhotoListView: View {
	
	@ObservedObject var viewModel: ListViewModel
	
	var body: some View {
		NavigationView {
			List {
				Section(header: Text("Type something here")) {
					HStack {
						TextField("", text: $viewModel.searchText)
							.modifier(ClearButton(text: $viewModel.searchText))
					}
				}
				Section(header: ListHeaderView(viewModel: viewModel)) {
					ForEach(viewModel.listModel.photos) { item in
						ListItemView(item: item)
					}
				}
			}
			.navigationBarTitle("Flickr")
			.listStyle(GroupedListStyle())
		}.onAppear {
			
		}
	}
}

struct ListHeaderView: View {
	
	@ObservedObject var viewModel: ListViewModel
	
	var body: some View {
		HStack {
			if viewModel.isLoading {
				ActivityIndicatorView(isAnimating: viewModel.isLoading)
			} else {
				Text(viewModel.listModel.total)
			}
		}
	}
}

struct ClearButton: ViewModifier {
	
    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .opacity(text == "" ? 0 : 1)
                .onTapGesture { self.text = "" }
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
		PhotoListView(viewModel: ListViewModel.example)
    }
}
