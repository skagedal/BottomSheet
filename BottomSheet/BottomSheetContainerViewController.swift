//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import UIKit

class BottomSheetContainerView: UIView {
 
    private let mainView: UIView
    private let sheetView: UIView

    init(mainView: UIView, sheetView: UIView) {
        self.mainView = mainView
        self.sheetView = sheetView
        
        super.init(frame: .zero)
    
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
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
        
        // The sheet table view goes all the way up to the status bar
        addSubview(sheetView)
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sheetView.leftAnchor.constraint(equalTo: leftAnchor),
            sheetView.rightAnchor.constraint(equalTo: rightAnchor),
            sheetView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

}

class BottomSheetContainerViewController: UIViewController {

    private let mainViewController: UIViewController
    private let sheetViewController: UIViewController
    private lazy var bottomSheetContainerView = BottomSheetContainerView(mainView: mainViewController.view,
                                                                         sheetView: sheetViewController.view)
    
    init(mainViewController: UIViewController, sheetViewController: UIViewController) {
        self.mainViewController = mainViewController
        self.sheetViewController = sheetViewController
        
        super.init(nibName: nil, bundle: nil)
        
        addChild(mainViewController)
        addChild(sheetViewController)
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
        sheetViewController.didMove(toParent: self)
    }

}
