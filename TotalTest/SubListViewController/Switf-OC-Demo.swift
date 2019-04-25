//
//  Switf-OC-Demo.swift
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//

import UIKit

class Switf_OC_Demo: UIViewController {
    
    var demoButton:UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Swift调用OC代码的例子"
        self.view.backgroundColor = UIColor.white

        /// 混编的时候，新建立Swift文件的时候，xcode会自动提示是否新建。文件名=Bridging-Header.h文件，点击是，然后把要引用的OC文件import里面，就可以直接调用OC的代码了
        
        
        demoButton = UIButton.init(type: UIButton.ButtonType.custom)
        demoButton!.setTitle("调用OC类", for: .normal)
        demoButton!.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        demoButton?.setTitleColor(UIColor.red, for: .normal)
        demoButton!.frame = CGRect.init(x: (self.view.frame.size.width - 150)/2.0, y: (self.view.frame.size.height - 54.0)/2.0, width: 150, height: 54.0)
        self.view.addSubview(demoButton!)
        demoButton?.addTarget(self, action: #selector(buttonClick(_button:)), for: UIControl.Event.touchUpInside)

    }
    
    @objc func buttonClick(_button : UIButton) {
        let spVC = SPActivityIndicatorView_animationButton.init()
        self.navigationController?.pushViewController(spVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
