//
//  PersonProfile.swift
//  PersonProfileDocDemo
//
//  Created by 戴植锐 on 2018/3/11.
//  Copyright © 2018年 戴植锐. All rights reserved.
//

import Cocoa

let kPersonKey: String = "PersonKey"

class PersonProfile: NSObject, NSCoding {
    // 添加 @objc 用于动态绑定
    @objc var name: String?
    @objc var age: NSInteger = 0
    @objc var address: String?
    @objc var mobile: String?
    @objc var image: NSImage? = NSImage(named: NSImage.Name.user)
    
    func encode(with aCoder: NSCoder) {
        print("encodeWithCoder")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.age, forKey: "age")
        aCoder.encode(self.address, forKey: "address")
        aCoder.encode(self.mobile, forKey: "mobile")
        aCoder.encode(self.image, forKey: "image")
    }
    // 便利构造器
    // 从 aDecoder 获取数据来初始化对象实例
    required convenience init?(coder aDecoder: NSCoder) {
        print("decodeWithCoder")
        self.init()
        let name = aDecoder.decodeObject(forKey: "name") as? String
        self.name = name
        
        let age = aDecoder.decodeInteger(forKey: "age") as NSInteger
        self.age = age
        
        let address = aDecoder.decodeObject(forKey: "address") as? String
        self.address = address
        
        let mobile = aDecoder.decodeObject(forKey: "mobile") as? String
        self.mobile = mobile
        
        let image = aDecoder.decodeObject(forKey: "image") as? NSImage
        self.image = image
    }
    // 从 Data 数据转换为对象实例
    static func profileFrom(_ data: Data) -> PersonProfile {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        let aPerson = unarchiver.decodeObject(forKey: kPersonKey) as! PersonProfile
        return aPerson
    }
    // 采用对象的 Archive 机制将属性数据转换为 Data 数据
    func docData() -> Data {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(self, forKey: kPersonKey)
        archiver.finishEncoding()
        return data as Data
    }
    // 将 JSON 文件数据输入到对象实例
    func updata(with jsonData: Data?) {
        let object = try? JSONSerialization.jsonObject(with: jsonData!, options: [.allowFragments])
        guard let dataDictionary = object as? Dictionary<String, AnyObject>
            else {
                return
        }
        self.name = dataDictionary["name"] as? String
        self.age = dataDictionary["age"] as! NSInteger
        self.address = dataDictionary["address"] as? String
        self.mobile = dataDictionary["mobile"] as? String
    }
    // 将对象实例输出为 JSON 文件数据
    func jsonData() -> Data? {
        var dataDictionary = Dictionary<String, Any>()
        if let name = self.name {
            dataDictionary["name"] = name
        }
        if self.age > 0 {
            dataDictionary["age"] = age
        }
        if let address = self.address {
            dataDictionary["address"] = address
        }
        if let mobile = self.mobile {
            dataDictionary["mobile"] = mobile
        }
        let data = try? JSONSerialization.data(withJSONObject: dataDictionary, options: [.prettyPrinted])
        return data
    }
}
