

import SwiftUI

struct ArtistsListView: View {
    let heading: String
    let songs: [MediaItem] = MediaItem.getSongs().shuffled()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(heading)
                    .font(.title)
                Spacer()
                Button("Show All") {}
                    .buttonStyle(.plain)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 30) {
                    ForEach(songs) { album in
                        CardView(title: album.title, subtitle: album.artist, image: album.image, isCircle: true)
                    }
                }
            }
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    ArtistsListView(heading: "Artists")
}
