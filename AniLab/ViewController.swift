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
//        init(
//        let trayCenterWhenOpen = CGPoint(x: trayView.center.x, y: trayView.center.y - 150)
//        let trayCenterWhenClosed = CGPoint(x: trayView.center.x, y: trayView.center.y)
//        print(trayCenterWhenClosed, trayCenterWhenOpen)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTrayTap(sender: UITapGestureRecognizer) {
        if self.trayView.center.y == 134.0 {
            print(">>>Click it down")
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.trayView.center = CGPoint(x: 160.0, y: 284.0)
            })
            
        }else if self.trayView.center.y == 284.0 {
            print(">>>Click it up")
            UIView.animateWithDuration(0.8, animations: { () -> Void in
                self.trayView.center = CGPoint(x: 160.0, y: 134.0)
            })
        }
    }
    
    @IBAction func onTrayPan(panGestureRecognizer: UIPanGestureRecognizer) {
        
        // >0 going down <0 going up
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
                print(">>> down")
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.trayView.center = CGPoint(x: 160.0, y: 284.0)
                    })
                
            }else if velocity < 0 {
                print(">>>Going up")
                UIView.animateWithDuration(0.8, animations: { () -> Void in
                    self.trayView.center = CGPoint(x: 160.0, y: 134.0)
                })
            }
        }
    }
    

}

