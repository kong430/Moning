//
//  NotifyCollectionViewController.swift
//  Moning
//
//  Created by 이제인 on 2020/06/22.
//  Copyright © 2020 이제인. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        NotifyThings.needNotify.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotifyCell", for: indexPath) as! NotifyCollectionViewCell
        let needNotify = NotifyThings.needNotify[indexPath.row]
        cell.notifyImage.image = UIImage(named: needNotify.name+".png")
        return cell
    }
    
    // 클릭하면 alert
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var cell : UICollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath)!

        let needNotify = NotifyThings.needNotify[indexPath.row]
        let alert = UIAlertController(title: "", message: needNotify.text, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: false)
    }
    
    func updateNotify() {
        // init
        for i in 0...6 {
            NotifyThings.notifyModels[i].flag = false
            if NotifyThings.notifyModels[i].name != "perfect" {
                NotifyThings.notifyModels[i].text = ""
            }
        }
        NotifyThings.needNotify.removeAll()
        
        // 손풍기: 최고기온 28도 이상
        var hotText = ""
        if MainWeather.maxTemp != "" {
            let maxTemp = Double(MainWeather.maxTemp)!
            if 28.0 <= maxTemp {
                NotifyThings.notifyModels[0].flag = true
                hotText += "최고기온이 "+MainWeather.maxTemp+"입니다.\n"
            }
        }
        NotifyThings.notifyModels[0].text = hotText
        
        // 핫팩, 목도리: 최저기온 5도 이하
        var coldText = ""
        if MainWeather.minTemp != "" {
            let minTemp = Double(MainWeather.minTemp)!
            if minTemp <= 5.0 {
                NotifyThings.notifyModels[1].flag = true
                NotifyThings.notifyModels[2].flag = true
                coldText += "최저기온이 "+MainWeather.minTemp+"입니다.\n"
            }
        }
        NotifyThings.notifyModels[1].text = coldText
        NotifyThings.notifyModels[2].text = coldText
        
        // 마스크: 미세먼지||초미세먼지 나쁨||매우나쁨
        var dustText = ""
        if MainWeather.pm10Val != "" {
            let dust10 = Int(MainWeather.pm10Val)!
            if 81 <= dust10 {
                NotifyThings.notifyModels[3].flag = true
                dustText += "미세먼지 지수가 "+MainWeather.pm10State+"입니다.\n"
            }
        }
        if MainWeather.pm25Val != "" {
            let dust25 = Int(MainWeather.pm25Val)!
            if 36 <= dust25 {
                NotifyThings.notifyModels[3].flag = true
                dustText += "초미세먼지 지수가 "+MainWeather.pm25State+"입니다.\n"
            }
        }
        NotifyThings.notifyModels[3].text = dustText
        
        
        // 선크림,선글라스: 자외선 높음||매우높음||위험
        var uvText = ""
        if MainWeather.UVlight != "" {
            let uv = Int(MainWeather.UVlight)!
            if 6 <= uv {
                NotifyThings.notifyModels[4].flag = true
                NotifyThings.notifyModels[5].flag = true
                uvText += "자외선 지수가 "+MainWeather.UVlightState+"입니다.\n"
            }
        }
        NotifyThings.notifyModels[4].text = uvText
        NotifyThings.notifyModels[5].text = uvText
            
        
        // 우산: 오늘 예보중에 강수확률 0아닌거 하나라도 있으면
        var rainText = ""
        if MainWeather.rainProb06 != "0" {
            NotifyThings.notifyModels[6].flag = true
            rainText += "오전 6시 비올 확률: "+MainWeather.rainProb06+"%\n"
        }
        if MainWeather.rainProb09 != "0" {
            NotifyThings.notifyModels[6].flag = true
            rainText += "오전 9시 비올 확률: "+MainWeather.rainProb09+"%\n"
        }
        if MainWeather.rainProb12 != "0" {
            NotifyThings.notifyModels[6].flag = true
            rainText += "오후 12시 비올 확률: "+MainWeather.rainProb12+"%\n"
        }
        if MainWeather.rainProb15 != "0" {
            NotifyThings.notifyModels[6].flag = true
            rainText += "오후 3시 비올 확률: "+MainWeather.rainProb15+"%\n"
        }
        if MainWeather.rainProb18 != "0" {
            NotifyThings.notifyModels[6].flag = true
            rainText += "오후 6시 비올 확률: "+MainWeather.rainProb18+"%\n"
        }
        if MainWeather.rainProb21 != "0" {
            NotifyThings.notifyModels[6].flag = true
            rainText += "오후 9시 비올 확률: "+MainWeather.rainProb21+"%\n"
        }
        NotifyThings.notifyModels[6].text = rainText
        
        
        // 준비물 없을 때
        for i in NotifyThings.notifyModels {
            if i.flag {
                NotifyThings.needNotify.append(i)
            }
        }
        if NotifyThings.needNotify.count == 0 {
            NotifyThings.needNotify.append(NotifyThings.specialModel)
        }
        
        DispatchQueue.main.async {
            self.notifyCollectionView.reloadData()
        }
        
    }
    
    
}
