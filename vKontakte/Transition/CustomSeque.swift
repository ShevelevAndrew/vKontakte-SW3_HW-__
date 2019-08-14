//
//  CustomSeque.swift
//  vKontakte
//
//  Created by Andrew on 20/06/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    let animationDuration: TimeInterval = 0.5
    
    override func perform() {
        guard let containerView = source.view else { return }
        
        containerView.addSubview(destination.view)
        
        destination.view.frame = containerView.frame
        
        //destination.view.transform = CGAffineTransform(translationX: source.view.bounds.width, y: source.view.bounds.height)
        //destination.view.transform = CGAffineTransform(rotationAngle: .pi)// (translationX: source.view.bounds.width, y: source.view.bounds.height)
        destination.view.transform = CGAffineTransform(scaleX: -1, y: 0)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.destination.view.transform = .identity
        }, completion: { finished in
            self.source.present(self.destination, animated: false)
        })

    }
    
}
