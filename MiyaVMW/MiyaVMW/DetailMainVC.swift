//
//  DetailMainVC.swift
//  MiyaVMW
//
//  Created by Besta, Balaji (623-Extern) on 07/09/20.
//  Copyright © 2020 Balaji Besta. All rights reserved.
//

import Foundation
import UIKit
import UIKit


//let bgColor : UIColor = UIColor(red: 40/255, green: 43/255, blue: 51/255, alpha: 1.0)
let mblueColor : UIColor = UIColor(red: 49/255, green: 116/255, blue: 245/255, alpha: 1.0)
let mgreenColor : UIColor = UIColor(red: 119/255, green: 204/255, blue: 42/255, alpha: 1.0)


class DetailMainVC: UIViewController {
    @IBOutlet var headerView: UIView!
    @IBOutlet var updateButton : UIButton!
    @IBOutlet var basicInfo: UIView!
    @IBOutlet var scanerInformations: UIView!
    @IBOutlet var segementControl : UISegmentedControl!
    override func viewDidLoad() {
           super.viewDidLoad()
        
//        self.navigationItem.setHidesBackButton(true, animated: true)
//        headerView.roundCorners([.bottomLeft,.bottomRight], radius: 10)
//
//        updateButton.roundCorners([.allCorners], radius: 10)
//        headerView.layer.cornerRadius = 10
//        let redBox = UIView(frame: CGRect(x: 10, y: 10, width: 128, height: 128))
//        redBox.backgroundColor = .red
//        redBox.layer.cornerRadius = 25
//        redBox.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
//        headerView.addSubview(redBox)
        headerView.layer.cornerRadius = 31
        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        basicInfo.dropShadow(scale: true)
        scanerInformations.dropShadow(scale: true)
        updateButton.dropShadow(scale: true)

        
//       let sortedViews = segmentedControlOutletVariable.subviews.sort( { $0.frame.origin.x < $1.frame.origin.x } )
//        let sortedViews = segementControl.subviews.sorted(by: { $0.frame.origin.x < $1.frame.origin.x } )
//       sortedViews[0].tintColor = UIColor.blue
        
        let normalFont = UIFont(name: "Helvetica", size: 16.0)
        segementControl.setTitleTextAttributes([NSAttributedString.Key.font: normalFont!],
                                                    for: .normal)
        segementControl.setSelectedSegmentForegroundColor(.white, andTintColor: mblueColor);
                   segementControl.layer.borderWidth = 1.0
                   segementControl.layer.cornerRadius = 5.0
                   segementControl.layer.borderColor = mblueColor.cgColor
                   segementControl.layer.masksToBounds = true
                   updateButton.backgroundColor = mblueColor
                   updateButton.setTitle("Customer Label Printing", for: .normal)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func logoutAction(_ sender: Any) {
//        self.cus_no.text = ""
//        self.cus_name.text = ""
//        self.addr_1.text = ""
//        self.email.text = ""
        
        Singleton.shared.cusno = " "
        Singleton.shared.cusname = " "
        Singleton.shared.add1 = " "
        Singleton.shared.email = " "
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func indexChanged(sender: UISegmentedControl) {
        
        switch segementControl.selectedSegmentIndex
        {
        case 0:
//            let subViewOfSegment: UIView = segementControl.subviews[0] as UIView
//                   subViewOfSegment.backgroundColor = UIColor.blue
            
            segementControl.setSelectedSegmentForegroundColor(.white, andTintColor: mblueColor);
                       segementControl.layer.borderWidth = 1.0
                       segementControl.layer.cornerRadius = 5.0
                       segementControl.layer.borderColor = mblueColor.cgColor
                       segementControl.layer.masksToBounds = true
                       updateButton.backgroundColor = mblueColor
                       updateButton.setTitle("Customer Label Printing", for: .normal)
            
        case 1:
//            let subViewOfSegment: UIView = segementControl.subviews[1] as UIView
//                   subViewOfSegment.backgroundColor = UIColor.green
            
            
            segementControl.setSelectedSegmentForegroundColor(.white, andTintColor: mgreenColor);
            segementControl.layer.borderWidth = 1.0
            segementControl.layer.cornerRadius = 5.0
            segementControl.layer.borderColor = mgreenColor.cgColor
            segementControl.layer.masksToBounds = true
            updateButton.backgroundColor = mgreenColor
            updateButton.setTitle("Receive Container", for: .normal)
        default:
//            let subViewOfSegment: UIView = segementControl.subviews[0] as UIView
//            subViewOfSegment.backgroundColor = UIColor.blue
            segementControl.setSelectedSegmentForegroundColor(.white, andTintColor: mblueColor);
            segementControl.layer.borderWidth = 1.0
            segementControl.layer.cornerRadius = 5.0
            segementControl.layer.borderColor = mblueColor.cgColor
            segementControl.layer.masksToBounds = true
            updateButton.backgroundColor = mblueColor
            updateButton.setTitle("Customer Label Printing", for: .normal)
        }

//        let sortedViews = sender.subviews.sort( { $0.frame.origin.x < $1.frame.origin.x } )

        
//        segementControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: UIControl.State.selected)
        
       

       /*
        let sortedViews = sender.subviews.sorted(by: { $0.frame.origin.x < $1.frame.origin.x } )
        for (index,view) in sortedViews.enumerated() {
            if index == sender.selectedSegmentIndex {
//                view.tintColor = UIColor.blue
                
                let subViewOfSegment: UIView = segmentOutlet.subviews[1] as UIView
                subViewOfSegment.backgroundColor = UIColor.blue
            } else {
                view.tintColor = UIColor.lightGray
            }
        }*/

    }
    /*@IBAction func indexChanged(_ sender: Any) {
        switch segementControl.selectedSegmentIndex
        {
        case 0:
            updateButton.titleLabel?.text = "Customer Label Printing"
            updateButton.backgroundColor = .blue
//            textLabel.text = "First Segment Selected"
        case 1:
            updateButton.titleLabel?.text = "Receive Container"
            updateButton.backgroundColor = .green
//            textLabel.text = "Second Segment Selected"
        default:
            break
        }
    }*/
    
}



extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
extension UIView {

// OUTPUT 1
func dropShadow(scale: Bool = true) {
    layer.cornerRadius = 10
  layer.shadowColor = UIColor.lightGray.cgColor
  layer.shadowOpacity = 1
  layer.shadowOffset = .zero
  layer.shadowRadius = 10
    
}
}

extension UISegmentedControl {
    func setSelectedSegmentForegroundColor(_ foregroundColor: UIColor, andTintColor tintColor: UIColor) {
        if #available(iOS 13.0, *) {
            self.setTitleTextAttributes([.foregroundColor: foregroundColor], for: .selected)
            self.selectedSegmentTintColor = tintColor;
        } else {
            self.tintColor = tintColor;
        }
    }
}

