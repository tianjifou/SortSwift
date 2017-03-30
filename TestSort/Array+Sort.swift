//
//  Array+Sort.swift
//  TestSort
//
//  Created by 天机否 on 17/3/28.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

import Foundation
import UIKit

enum SortType:Int {
    //["冒泡排序","选择排序","插入排序","堆排序","归并排序","快速排序","系统排序"]
    case bubbleSort = 0,selectSort,insertionSort,heapSort,mergeSort,qkSort,sort
}


extension Array where Element: Comparable {
    func max<T: Comparable>(_ a:T,_ b:T) -> Bool{
        return a > b ? true : false
    }
    //冒泡排序
    mutating  func bubbleSort() {
      
        for i in 0..<self.count {
            for j in 0..<self.count - 1 - i {
                if max(self[j], self[j+1]){
                    (self[j],self[j+1]) = (self[j+1],self[j])
                    signal.wait()
                }
            }
        }
        
    }
    //选择排序（选择最小元素）
    mutating func selectSort() {
        for i in 0..<self.count {
            var min = i
            for j in i+1..<self.count {
                if max(self[min], self[j]){
                    min = j
                }
            }
            (self[min],self[i]) = (self[i],self[min])
            signal.wait()
        }
        
    }
    //快速排序
    mutating func qkSort(left:Int,right:Int) {
        
        if left >= right {
            return
        }
        var i = left
        var j = right
        let temp = self[left]
        while i < j {
            while i<j && temp <= self[j] {
                j -= 1
            }
            self[i] = self[j]
            while i<j && temp >= self[i] {
                i += 1
            }
            self[j] = self[i]
            signal.wait()
        }
        self[i] = temp
        signal.wait()
        qkSort(left: left,right: i-1)
        qkSort(left: i+1, right: right)
        
    }
    
  
    
    //堆排序
    mutating func heapSort() {
        
       
        var length = self.count
        var index = length/2 - 1
        while index >= 0 {
            heapAdjust(index: index, length: length)
            index -= 1
        }
        
        length = self.count - 1
        var nextCount = length
        for _ in 0..<self.count - 1 {
            (self[0],self[nextCount]) = (self[nextCount],self[0])
            signal.wait()
            heapAdjust(index: 0, length: nextCount)
            nextCount -= 1
            
            
        }
       
    }
    private mutating func heapAdjust(index:Int,length:Int) {
        var temp = index
        if 2*index + 1 < length && !max(self[index], self[2*index+1]){
            temp = 2*index + 1
            
        }
        if 2*index + 2 < length && !max(self[temp] , self[2*index + 2]) {
            temp = 2*index + 2
            
        }
        if index != temp {
            (self[temp],self[index]) = (self[index],self[temp])
            signal.wait()
            
            heapAdjust(index: temp, length: length)
            
        }
        
    }
    //插入排序
    mutating func insertionSort() {
        for index in 1..<self.count {
            var newArrCount = index - 1
            let keyArr = self[index]
            while newArrCount >= 0 && self[newArrCount] > keyArr {
                self[newArrCount+1] = self[newArrCount]
                signal.wait()
                newArrCount -= 1
            }
            self[newArrCount+1] = keyArr
            signal.wait()
        }
    }
    
    //归并排序
    
    mutating func mergeSort() {
        var temArr = self
      separateArr(0, self.count-1,&temArr)
        
    }
    //合并数组
  private mutating  func mergingArr(_ startIndex: Int,_ midIndex:Int,_ lastIndex:Int,_ temArr:inout[Element]) {
        var i = startIndex
        var j = midIndex + 1
        let k = lastIndex
        let m = midIndex
        var n = 0
        while i <= m&&j <= k {
            
            if max(self[i], self[j]) {
                temArr[n] = self[j]
                j += 1
                n += 1
            }else {
                temArr[n] = self[i]
                i += 1
                n += 1
            }
            
            
        }
        
        while i <= m {
            temArr[n] = self[i]
            i += 1
            n += 1
        }
        
        while j <= k {
            temArr[n] = self[j]
            j += 1
            n += 1
        }
        
        for index in 0..<n {
            self[startIndex + index] = temArr[index]
            signal.wait()
        }
        
    }
    
    //分离数组
    private mutating  func separateArr(_ startIndex: Int, _ endIndex: Int,_ temArr:inout[Element]) {
        if startIndex < endIndex {
            let mid = (startIndex + endIndex)/2
            separateArr(startIndex, mid,&temArr)
            separateArr(mid+1, endIndex,&temArr
            )
            mergingArr(startIndex, mid, endIndex,&temArr)
        }
    }
    
}
