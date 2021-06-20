//
//  DataViewController.swift
//  CovidTracker
//

//

import UIKit
import SwiftUI

@available(iOS 14.0, *)
class DataViewController: UIViewController {

   @IBOutlet weak var dataLabel: UILabel! = UILabel()
    var dataObject: String = ""

    @IBSegueAction func newsView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: ContentView())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         
    }
    
   


}

