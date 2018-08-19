//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

protocol BottomSheetDelegate: AnyObject {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint)
}

protocol BottomSheet: AnyObject {
    var bottomSheetDelegate: BottomSheetDelegate? { get set }
}

typealias BottomSheetViewController = UIViewController & BottomSheet

protocol BottomSheetChrome: AnyObject {
    var topChromeHeight: CGFloat { get }
}

typealias BottomSheetChromeViewController = UIViewController & BottomSheetChrome

private class BottomSheetContainerView: UIView {
 
    private let mainView: UIView
    private let sheetView: UIView
    private let topChromeHeight: CGFloat
    private let chromeView: UIView
    private var sheetBackgroundTopConstraint: NSLayoutConstraint? = nil

    init(mainView: UIView, chromeView: UIView, topChromeHeight: CGFloat, sheetView: UIView) {
        self.mainView = mainView
        self.chromeView = chromeView
        self.topChromeHeight = topChromeHeight
        self.sheetView = sheetView
        
        super.init(frame: .zero)
    
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    var topDistance: CGFloat = 0 {
        didSet {
            sheetBackgroundTopConstraint?.constant = topDistance
        }
    }
    
    private func setupViews() {
        // The main view fills the view completely
        addSubview(mainView)
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.leftAnchor.constraint(equalTo: leftAnchor),
            mainView.rightAnchor.constraint(equalTo: rightAnchor),
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // The sheet background
        addSubview(chromeView)
        chromeView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = chromeView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            topConstraint,
            chromeView.heightAnchor.constraint(equalTo: heightAnchor),
            chromeView.leftAnchor.constraint(equalTo: leftAnchor),
            chromeView.rightAnchor.constraint(equalTo: rightAnchor)
            ])
        sheetBackgroundTopConstraint = topConstraint

        // The sheet table view goes all the way up to the status bar
        addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leftAnchor.constraint(equalTo: leftAnchor),
            sheetView.rightAnchor.constraint(equalTo: rightAnchor),
            sheetView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: topChromeHeight),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    // MARK: - UIView overrides
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if chromeView.bounds.contains(chromeView.convert(point, from: self)) {
            return sheetView.hitTest(sheetView.convert(point, from: self), with: event)
        }
        return mainView.hitTest(mainView.convert(point, from: self), with: event)
    }

}

class BottomSheetContainerViewController: UIViewController {

    private let mainViewController: UIViewController
    private let chromeViewController: BottomSheetChromeViewController
    private let sheetViewController: BottomSheetViewController
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         chromeView: chromeViewController.view,
                                                                         topChromeHeight: chromeViewController.topChromeHeight,
                                                                         sheetView: sheetViewController.view)
    
    init(mainViewController: UIViewController, chromeViewController: BottomSheetChromeViewController, sheetViewController: BottomSheetViewController) {
        self.mainViewController = mainViewController
        self.chromeViewController = chromeViewController
        self.sheetViewController = sheetViewController
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(mainViewController)
        addChild(chromeViewController)
        addChild(sheetViewController)
        
        sheetViewController.bottomSheetDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func loadView() {
        view = bottomSheetContainerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewController.didMove(toParent: self)
        chromeViewController.didMove(toParent: self)
        sheetViewController.didMove(toParent: self)
    }
    
}

extension BottomSheetContainerViewController: BottomSheetDelegate {
    func bottomSheet(_ bottomSheet: BottomSheet, didScrollTo contentOffset: CGPoint) {
        bottomSheetContainerView.topDistance = max(0, -contentOffset.y)
    }
}
