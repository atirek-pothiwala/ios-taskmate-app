//
//  Application+Extension.swift
//  taskmate
//
//  Created by Atirek Pothiwala on 18/12/24.
//

import UIKit

extension UIApplication {
    static func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
    
    static func getSafeAreaMargin() -> CGFloat {
        return safeAreaInsets.bottom + deviceHeight * 0.1
    }
    
    static var deviceHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var deviceWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var safeAreaInsets: UIEdgeInsets {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        
        return keyWindow?.safeAreaInsets ?? .zero
    }
}
