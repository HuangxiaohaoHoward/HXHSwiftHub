//
//  HXHDatabaseVC.swift
//  HXHSwiftHub
//
//  Created by 黄小豪 on 2021/11/24.
//

import UIKit
import FMDB

class HXHDatabaseVC: HXHBaseViewController {
    
    var db: FMDatabase?
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!
    var mark_student: Int?
    var docPath: String?
    static let dbName = "student.sqlite"
    static let tableName = "t_student"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBaseUI()
        baseConfig()
    }
    //MARK: - base UI
    private func setupBaseUI() {
        self.title = "Database"
    }
    private func baseConfig() {
        guard let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last else {
            return
        }
        self.docPath = docPath
        print("\(#function)\ndocpath:\(docPath)")
        mark_student = 1
        let fileName = (docPath as NSString).appendingPathComponent(Self.dbName)
        db = FMDatabase(path: fileName)
        guard db?.open() == true else {
            print("db open failure")
            return
        }
    
        
        print("db open success")
        let sql = """
        CREATE TABLE IF NOT EXISTS \(HXHDatabaseVC.tableName) (
          stuID integer PRIMARY KEY AUTOINCREMENT NOT NULL,
          name text NOT NULL,
          age integer,
          score real,
          school text,
          sex integer(1) NOT NULL DEFAULT(1)
        );
        """
        do {
            let result = try db?.executeUpdate(sql, values: [])
            print("create table result: \(String(describing: result))")
            
            var simpleTokenizer = FMSimpleTokenizer(locale: nil)
            db?.installTokenizerModule()
            FMDatabase.registerTokenizer(simpleTokenizer, withKey: "simple")
            
            let tokenizerSQL = "CREATE VIRTUAL TABLE virtual_t_student USING fts3(name, age, score, school, tokenize=fmdb simple)"
            guard let isTokenizerSUccess = db?.executeUpdate(tokenizerSQL, withArgumentsIn: []),
                  isTokenizerSUccess == true else {
                      print(db?.lastErrorMessage())
                      return
                  }
            print("CREATE VIRTUAL TABLE virtual_t_student success")
            db?.close()
            
        } catch {
            print("create table fail : \(error)")
        }
    }
    @IBAction func addAction(_ sender: UIButton) {
        guard let nameStr = nameTF.text,
              let age = ageTF.text,
              let age2 = Int(age) else {
                  return
              }
        insert(name: nameStr, age: age2)
    }
    
    
    public func insert(name: String, age: Int) {
        if db?.open() == true {
            let sql = """
                
            
            """
            
        } else {
            print("open failure")
        }
        let sql = "insert or update into \(Self.tableName)(name,age) values ('\(name)',\(age))"
        do {
            let result = try db?.executeUpdate(sql, withArgumentsIn: [])
            print("insert result : \(String(describing: result))")
        } catch {
            print("insert error : \(error)")
        }
    }
    func insert(key:String, val:Any) -> Bool {
        if db?.open() == true {
            let sql = """
                insert or update into \(Self.tableName)
                    (\(key))
                    values(\(val))
                );
            """
            
            let result = try db?.executeUpdate(sql, withArgumentsIn: []) ?? false
            print("insert result : \(String(describing: result))")
               
            return result

        } else {
            
            print("open failure")
            return false
        }
    }
}
