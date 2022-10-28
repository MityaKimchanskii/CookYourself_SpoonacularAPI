//
//  Factories.swift
//  SpoonacularAPI
//
//  Created by Mitya Kim on 10/25/22.
//

import UIKit

extension UIColor {
    static let lightGreen = UIColor(red: 0/255, green: 171/255, blue: 90/255, alpha: 1)
}

extension SpoonacularViewController {
    func boundsKeyFrameAnimation() -> CAKeyframeAnimation {
        let bounce = CAKeyframeAnimation(keyPath: "position")
        bounce.duration = 3
        bounce.values = [
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 - 45, y: UIScreen.main.bounds.height/2 + 45)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 - 50, y: UIScreen.main.bounds.height/2 - 50)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 + 45, y: UIScreen.main.bounds.height/2 - 45)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 + 50, y: UIScreen.main.bounds.height/2 + 50)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width/2 - 45, y: UIScreen.main.bounds.height/2 + 45)),
            NSValue(cgPoint: CGPoint(x: UIScreen.main.bounds.width + 200, y: UIScreen.main.bounds.height + 200))
        ]
        bounce.keyTimes =  [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        return bounce
    }
}

extension UIViewController {
    func attentionAlert() {
        let alert = UIAlertController(title: "Attention", message: "You have reached the limit of calls to the Server, please switch to another plan.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
