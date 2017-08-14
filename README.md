# SortSwift

## swift中的排序算法总结

* 冒泡排序
* 选择排序
* 快速排序
* 插入排序
* 堆排序
* 归并排序
* 系统排序

我们将这几种数组排序写进Array的分类里面方便调用

### 冒泡排序

算法步骤

1．比较相邻的元素。如果第一个比第二个大，就交换他们两个。

2．对每一对相邻元素作同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数。

3．针对所有的元素重复以上的步骤，除了最后一个。

4.持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较。



``` swift
//冒泡排序
    mutating  func bubbleSort() {
        for i in 0..<self.count {
            for j in 0..<self.count - 1 - i {
                if max(self[j], self[j+1]){
                    (self[j],self[j+1]) = (self[j+1],self[j])
                }
            }
        }
       
    }

```

算法原理图
 
![maopao gif](http://img.blog.csdn.net/20170330162438270?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 选择排序

算法步骤

设数组为a[0…n-1]。

1.初始时，数组全为无序区为a[0..n-1]。令i=0

2.在无序区a[i…n-1]中选取一个最小的元素，将其与a[i]交换。交换之后a[0…i]就形成了一个有序区。

3.i++并重复第二步直到i==n-1。排序完成


``` swift
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
        }
        
    }

```
算法原理图
 
![xuan_ze gif](http://img.blog.csdn.net/20170330164137741?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 快速排序

算法步骤

1.设置两个变量i、j，排序开始的时候：i=0，j=N-1；

2.以第一个数组元素作为关键数据，赋值给key，即key=A[0]；

3.从j开始向前搜索，即由后开始向前搜索(j--)，找到第一个小于key的值A[j]，将A[j]和A[i]互换；

4.从i开始向后搜索，即由前开始向后搜索(i++)，找到第一个大于key的A[i]，将A[i]和A[j]互换；

5.重复第3、4步，直到i=j；


``` swift
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
        }
        self[i] = temp
        qkSort(left: left,right: i-1)
        qkSort(left: i+1, right: right)
        
    }

```
算法原理图
 
![kuai_shu gif](http://img.blog.csdn.net/20170330163202690?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 插入排序

算法步骤

设数组为a[0…n-1]。

1.初始时，a[0]自成1个有序区，无序区为a[1..n-1]，令i=1；

2.将a[i]并入当前的有序区a[0…i-1]中形成a[0…i]的有序区间；

3.i++并重复第二步直到i==n-1。排序完成。

``` swift
  //插入排序
    mutating func insertionSort() {
        for index in 1..<self.count {
            var newArrCount = index - 1
            let keyArr = self[index]
            while newArrCount >= 0 && self[newArrCount] > keyArr {
                self[newArrCount+1] = self[newArrCount]
                newArrCount -= 1
            }
            self[newArrCount+1] = keyArr
        }
    }

```

算法原理图
 
![cha_ru gif](http://img.blog.csdn.net/20170330162544475?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 堆排序

算法步骤

1.先将初始文件R[1..n]建成一个大根堆，此堆为初始的无序区；

2.再将关键字最大的记录R[1]（即堆顶）和无序区的最后一个记录R[n]交换，由此得到新的无序区R[1..n-1]和有序区R[n]，且满足R[1..n-1].keys≤R[n].key；

3.由于交换后新的根R[1]可能违反堆性质，故应将当前无序区R[1..n-1]调整为堆。然后再次将R[1..n-1]中关键字最大的记录R[1]和该区间的最后一个记录R[n-1]交换，由此得到新的无序区R[1..n-2]和有序区R[n-1..n]，且仍满足关系R[1..n-2].keys≤R[n-1..n].keys，同样要将R[1..n-2]调整为堆。；

……

直到无序区只有一个元素为止。

``` swift
  //堆排序
    mutating func heapSort() {
        //建立满足条件的堆
        func heapAdjust(index:Int,length:Int) {
            var temp = index
            if 2*index + 1 < length && !max(self[index], self[2*index+1]){
                temp = 2*index + 1
                
            }
            if 2*index + 2 < length && !max(self[temp] , self[2*index + 2]) {
                temp = 2*index + 2
                
            }
            if index != temp {
                (self[temp],self[index]) = (self[index],self[temp])
                heapAdjust(index: temp, length: length)
               
            }
            
        }
        
        //先建立个堆
        var length = self.count
        var index = length/2 - 1
        while index >= 0 {
            heapAdjust(index: index, length: length)
            index -= 1
        }
        
        length = self.count - 1
        var nextCount = length
        //调整堆
        for _ in 0..<self.count - 1 {
            (self[0],self[nextCount]) = (self[nextCount],self[0])
            heapAdjust(index: 0, length: nextCount)
            nextCount -= 1
            
        }
        
    }

```
算法原理图
 
![dui gif](http://img.blog.csdn.net/20170330163005611?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 归并排序

算法步骤

1.比较a[i]和a[j]的大小，若a[i]≤a[j]，则将第一个有序表中的元素a[i]复制到r[k]中，并令i和k分别加上1；

2.否则将第二个有序表中的元素a[j]复制到r[k]中，并令j和k分别加上1；

3.如此循环下去，直到其中一个有序表取完，然后再将另一个有序表中剩余的元素复制到r中从下标k到下标t的单元。


``` swift
 //归并排序
    mutating func mergeSort() {
        var temArr = self
        //合并数组
        func mergingArr(_ startIndex: Int,_ midIndex:Int,_ lastIndex:Int) {
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
            }
            
        }
        //分离数组
        func separateArr(_ startIndex: Int, _ endIndex: Int) {
            if startIndex < endIndex {
                let mid = (startIndex + endIndex)/2
                separateArr(startIndex, mid)
                separateArr(mid+1, endIndex)
                mergingArr(startIndex, mid, endIndex)
            }
        }
        
        separateArr(0, self.count-1)
        
    }

```

算法原理图
 
![gui_bing gif](http://img.blog.csdn.net/20170330163116892?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 系统方法排序（sort）

  sort方法在与其他方法作比较时，无论是运行次数还是效率都是最优的，看下他的运行时间的效果图吧（由于看不到方法怎么实现的，所以无法演示原理）
  
  
  
![sort png](http://img.blog.csdn.net/20170330163248359?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

### 几种排序算法比较

如下图所示，分别从时间复杂度、空间复杂度和稳定性来比较。

![tubiao png](http://img.blog.csdn.net/20170330163625865?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdGlhbmppZm91/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)




### 注意

* swift中数组在改变数组内元素值时，如果是调用方法改变数组内元素，则无法监听
*  swift中在调用方法改变数组内元素值时，方法体中如果再嵌套一个方法改变这个数组值时则这个数组的地址会改变当整个方法结束时，才会把改变了地址的数组赋值给原来地址的数组。

### 最后

点击观看[完整代码地址](https://github.com/tianjifou/SortSwift.git)

（**转载请说明出处，编写代码不易如对您有用请点赞，谢谢支持！**）






