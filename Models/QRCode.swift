//
//  QRCode.swift
//  CovidTracker
//

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
