//
//  ViewController.swift
//  TestSort
//
//  Created by 天机否 on 17/3/24.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import UIKit
let screenWith = UIScreen.main.bounds.width
let tempWith  = (screenWith - 300)*0.5
var signal: DispatchSemaphore!
class ViewController: UIViewController {
    private var sortView:SortView!
    private var arr:[UInt32] = []
    private var count = 0
    private var isSorting = false
    private var timer:Timer!
    private var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        for _ in 0..<100{
            arr.append(arc4random()%400)
        }
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        btn.setTitle("点击", for: .normal)
        btn.frame = CGRect.init(x: 20, y: 20, width: 100, height: 40)
        btn.center = CGPoint.init(x: screenWith*0.5, y: 40)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(ViewController.showView), for: .touchUpInside)
        self.view.addSubview(btn)
        
       
       
        sortView = SortView.init(frame: CGRect.init(x: tempWith, y: 180, width: 300, height: 400))
        sortView.arr = arr
        self.view.addSubview(sortView)
        
        timeLabel = UILabel.init(frame: CGRect.init(x: 0, y: 600, width: screenWith, height: 40))
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = UIColor.orange
        timeLabel.textAlignment = .center
        self.view.addSubview(timeLabel)
    }
    
    func showView() {
        
        if isSorting {
            return
        }
        
        let actionVC = UIAlertController.init(title: "排序方式", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let titleArr = ["冒泡排序","选择排序","插入排序","堆排序","归并排序","快速排序","系统排序"]
        
        for (index,title) in titleArr.enumerated() {
            let action = UIAlertAction.init(title: title, style: .destructive, handler: { (actionBlock) in
                self.timeLabel.text = "\(title)所需要的时间是:0s"
                self.start(index: index)
                })
            actionVC.addAction(action)
        }
        
        actionVC.addAction(UIAlertAction.init(title: "取消", style:.cancel, handler: nil))
        self.present(actionVC, animated: true, completion: nil)
        
       
    }
    
    func start(index: Int) {
       isSorting = true
       var tempArr = arr
        timer = Timer.scheduledTimer(withTimeInterval: 0.003, repeats: true, block: { [weak self] (timer) in
            if let weakSelf = self {
               
                DispatchQueue.main.async {
                    weakSelf.sortView.arr = tempArr
                     signal.signal()
                }
            }
        })
        signal = DispatchSemaphore(value:0)
        DispatchQueue.global().async {
            let start = mach_absolute_time()
            var str = ""
            switch index {
            case SortType.bubbleSort.rawValue:
                tempArr.bubbleSort()
                str = "冒泡排序"
            case SortType.selectSort.rawValue:
                tempArr.selectSort()
                str = "选择排序"
            case SortType.insertionSort.rawValue:
                
                tempArr.insertionSort()
                str = "插入排序"
            case SortType.heapSort.rawValue:
                tempArr.heapSort()
                str = "堆排序"
            case SortType.mergeSort.rawValue:
                tempArr.mergeSort()
                str = "归并排序"
            case SortType.qkSort.rawValue:
                tempArr.qkSort(left: 0, right: self.arr.count - 1)
                str = "快速排序"
            case SortType.sort.rawValue:
            _ = tempArr.sort()
                str = "系统排序"
            default:
                ()
            }
            let end = mach_absolute_time()
            DispatchQueue.main.async {
                self.timeLabel.text = "\(str)所需要的时间是:\(pow(10, -9)*(Double)(end-start))s"
                self.sortView.arr = tempArr
            }
            print("\(str)所需要的时间是:\(pow(10, -9)*(Double)(end-start))s")
            self.timer.invalidate()
            self.timer = nil
            self.isSorting = false
        }
        
       
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
