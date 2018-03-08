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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        KTLoadingView.show() // Same as KTLoadingView.shared.show()
//        KTLoadingView.show(in: nil, text: "Loading", animateText: "...")
        KTLoadingView.shared.textFont = UIFont.systemFont(ofSize: 40)
        KTLoadingView.show(text: "Loading", animateText: "...")
    }
}

