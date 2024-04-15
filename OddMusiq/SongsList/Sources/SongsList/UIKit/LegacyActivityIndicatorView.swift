#if canImport(UIKit)
import UIKit

class LegacyActivityIndicatorView: UIView {
    // dummy solution for only one activity indicator
    private static var presented: LegacyActivityIndicatorView?
    
    var progressLayer = CAShapeLayer()
    var trackLayer = CAShapeLayer()
    
    private func createCircularPath() {
        let size = intrinsicContentSize
        let padding = 40.0
        let lineWidth = 4.0
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: size.width / 2, y: size.height / 2),
                                      radius: (min(size.width, size.height) - padding - lineWidth) / 2,
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
        progressLayer.strokeStart = 0.3
        progressLayer.strokeEnd = progressLayer.strokeStart + 0.25
        progressLayer.anchorPointZ = .zero

        
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.secondaryBackground.uiColor
        createCircularPath()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        progressLayer.frame = bounds // important for rotation animation
    }

    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func addRotationAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Double.pi * 2
        rotationAnimation.duration = 2 // Duration in seconds
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = Float.infinity
        
        progressLayer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    @MainActor
    static func hide() {
        presented?.removeFromSuperview()
        presented = nil
    }
    
    @MainActor
    static func present(in viewController: UIViewController) {
        hide()
        
        let indicatorView = LegacyActivityIndicatorView(frame: .zero)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(indicatorView)
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor)
        ])
        
        indicatorView.addRotationAnimation()
        presented = indicatorView
    }
}

#endif
