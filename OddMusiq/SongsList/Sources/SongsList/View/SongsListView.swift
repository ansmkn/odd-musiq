import SwiftUI
import UseCaseProtocol
import Entities
import Router
import Container

struct SongsListView: View {
    @ObservedObject
    var viewModel: SongsListViewModel
    
    @State var errorMessage: String?
    @State var showingErrorAlert = false
    
    func songView(at item: SongViewState) -> SongView {
        let subject = viewModel.loadingProcesses[item.song.id]?
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
        return SongView(title: item.song.name,
                        status: item.status,
                        progressSubject: subject)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.items, id: \.self.song.id) { item in
                    songView(at: item)
                        .onTapGesture {
                            if let index = viewModel.items.firstIndex(where: { $0.song.id == item.song.id }) {
                                viewModel.onSelectItem(at: index)
                            }
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

