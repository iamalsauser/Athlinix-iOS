//
//  ViewController.swift
//  Certificate
//
//  Created by admin65 on 15/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var certificateImageView: UIImageView!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "Certificate") {
            certificateImageView.image = image
        } else {
            print("Image not found")
        }
    }
}
