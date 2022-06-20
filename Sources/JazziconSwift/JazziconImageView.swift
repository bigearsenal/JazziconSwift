import Foundation
#if os(iOS)
import UIKit
open class JazziconImageView: UIView {

    @IBInspectable public var seed: UInt32 {
        willSet {
            setNeedsDisplay()
        }
    }
    
    public init(frame: CGRect, seed: UInt32) {
        self.seed = seed
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        self.seed = 1
        super.init(coder: coder)
    }
    
    // MARK: Override Draw
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        let jazzicon = Jazzicon(seed: seed)
        jazzicon.draw(with: context, in: rect)
    }
}
#endif
