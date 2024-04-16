import SwiftUI
import UseCaseProtocol
import Entities
import Router
import Container

struct LoadingProgressView: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 1.5)
                .foregroundColor(Colors.primaryBackground.color)
            Circle()
                .trim(from: 0.0, to: CGFloat(progress))
                .stroke(Colors.accent.color, style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                .animation(.default, value: progress)
        }
        .frame(width: 22, height: 22)
        .rotationEffect(.degrees(-90))
        .padding(4)
    }
}

#Preview {
    Group {
        LoadingProgressView(progress: 0)
        LoadingProgressView(progress: 0.3)
        LoadingProgressView(progress: 1)
    }
}

struct SongStatusView: View {
    var status: SongViewStatus
    
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
                LoadingProgressView(progress: progress)
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

struct SongView: View {
    var title: String
    @State var status: SongViewStatus
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(Fonts.primary.font)
                .lineLimit(2)
                .foregroundColor(Colors.primaryForeground.color)
                .padding(.top, 8)
                .padding(.horizontal, 12)
            HStack {
                Spacer()
                SongStatusView(status: status)
            }
            .padding(.trailing, 8)
            .padding(.bottom, 8)
        }
        .background(Colors.secondaryBackground.color)
        
        .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(Colors.primaryBackground.color)
//        .padding(top: 8, left: 12, r)
    }
}

#Preview {
    SongView(title: "How could you babe multiline asdf adsfasdf asdf asdf ", status: .loading(0.3))
        .frame(width: 320)
}

struct SongsListView: View {

    @ObservedObject
    var viewModel: SongsListViewModel
    
    @State var errorMessage: String?
    @State var showingErrorAlert = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.items, id: \.song.id) { state in
                    SongView(title: state.song.name, status: state.status)
                        .onTapGesture {
                            viewModel.onSelectItem(at: 0)
                        }
                }
            }
            .padding(.vertical, 4)
        }
        .onReceive(viewModel.$state) { state in
            guard case .error(let errorMessage) = state else { return }
            self.errorMessage = errorMessage
            self.showingErrorAlert = true
        }
        .alert(errorMessage ?? "", isPresented: $showingErrorAlert) {
            Button("OK", role: .cancel) { }
        }
        .onAppear {
            viewModel.onWillAppear()
        }
        .background(Colors.primaryBackground.color)
        
    }
}

extension SongViewState {
    static func template(title: String, status: SongViewStatus) -> SongViewState {
        SongViewState(song: .init(id: title, name: title, audioURL: URL(string: "example.com")!),
                      status: status)
    }
}

#Preview {
    SongsListView(
        viewModel: SongsListViewModel(
            items: [
                .template(title: "firebird", status: .paused),
                .template(title: "hommage a ts eliot", status: .playing),
                .template(title: "someone great", status: .loading(0.3))
            ],
            state: .songs
        )
    )
    .frame(width: 320, height: 630)
}

