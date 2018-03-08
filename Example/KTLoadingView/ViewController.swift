//
//  ViewController.swift
//  KTLoadingView
//
//  Created by kokitang on 03/03/2018.
//  Copyright (c) 2018 kokitang. All rights reserved.
//

import UIKit
import KTLoadingView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        KTLoadingView.show(in: view, text: "Loading", animateText: "...")
        KTLoadingView.shared.textFont = UIFont.systemFont(ofSize: 40)        
        KTLoadingView.show() // Same as KTLoadingView.shared.show()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

