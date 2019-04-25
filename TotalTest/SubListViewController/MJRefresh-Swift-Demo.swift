//
//  MJRefresh-Swift-Demo.swift
//  TotalTest
//
//  Created by libx on 2019/4/10.
//  Copyright © 2019 lifeng. All rights reserved.
//
//
//  TestOneViewController.swift
//  TotalTest
//
//  Created by libx on 2019/4/9.
//  Copyright © 2019 lifeng. All rights reserved.
//

import UIKit
import Alamofire

// MARK: - Custom Delegate
protocol TestOneCellDelegate : class {
    func selectAction(model : CustomModel)
}

// MARK: - Custom Cell
class TestOneCell: UITableViewCell {
    
    weak var delegate : TestOneCellDelegate?
    
    var firstLabel:UILabel?
    var secondLabel:UILabel?
    var threeButton:UIButton?
    var curModel:CustomModel?
    
    deinit {
        delegate = nil
        print("cell释放了")
    }
    
    
    public func setData(oneString : String, secString : String, thrString : String) -> Void {
        firstLabel?.text = oneString
        secondLabel?.text = secString
        threeButton?.setTitle(thrString, for: UIControl.State.normal)
    }
    
    public func setDataModel(model : CustomModel) -> Void {
        self.curModel = model
        firstLabel?.text = model.firstString
        secondLabel?.text = model.secondString
        threeButton?.setTitle(model.thirdString, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.loadUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadUI() -> Void {
        
        self.accessoryType = UITableViewCell.AccessoryType.detailButton
        self.selectionStyle = UITableViewCell.SelectionStyle.blue;
        
        self.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0)
        
        firstLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        firstLabel?.backgroundColor = UIColor.red
        firstLabel?.textAlignment = NSTextAlignment.center
        firstLabel?.textColor = UIColor.blue
        firstLabel?.font = UIFont.systemFont(ofSize: 22)
        self.contentView.addSubview(firstLabel!)
        
        secondLabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: self.frame.size.height))
        secondLabel?.backgroundColor = UIColor.black
        secondLabel?.textAlignment = NSTextAlignment.left
        secondLabel?.textColor = UIColor.orange
        secondLabel?.font = UIFont.systemFont(ofSize: 25)
        self.contentView.addSubview(secondLabel!)
        
        threeButton = UIButton.init(type: UIButton.ButtonType.custom)
        threeButton?.titleLabel?.text = "abc"
        threeButton?.titleLabel?.font = UIFont.systemFont(ofSize: 22)
        threeButton?.titleLabel?.textColor = UIColor.red;
        threeButton?.frame = CGRect.init(x: self.frame.size.width - 100, y: 0, width: 100, height: self.frame.size.height)
        self.contentView.addSubview(threeButton!)
        threeButton?.addTarget(self, action: #selector(buttonClick(_button:)), for: UIControl.Event.touchUpInside)
        
        
    }
    
    @objc func buttonClick(_button : UIButton) {
        
        if delegate != nil {
            delegate?.selectAction(model: self.curModel!)
        }
        
    }
    
}

// MARK: - Custom Model
class CustomModel: NSObject {
    
    @objc var firstString:String?
    @objc var secondString:String?
    @objc var thirdString:String?
    
    override init() {
        super.init()
        self.initData()
    }
    
    public func initData() -> Void {
        self.firstString = "第一个字符串"
        self.secondString = "第二个字符串"
        self.thirdString = "第三个字符串"
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("赋值出错了");
    }
}


class MJRefresh_Swift_Demo: UIViewController, UITableViewDataSource, UITableViewDelegate, TestOneCellDelegate {
    
