//
//  HXHLoadHtmlVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/7/27.
//

import UIKit
import WebKit
import Masonry

class HXHLoadHtmlVC: UIViewController {
    lazy var web: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfig)
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWeb()
    }
    
    
    //MARK: - base UI
    let str = """
        <!DOCTYPE html>
        <html lang="en">
        
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
            <title>Title</title>
            <style>
                * {
                    padding: 0;
                    margin: 0;
                }
        
                body {
                    width: 100%;
                    height: 100%;
                    padding: 10px 25px;
                    box-sizing: border-box;
                    font-size: 17px;
                }
                .place-box {
                    margin-top: 10px;
                }
                .title {
                    font-weight: bold;
                }
                .pic {
                    width: 100%;
                    margin-top: 5px;
                }
                .pic > img {
                    width: 40%;
                }
                .text {
                    margin: 10px 0;
                }
                .text >span {
                    color: #333333;
                }
                .text>h3 {
                    padding: 10px 0;
                }
                .list {
                    margin: 10px 0;
                }
                .list > ul {
                    padding-left:20px;
                    margin: 10px 0;
                }
                .list > ul>li{
                    margin: 5px 0;
                    font-size: 16px;
                    color: #333333;
                }
        
        
            </style>
        </head>
        
        <body>
        <div>
            <h2>About this place</h2>
            <div class="place-box">
                <div class="title">Last Mile</div>
                <div class="pic">
                    <img src="http://dqoislk9v1t0x.cloudfront.net/tp/review/null/202101-winter-snowroad.jpg" alt="">
                </div>
            </div>
            <div class="place-box">
                <div class="title">Instruction</div>
                <div class="pic">
                    <img src="http://dqoislk9v1t0x.cloudfront.net/tp/review/null/202101-winter-snowroad.jpg" alt="">
                </div>
            </div>
            <div class="text-box">
                <div class="text">
                    <h3>Operation Hours</h3>
                    <span>Monday to Friday 10am to 8pm</span>
                </div>
                <div class="list">
                    <h3>Parking</h3>
                    <ul>
                        <li>Overnight parking</li>
                        <li>Secured parking</li>
                    </ul>
                </div>
                <div class="list">
                    <h3>Parking</h3>
                    <ul>
                        <li>Overnight parking</li>
                        <li>Secured parking</li>
                    </ul>
                </div>
                <div class="list">
                    <h3>Parking</h3>
                    <ul>
                        <li>Overnight parking</li>
                        <li>Secured parking</li>
                    </ul>
                </div>
            </div>
        </div>
        </body>
        
        </html>
        """
    func setupWeb() {
        view.addSubview(web)
        web.mas_makeConstraints { make in
            make?.edges.equalTo()
        }
        web.loadHTMLString(str, baseURL: nil)
    }
    
}
