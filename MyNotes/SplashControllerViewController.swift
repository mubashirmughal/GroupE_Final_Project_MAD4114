//
//  SplashControllerViewController.swift
//  MyNotes
//
//  Created by Jaskaran on 2023-01-22.
//

import UIKit

class SplashControllerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2){
            self.performSegue(withIdentifier: "OpenMenu", sender: nil)
        }
        
    }
    

}
