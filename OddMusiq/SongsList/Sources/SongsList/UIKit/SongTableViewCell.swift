#if canImport(UIKit)
import UIKit
import Combine

class SongTableViewCell: UITableViewCell {
    var progressCancellable: AnyCancellable?
    
    lazy var statusView: LegacySongViewStatusView = {
        let view = LegacySongViewStatusView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.secondaryBackground.uiColor
        return view
    }()
    
    lazy var songTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = Fonts.primary.asUIFont()
        label.textColor = Colors.primaryBackground.uiColor
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Colors.primaryBackground.uiColor
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
        
        containerView.addSubview(songTitleLabel)
        
        NSLayoutConstraint.activate([
            songTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            songTitleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 12),
            songTitleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -56)
        ])
        
        containerView.addSubview(statusView)
        NSLayoutConstraint.activate([
            statusView.heightAnchor.constraint(equalToConstant: 22),
            statusView.widthAnchor.constraint(equalToConstant: 22),
            statusView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -18),
            statusView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -13)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        progressCancellable?.cancel()
        statusView.progressView.setProgress(with: 0)
    }
}

#endif
