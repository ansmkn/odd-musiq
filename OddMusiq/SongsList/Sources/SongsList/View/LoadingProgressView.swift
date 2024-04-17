import SwiftUI
import Combine

struct LoadingProgressView: View {
    @State
    var progress: Float
    var progressSubject: AnyPublisher<Float, Never>
    
    init(progress: Float, progressSubject: AnyPublisher<Float, Never>? = nil) {
        self.progress = progress
        self.progressSubject = progressSubject ?? Empty<Float, Never>().eraseToAnyPublisher()
    }
    
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
        .onReceive(progressSubject) { progress in
            print("recieved progress, ", progress)
            self.progress = progress
        }
    }
}

#Preview {
    Group {
        LoadingProgressView(progress: 0)
        LoadingProgressView(progress: 0.3)
        LoadingProgressView(progress: 1)
    }
}
