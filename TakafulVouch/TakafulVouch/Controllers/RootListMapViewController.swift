//
//  RootListMapViewController.swift
//  Vouch365
//
//  Created by Veer Suthar on 3/24/17.
//  Copyright © 2017 Veer Suthar. All rights reserved.
//

import UIKit

class RootListMapViewController: UIViewController , FilterViewDelegate, UITextFieldDelegate {
  
  @IBOutlet weak var filterView: FilterView!
  @IBOutlet weak var collection_info: UICollectionView!
  
  var array: Array <ItemListingMapViewController> = Array()
  
  @IBOutlet weak var searchBae: UITextField!
  var array_nav = Array<String>()
  var array_cat = ["Food & Drinks","Salon & Spa","Leisure","Health Care","Retail & Services","Travel"]
  
  var nextScene: ItemListingMapViewController!
  var titleOfController : String!
  var argumentToServer : String!
  
  var cat : Category!
  var update : UIButton = UIButton()
  var voucherFromHome : Voucher = Voucher()
  var arrayOffer_all: Array<Category>! = Array<Category>()
  var arrayOffer_new: Array<Category>! = Array<Category>()
  var arrayOffer_delivery: Array<Category> = Array<Category>()
  var arrayOffer_monthly: Array<Category>! = Array<Category>()
  
  
  var selectedCategory : String = ""
  
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
	if #available(iOS 13.0, *) {
		overrideUserInterfaceStyle = .light
	} else {
		
	}
    if voucherFromHome.linktype == "tab"{
      self.selectedCategory = voucherFromHome.tab!
    }
    else {
      self.selectedCategory = "all"
    }
    
    
    self.searchBae.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    if titleOfController == "Food & Drinks" {
      array_nav = ["ALL OFFERS","NEW","DELIVERY","MONTHLY"]
    }
    else {
      array_nav = ["ALL OFFERS","NEW","MONTHLY"]
    }
    //array_nav = ["ALL OFFERS","NEW","MONTHLY"]
    
    collection_info.dataSource = self
    collection_info.delegate = self
    
    title = titleOfController
    nextScene.titleOfView = titleOfController
    /*
     var type: String = ""
     
     if indexPath.row == 0 {
     type = "my"
     }else if indexPath.row == 1 {
     type = "new"
     }else if indexPath.row == 2 {
     type = "premium"
     }else if indexPath.row == 3 {
     type = "monthly"
     }
     */
    
    fetchHomeAllOffers(categoryType: "my", categoryType2:argumentToServer)
    fetchHomeNew(categoryType: "new", categoryType2:argumentToServer)
    fetchHomeDelivery(categoryType: "premium", categoryType2:argumentToServer)
    fetchHomeMonthly(categoryType: "monthly", categoryType2:argumentToServer)
    
    setupNavigation()
    
    filterView.frame = CGRect(x: 0, y: self.view.frame.size.height/3, width: self.view.frame.size.width, height: self.view.frame.size.height/3 * 2)
	//sdk commit
		//AppDelegate.getInstatnce().window?.addSubview(filterView)
		//AppDelegate.getInstatnce().window?.bringSubviewToFront(filterView)
	//sdk change
	
	
	self.view.addSubview(filterView)
	self.view.bringSubviewToFront(filterView)
    filterView.setCategory(category: titleOfController)
    filterView.filterDelegate = self
    filterView.isHidden = true
    
  }
	@objc func textFieldDidChange(_ textField: UITextField) {
    var filteredArray : Array<Category> = Array<Category>()
    if textField.text! != "" {
      if self.selectedCategory == "new" {
        filteredArray = self.arrayOffer_new.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      else if self.selectedCategory == "all" {
        filteredArray = self.arrayOffer_all.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      else if self.selectedCategory == "delivery" {
        filteredArray = self.arrayOffer_delivery.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      else if self.selectedCategory == "monthly" {
        filteredArray = self.arrayOffer_monthly.filter {
          return ($0.name ?? "").range(of: textField.text!, options: [.caseInsensitive]) != nil
        }
      }
      print("Array is \(filteredArray.count)")
      
    }
    else {
      if self.selectedCategory == "new" {
        filteredArray = self.arrayOffer_new
      }
      else if self.selectedCategory == "all" {
        filteredArray = self.arrayOffer_all
      }
      else if self.selectedCategory == "delivery" {
        filteredArray = self.arrayOffer_delivery
      }
      else if self.selectedCategory == "monthly" {
        filteredArray = self.arrayOffer_monthly
      }
      
    }
    
    print("Array is \(filteredArray.count)")
    //        }
    self.nextScene.array_list = filteredArray
    self.nextScene.tableview_category.reloadData()
    
  }
  
  
  func removeFilterView(){
    
    filterView.isHidden = true
    
    
    
    //        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveLinear, animations: {
    //
    //            self.filterView.frame = CGRect(x: 0, y: self.filterView.frame.origin.y, width: self.view.frame.size.width, height: 0)
    //
    //        }, completion: { Void in
    //          //  self.filterView.isHidden = true
    //            AppDelegate.getInstatnce().window?.bringSubview(toFront: self.filterView)
    //
    //
    //        })
    
    
    
  }
  
  
  @IBAction func didTapOnFilter(_ sender: Any) {
    
    
    
    //    filterView.frame = CGRect(x: 0, y: self.view.frame.size.height/3, width: self.view.frame.size.width, height: self.view.frame.size.height/3 * 2)
    
    //        UIView.Animate(2.0, 0.0,
    //                       UIViewAnimationOptions.CurveLinear,
    //                       () =>
    //                        {
    //                            view.BackgroundColor = UIColor.Blue;
    //                            var height = 100;
    //                            view.Frame = new CGRect(View.Frame.Left, view.Frame.Y - height , view.Superview.Frame.Right, height);
    //            },
    //                       () =>
    //                        {
    //                            // anim done
    //            }
    //        );
    
    
    //  AppDelegate.getInstatnce().window?.bringSubview(toFront:self.filterView)
    self.filterView.isHidden = false
    //        let height = self.view.frame.size.height/3 * 2
    //
    //        UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveLinear, animations: {
    //
    //            self.filterView.frame = CGRect(x: 0, y: self.filterView.frame.origin.y, width: self.view.frame.size.width, height: height)
    //
    //        }, completion: { Void in
    //
    //
    //        })
    
    
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    
  }
  
  func fetchHomeAllOffers(categoryType : String, categoryType2: String){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          //self.arrayOffer_all.add(self.cat)
          self.arrayOffer_all.append(self.cat)
          
        }
        if self.selectedCategory == "all"{
          self.nextScene.array_list = self.arrayOffer_all
          self.nextScene.tableview_category.reloadData()
        }
        
      }else{
        print("Failed")
      }
    }
  }
  
  
  
  
  func fetchHomeNew(categoryType : String, categoryType2: String){

    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          self.arrayOffer_new.append(self.cat)
          
        }
      }else{
        print("Failed")
      }
      if self.selectedCategory == "new"{
        self.nextScene.array_list = self.arrayOffer_new
        self.nextScene.tableview_category.reloadData()
      }
      
    }
  }
  
  func fetchHomeDelivery(categoryType : String, categoryType2: String){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          self.arrayOffer_delivery.append(self.cat)
          
        }
      }else{
        print("Failed")
      }
      if self.selectedCategory == "delivery"{
        self.nextScene.array_list = self.arrayOffer_delivery
        self.nextScene.tableview_category.reloadData()
      }
      
    }
  }
  
  func fetchHomeMonthly(categoryType : String, categoryType2: String){
    
    Utilities.showLoader(controller: self)
    
    ServiceWrapper.getHomeService(cat: categoryType, cat2: categoryType2) {
      (success, response) in
      
      if success{
        for item in response.value(forKey: "data") as! Array<Any>{
          let dict: NSDictionary = item as! NSDictionary
          print(dict)
          
          self.cat  = Category()
          self.cat.setDataFromServer(dict: dict)
          self.arrayOffer_monthly.append(self.cat)
        }
        
      }else{
        print("Failed")
        
      }
      if self.selectedCategory == "monthly" {
        self.nextScene.array_list = self.arrayOffer_monthly
      }
    }
  }
  
  
  
  func setupNavigation() {
    
    let label = UILabel(frame: CGRect(x:0, y:0, width:self.view.frame.size.width, height:50))
    label.center = self.view.center
    label.backgroundColor = UIColor.clear
    label.numberOfLines = 2
    label.font = UIFont(name: "Helvetica-Light", size: 13)!
    label.textAlignment = .center
    label.textColor = UIColor.black

    
    label.text = "\(titleOfController!)\nin \(User.getCity().capitalizingFirstLetter())"
    
    let titleView = UIView(frame: CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(100), height: CGFloat(50)))
    label.frame = titleView.bounds
    titleView.addSubview(label)
    
    self.navigationItem.titleView = titleView
    
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    
    self.navigationController?.navigationBar.barTintColor = UIColor.white
    self.navigationController?.navigationBar.isTranslucent = false
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    
    self.tabBarController?.tabBar.barTintColor = UIColor.white
    self.tabBarController?.tabBar.isTranslucent = false
    self.tabBarController?.tabBar.backgroundImage = UIImage()
    self.tabBarController?.tabBar.shadowImage = UIImage()
    
	self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Light", size: 13)!]
    
    let backbutton = UIButton(type: .custom)
    backbutton.setImage(UIImage(named: "back"), for: .normal)
    backbutton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
	backbutton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    backbutton.addTarget(self, action: #selector(RootListMapViewController.backView), for: .touchUpInside)
    let backbarbutton = UIBarButtonItem(customView: backbutton)
    
    self.navigationItem.setLeftBarButton(backbarbutton, animated: true)
    
    update = UIButton(type: .custom)
    update.setTitle("Map", for: .normal)
    update.setTitleColor(.gray, for: .normal)
    update.titleLabel!.font =  UIFont(name: "HelveticaNeue-Thin", size: 16)
    update.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
	update.titleEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 0, right: -35);
    update.addTarget(self, action: #selector(RootListMapViewController.updateView), for: .touchUpInside)
    let updatebarbutton = UIBarButtonItem(customView: update)
    self.navigationItem.setRightBarButton(updatebarbutton, animated: true)
  }
  
  
	@objc func backView() {
    filterView.isHidden = true
    print("back button pressed")
    let _ = self.navigationController?.popViewController(animated: true)
  }
  
	@objc func updateView() {
    
    if update.currentTitle == "Map" {
      update.setTitle("List", for: .normal)
      User.setViewName(viewName: "Map")
      nextScene.showMap()
    }else {
      update.setTitle("Map", for: .normal)
      User.setViewName(viewName: "List")
      nextScene.showList()
    }
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if segue.identifier == "sw_detailmap" {
      nextScene = segue.destination as! ItemListingMapViewController
    }
  }
}

