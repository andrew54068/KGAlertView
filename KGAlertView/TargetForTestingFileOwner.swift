//
//  TargetForTestingFileOwner.swift
//  LoadingView
//
//  Created by kidnapper on 02/03/2018.
//  Copyright © 2018 25sprout.com. All rights reserved.
//

import UIKit

class TargetForTestingFileOwner: UIViewController {
    
    @IBAction func customAction(_ sender: Any) {
        KGAlertView.customShow(toView: view, imageName: "random_Image", title: "客製化")
    }
    @IBAction func unlikeAction(_ sender: Any) {
        KGAlertView.show(toView: view, category: .unlike, title: "已取消收藏")
    }
    @IBAction func cautionAction(_ sender: Any) {
        KGAlertView.show(toView: view, category: .caution, title: "密碼需至少八碼\n包含英數字")
    }
    @IBAction func likeAction(_ sender: Any) {
        KGAlertView.show(toView: view, category: .like, title: "已收藏")
    }
    @IBAction func successAction(_ sender: Any) {
        KGAlertView.show(toView: view, category: .success)
    }
    @IBAction func sendAction(_ sender: Any) {
        KGAlertView.customShow(toView: view, imageName: "random_Image", title: "test for showing multi lines in alertView label")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
