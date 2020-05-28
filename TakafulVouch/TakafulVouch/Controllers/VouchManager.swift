//
//  VouchManager.swift
//  ActionSheetPicker-3.0
//
//  Created by Shairjeel Ahmed on 23/01/2020.
//

import Foundation


public class VouchManager {
	public init() {}
	
	/*public func GetVouchNavigationController() -> UINavigationController {
		let Vc = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
		Vc.modalPresentationStyle = .fullScreen
		return UINavigationController(rootViewController: Vc)
	}*/
	
	public  func getVouchNavigaionController(unique_param: String,token:String,
									completionHandler:
		@escaping (_ success : Bool, _ navigationController : UINavigationController? , _ errorDes:NSDictionary?) -> Void) {
		
		let requestObject: NSDictionary = ["unique_param":unique_param,"token":token]
		ServiceWrapper.psoSdkCall(requestObject: requestObject) {
			(success, response) in
			if success == true{
				
				User.setUserID(user_ID:unique_param)
				let Vc = UIStoryboard(name: "Main-Pso", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
				Vc.modalPresentationStyle = .fullScreen
				let navVc =  UINavigationController(rootViewController: Vc)
				completionHandler(true,navVc,nil)
			}else{
				completionHandler(false,nil,response)
			}
		}
	}
}





