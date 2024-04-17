import SwiftUI
import Combine

struct SongView: View {
    var state: SongViewState
    var progressSubject: AnyPublisher<Float, Never>?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(state.song.name)
                .font(Fonts.primary.font)
                .lineLimit(2)
                .foregroundColor(Colors.primaryForeground.color)
                .padding(.top, 8)
                .padding(.horizontal, 12)
            HStack {
                Spacer()
                SongStatusView(status: state.status, progressSubject: progressSubject)
            }
            .padding(.trailing, 8)
            .padding(.bottom, 8)
        }
        .background(Colors.secondaryBackground.color)
        .clipShape(RoundedRectangle(cornerRadius: 12.0, style: .continuous))
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
        .background(Colors.primaryBackground.color)
    }
}

#Preview {
    SongView(state: .template(title: "How could you babe multiline asdf adsfasdf asdf asdf ", status: .loading(0.3)))
        .frame(width: 320)
}
