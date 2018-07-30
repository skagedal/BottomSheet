//
//  Copyright © 2018 Simon Kågedal Reimer. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController {

    private lazy var mapView = MKMapView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
