//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

private let borderWidth: CGFloat = 1
private let cornerRadius: CGFloat = 12
private let topChromeHeight: CGFloat = 8
private let handleBarSize = CGSize(width: 24, height: 2)

private class HandleBarView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .black
        layer.cornerRadius = handleBarSize.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }

    override var intrinsicContentSize: CGSize {
        return handleBarSize
    }
}

private class StandardBottomSheetChromeView: UIView {
    let topChromeHeight: CGFloat = 16
    let topChromeLayoutGuide = UILayoutGuide()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = cornerRadius
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = borderWidth
        
        addLayoutGuide(topChromeLayoutGuide)
        NSLayoutConstraint.activate([
            topChromeLayoutGuide.leftAnchor.constraint(equalTo: leftAnchor),
            topChromeLayoutGuide.rightAnchor.constraint(equalTo: rightAnchor),
            topChromeLayoutGuide.topAnchor.constraint(equalTo: topAnchor),
            topChromeLayoutGuide.heightAnchor.constraint(equalToConstant: topChromeHeight)
        ])
     
        let handleBar = HandleBarView()
        handleBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(handleBar)
        NSLayoutConstraint.activate([
            handleBar.centerXAnchor.constraint(equalTo: topChromeLayoutGuide.centerXAnchor),
            handleBar.centerYAnchor.constraint(equalTo: topChromeLayoutGuide.centerYAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
 
    override func layoutSubviews() {
        super.layoutSubviews()
 
        // Make sure border isn't visible
        layer.bounds = CGRect(origin: bounds.origin,
                              size: CGSize(width: bounds.size.width + borderWidth * 2,
                                           height: bounds.size.height))
    }
}

class StandardBottomSheetChromeViewController: BottomSheetChromeViewController {
    private let chromeView = StandardBottomSheetChromeView()
    
    var topChromeHeight: CGFloat {
        return chromeView.topChromeHeight
    }
    
    override func loadView() {
        self.view = chromeView
    }
}
