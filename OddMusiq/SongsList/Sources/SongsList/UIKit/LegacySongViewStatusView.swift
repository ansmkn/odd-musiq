#if canImport(UIKit)
import UIKit

class LegacySongViewStatusView: UIView {
    
    let iconView = UIImageView()
    let progressView = LegacyProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(iconView)
        iconView.isHidden = true
        iconView.contentMode = .scaleAspectFit
        self.addSubview(progressView)
        progressView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        iconView.frame = bounds
        progressView.frame = bounds
    }
    
    func configure(with state: SongViewStatus) {
        switch state {
        case .loading(let progress):
            iconView.isHidden = true
            progressView.isHidden = false
            progressView.setProgress(with: CGFloat(progress))
        case .paused, .playing, .unloaded:
            progressView.isHidden = true
            iconView.isHidden = false
            iconView.image = state.uiIcon
        }
    }
}

extension SongViewStatus {
    var uiIcon: UIImage? {
        switch self {
        case .paused:
            return Icons.pause.uiImage
        case .playing:
            return Icons.play.uiImage
        case .unloaded:
            return Icons.download.uiImage
        case .loading:
            return nil
        }
    }
}
#endif