extension RootListMapViewController : UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let height: CGFloat = 40// 40
    var width: CGFloat = 200
    
    //we are just measuring height so we add a padding constant to give the label some room to breathe!
    let padding: CGFloat = 40
    
    //estimate each cell's height
    if let text = array_nav[indexPath.row] as? String  {
      width = estimateFrameForText(text: text).width + padding
    }
    
    return CGSize(width: width, height: height)
    
  }
  
  private func estimateFrameForText(text: String) -> CGRect {
    //we make the height arbitrarily large so we don't undershoot height in calculation
    let width: CGFloat = 350
    
    let size = CGSize(width: width, height: 20)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
	let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.light)]
    
    return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return array_nav.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailListCollectionViewCell", for: indexPath) as! DetailListCollectionViewCell
    cell.label_headertitle.text = array_nav[indexPath.row]
    
    if self.selectedCategory == "monthly" && indexPath.row == array_nav.count - 1{
      cell.view_bottombar.isHidden = false
    }
    else if self.selectedCategory == "all" && (indexPath.row == 0) {
      cell.view_bottombar.isHidden = false
    }
    else if self.selectedCategory == "new" && indexPath.row == 1{
      cell.view_bottombar.isHidden = false
    }
    else if self.selectedCategory == "delivery" && indexPath.row == 2 {
      cell.view_bottombar.isHidden = false
    }
    else {
      cell.view_bottombar.isHidden = true
    }
    
    
    return cell
  }
}

