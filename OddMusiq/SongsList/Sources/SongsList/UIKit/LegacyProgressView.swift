#if canImport(UIKit)
import UIKit

class LegacyProgressView: UIView {
    
    var progressLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    private func createCircularPath() {
        let size = intrinsicContentSize
        let lineWidth = 1.5
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                                      radius: (min(size.width, size.height) - lineWidth) / 2,
                                      startAngle: -CGFloat.pi / 2,
                                      endAngle: 3 * CGFloat.pi / 2,
                                      clockwise: true)

        // Track layer
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = Colors.primaryForeground.uiColor.cgColor
        trackLayer.lineWidth = lineWidth
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)

        // Progress layer
        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = Colors.accent.uiColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        progressLayer.anchorPointZ = .zero

        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        progressLayer.frame = bounds // important for rotation animation
        
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 22, height: 22)
    }
    
    func setProgress(with progress: CGFloat) {
        progressLayer.strokeEnd = progress
    }
}
#endif
