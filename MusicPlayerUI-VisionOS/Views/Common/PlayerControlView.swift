import SwiftUI
import AVFoundation

class AudioPlayerManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?
    @Published var isPlaying = false
    
    func setupAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "SixFeet", ofType: "mp3") else {
            print("Audio file not found.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.prepareToPlay()
        } catch {
            print("Error initializing AVAudioPlayer: \(error.localizedDescription)")
        }
    }
    
    func togglePlayPause() {
        if let player = audioPlayer {
            if player.isPlaying {
                player.pause()
            } else {
                player.play()
            }
            isPlaying.toggle()
        }
    }
}

struct PlayerControlView: View {
    @StateObject private var audioPlayerManager = AudioPlayerManager()
    
    var body: some View {
        HStack {
            PlayerButton(isPlaying: audioPlayerManager.isPlaying) {
                // Action for backward button
                print("Backward button tapped")
            }
            PlayerButton(isPlaying: audioPlayerManager.isPlaying) {
                // Action for play/pause button
                audioPlayerManager.togglePlayPause()
            }
            PlayerButton(isPlaying: audioPlayerManager.isPlaying) {
                // Action for forward button
                print("Forward button tapped")
            }
            AudioPlayerView()
            PlayerButton(isPlaying: audioPlayerManager.isPlaying) {
                // Action for quote button
                print("Quote button tapped")
            }
            PlayerButton(isPlaying: audioPlayerManager.isPlaying) {
                // Action for list button
                print("List button tapped")
            }
            PlayerButton(isPlaying: audioPlayerManager.isPlaying) {
                // Action for speaker button
                print("Speaker button tapped")
            }
        }
        .padding(.vertical, 10)
        .onAppear {
            audioPlayerManager.setupAudioPlayer()
        }
    }
}

struct AudioPlayerView: View {
    var body: some View {
        HStack {
            Image("weekend")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
            
            VStack(alignment: .leading) {
                Text("Six Feet Under")
                Text("The Weekend")
                    .font(.caption)
                    .foregroundStyle(.tertiary)
            }
            .frame(width: 240, alignment: .leading)
            
            Button(action: {}, label: {
                Image(systemName: "ellipsis")
            })
            .buttonBorderShape(.circle)
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 8)
        .background(.ultraThickMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

struct PlayerButton: View {
    let isPlaying: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                .font(.system(size: 24)) // Adjust font size as needed
                .foregroundColor(.primary)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControlView()
    }
}