extension RootListMapViewController: UICollectionViewDelegate {
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    filterView.isHidden = true
    
    if indexPath.row == 0 {
      self.nextScene.array_list = arrayOffer_all
      self.selectedCategory = "all"
      print("array offer: \(arrayOffer_all)")
    }else if indexPath.row == 1 {
      self.nextScene.array_list = arrayOffer_new
      self.selectedCategory = "new"
      print("array new: \(arrayOffer_new)")
      
    }else if indexPath.row == 2 {
      self.nextScene.array_list = arrayOffer_delivery
      self.selectedCategory = "delivery"
      print("array Delivery: \(arrayOffer_delivery)")
      
    }else if indexPath.row == 3 {
      self.selectedCategory = "monthly"
      self.nextScene.array_list = arrayOffer_monthly
      print("array Monthly: \(arrayOffer_monthly)")
      
    }
    
    
    if User.getViewName() == "List"{
      self.nextScene.findDistance()
      self.nextScene.tableview_category.reloadData()
    }else{
      self.nextScene.showMap()
    }
    let cell = collectionView.cellForItem(at: indexPath) as! DetailListCollectionViewCell
    for cell in collectionView.visibleCells as! [DetailListCollectionViewCell] {
      cell.view_bottombar.isHidden = true
    }
    
    cell.view_bottombar.isHidden = false
    //    fetchHome(categoryType: type, categoryType2:argumentToServer)
  }
}

