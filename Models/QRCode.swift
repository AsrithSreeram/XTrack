//
//  QRCode.swift
//  CovidTracker
//
//  Created by Software Development HS_902 on 11/14/20.
//  Copyright © 2020 Software Development HS_902. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 14.0, *)
class QRCode {
    
    var code: UIImage
    
    init(_ image: UIImage){
        self.code=image
    }
    
    func scan() -> Location {
        return scan()
    }
 
}
