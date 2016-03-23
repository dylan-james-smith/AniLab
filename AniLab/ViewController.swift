//
//  ViewController.swift
//  AniLab
//
//  Created by Dylan Smith on 3/21/16.
//  Copyright © 2016 com.heydylan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    @IBOutlet var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    var trayCenterWhenOpen: CGPoint?
    var trayCenterWhenClosed: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: trayView.center.y - 150)
         trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayTap(sender: UITapGestureRecognizer) {
        if self.trayView.center == trayCenterWhenOpen {
            print(">>>Click it down")
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.trayView.center = self.trayCenterWhenClosed!
            })
            
        }else if self.trayView.center == trayCenterWhenClosed {
            print(">>>Click it up")
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.trayView.center = self.trayCenterWhenOpen!
            })
        }
    }
    
    @IBAction func onTrayPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        let velocity = panGestureRecognizer.velocityInView(trayView).y
        
        // Absolute (x,y) coordinates in parent view's coordinate system
//        let point = panGestureRecognizer.locationInView(parentView)
        
        // Total translation (x,y) over time in parent view's coordinate system
        let translation = panGestureRecognizer.translationInView(parentView)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.Began {
//            print("Gesture began at: \(point)")
            trayOriginalCenter = trayView.center
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Changed {
//            print("Gesture changed at: \(point)")

            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
//            print("Gesture ended at: \(point)")
            
            if velocity > 0 {
//                print(">>> down")
                UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: velocity/100, options: [], animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenClosed!
                    }, completion: { (Bool) -> Void in
                        
                })
            }else if velocity < 0 {
//                print(">>>Going up")
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.trayView.center = self.trayCenterWhenOpen!
                })
            }
        }
    }
    

}