    var dataArray:NSMutableArray?
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: UITableView.Style.plain);
        tableView!.delegate = self;
        tableView!.dataSource = self;
        self.view.addSubview(tableView!);
        
        dataArray = NSMutableArray.init()
        for _ in 0..<10 {
            let model = CustomModel.init()
            
            let subDict = ["firstString" : "abc"]
            model.setValuesForKeys(subDict)
            dataArray?.add(model)
        }
        tableView!.reloadData()
        
        
        var arr = ["1","2","3","4"]
        print(arr)
        arr.insert("5", at: 3)
        print(arr)
        arr.swapAt(3, 4)
        print(arr)
        
        tableView!.mj_header = MJRefreshNormalHeader()
        tableView!.mj_header.setRefreshingTarget(self, refreshingAction: #selector(loadNewData))
        
        tableView!.mj_footer = MJRefreshAutoNormalFooter()
        tableView!.mj_footer.setRefreshingTarget(self, refreshingAction: #selector(loadMoreData))
        
        let count = dataArray!.count as! Int
        if ((count * 44) < Int(tableView!.frame.size.height)) {
            tableView!.mj_footer.isHidden = true
        }
        
        
    }
    
    @objc func loadNewData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            
            for _ in 0..<30 {
                let model = CustomModel.init()
                
                let subDict = ["firstString" : "abc"]
                model.setValuesForKeys(subDict)
                self.dataArray!.add(model)
                
            }
            self.tableView?.mj_footer.isHidden = false
            self.tableView!.reloadData()
            self.tableView?.mj_header.endRefreshing()
            self.tableView?.mj_footer.resetNoMoreData()
            
        }
    }
    
    @objc func loadMoreData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            for _ in 0..<3 {
                let model = CustomModel.init()
                
                let subDict = ["firstString" : "abc"]
                model.setValuesForKeys(subDict)
                self.dataArray!.add(model)
                
            }
            self.tableView!.reloadData()
            self.tableView?.mj_footer.endRefreshingWithNoMoreData()
            
        };
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 6 {
            
            self.navigationController?.popViewController(animated: true)
            
        } else if indexPath.row == 7 {
            self.nextToOCViewController()
        } else if (indexPath.row == 8) {
            self.getSomeData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray!.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellName = "cellName"
        
        let cell = TestOneCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellName)
        cell.delegate = self
        
        cell.setDataModel(model: dataArray![indexPath.row] as! CustomModel)
        
        if indexPath.row == 6 {
            
            cell.firstLabel?.text = "点击返回上一页"
            
        } else if indexPath.row == 7 {
            cell.firstLabel?.text = "点击跳转到OC的类里"
        } else if (indexPath.row == 8) {
            
            cell.firstLabel?.text = "点击进行Alamofire的网络请求"
        }
        
        //        cell.setData(oneString: String.init(format: "%d", indexPath.row), secString: String.init(format: "%d", indexPath.section), thrString: String.init(format: "%d", indexPath.row))
        
        
        return cell
    }
    
    //MARK: - Network
    func getSomeData() {
        
        var response: DataResponse<Any>?
        
        let urlString = "http://192.168.100.49:4000/v1/project"
        
        var datas:NSMutableArray?
        datas = NSMutableArray.init()
        
        AF.request(urlString, parameters: ["a": "a"]).responseJSON { resp in
            response = resp
            if response?.value == nil {
                print("返回出错");
                let alert = UIAlertController.init(title: "返回出错", message: "", preferredStyle: .alert);
                let action = UIAlertAction.init(title: "确定", style: .default, handler: { (alertC) in
                    self.dismiss(animated: true, completion: {
                        
                    })
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: {
                    
                })
            } else {
                
                let json = response?.value as! [String: Any]
                let responsArr = json["data"] as! Array<Any>
                
                for i in 0..<responsArr.count {
                    let oneDict = responsArr[i] as! [String:Any];
                    
                    let Time = oneDict["Time"] as! NSNumber
                    print(i, "Time = ", Time)
                    if Time != 0 {
                        datas?.add(oneDict)
                        print("添加了这个元素", Time)
                    }
                }
                
                print(datas!)
                
                let alert = UIAlertController.init(title: "返回数据成功", message: "", preferredStyle: .alert);
                let action = UIAlertAction.init(title: "确定", style: .default, handler: { (alertC) in
                    self.dismiss(animated: true, completion: {
                        
                    })
                })
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: {
                    
                })
                
                
            }
            
            
            
        }
        
        
        
    }
    
    //MARK: - TestOneCellDelegate
    func selectAction(model: CustomModel) {
        print("代理点击了 = ",model.thirdString!)
        
    }
    
    func nextToOCViewController() {
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
