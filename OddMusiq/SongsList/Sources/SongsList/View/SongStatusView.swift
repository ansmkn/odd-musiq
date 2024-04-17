import SwiftUI
import Combine

struct SongStatusView: View {
    var status: SongViewStatus
    var progressSubject: AnyPublisher<Float, Never>?
    
    var body: some View {
        Group {
            switch status {
            case .paused:
                Icons.pause.image
            case .playing:
                Icons.play.image
            case .unloaded:
                Icons.download.image
            case .loading(let progress):
                LoadingProgressView(progress: progress, progressSubject: progressSubject)
            }
        }
        .frame(width: 32, height: 32)
    }
}

#Preview {
    Group {
        SongStatusView(status: .paused)
        SongStatusView(status: .playing)
        SongStatusView(status: .unloaded)
        SongStatusView(status: .loading(0.3))
    }
}
