


import SwiftUI

struct ImageSliderView: View {

    @State private var selection = 0
    var imageUrls: [String]
    @State private var loadedImages: [UIImage?] = []

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                ForEach(0..<imageUrls.count, id: \.self) { i in
                    if let uiImage = loadedImages[safe: i] {
                        if let uiImage = uiImage {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } else {
                            Image(systemName: "photo.fill")
                                .resizable()
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
        .onAppear {
            loadImageUrls()
        }
    }

    func loadImageUrls() {
        Task {
            for imageUrl in imageUrls {
                if let url = URL(string: imageUrl),
                   let (data, _) = try? await URLSession.shared.data(from: url),
                   let uiImage = UIImage(data: data) {
                    loadedImages.append(uiImage)
                } else {
                    loadedImages.append(nil)
                }
            }
        }
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
