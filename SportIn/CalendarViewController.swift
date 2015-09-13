//
//  CalendarViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/24/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//?

import UIKit
import Parse
import MapKit
import CoreLocation

class CalendarViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate{

    @IBOutlet weak var eventsMaps: MKMapView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    
    var itensOnNewEvent = [PFObject]()
    var itensOnPastEvent = [PFObject]()
    var localizacao = [PFGeoPoint]()
    var verificacao = [PFObject]()
    let date = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Wire up search bar delegate so that we can react to button selections
        mySearchBar.delegate = self
        
        
        // Do any additional setup after loading the view.
        // codigo para personalizar o navigationBar
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        var location = CLLocationCoordinate2DMake(48.88182,2.43952)
        
        var span = MKCoordinateSpanMake(0.002, 0.002)
        
        var region = MKCoordinateRegion(center: location, span: span)
        
        eventsMaps.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Pizza"
        annotation.subtitle = "La Casa"
        
        eventsMaps.addAnnotation(annotation)
        
        
        
    }

    
    
    /*
    ==========================================================================================
    Ensure data within the collection view is updated when ever it is displayed
    ==========================================================================================
    */

    
    // Load data into the collectionView when the view appears
    override func viewDidAppear(animated: Bool) {
        loadCollectionViewData()
        loadCollectionViewDataPast()
    }

    
    /*
    ==========================================================================================
    Function for Geo Localization
    ==========================================================================================
    */
    
    
    
    
    /*
    ==========================================================================================
    Fetch data from the Parse platform
    ==========================================================================================
    */
    
    func loadCollectionViewData() {
        
        // Build a parse query object
        var query = PFQuery(className:"Events")
        query.whereKey("Status", containsString: "open")
        query.orderByDescending("createdAt")
        
        // Check to see if there is a search term
        if mySearchBar.text != "" {
            query.whereKey("searchText", containsString: mySearchBar.text.lowercaseString)
        }
        // Fetch data from the parse platform
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            // The find succeeded now rocess the found objects into the events array
            if error == nil {
            // Clear existing event data
            self.itensOnNewEvent.removeAll(keepCapacity: true)
            // Add events objects to our array
            if let objects = objects as? [PFObject] {
                self.itensOnNewEvent = Array(objects.generate())
            }
            // reload our data into the collection view
                self.myTableView.reloadData()
            }
            else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    func loadCollectionViewDataPast() {
        
        // Build a parse query object
        var query = PFQuery(className:"Events")
        query.whereKey("Status", containsString: "close")
        query.orderByDescending("createdAt")
        
        // Check to see if there is a search term
        if mySearchBar.text != "" {
            query.whereKey("searchText", containsString: mySearchBar.text.lowercaseString)
        }
        // Fetch data from the parse platform
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            // The find succeeded now rocess the found objects into the events array
            if error == nil {
            // Clear existing event data
            self.itensOnPastEvent.removeAll(keepCapacity: true)
            // Add events objects to our array
            if let objects = objects as? [PFObject] {
                self.itensOnPastEvent = Array(objects.generate())
            }
            // reload our data into the collection view
            self.myTableView.reloadData()
            }
            else {
                // Log details of the failure
                println("Error: \(error!) \(error!.userInfo!)")
            }
        }
    }
    
    /*
    ==========================================================================================
    UICollectionView protocol required methods
    ==========================================================================================
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return itensOnNewEvent.count
        }
        if section == 1{
            return itensOnPastEvent.count
        }
        if section == 2{
            return searchResults.count
        }
        return 0
    }
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let mycellMaps = tableView.dequeueReusableCellWithIdentifier("cellMaps", forIndexPath: indexPath) as! UITableViewCell
        
        if indexPath.section == 0 {
            
            let valueA = itensOnNewEvent[indexPath.row]["titulo"] as? String
            let valueB = itensOnNewEvent[indexPath.row]["subtitulo"] as? String
            let valueC = itensOnNewEvent[indexPath.row]["LatLong"] as? CLLocationCoordinate2D
            mycellMaps.textLabel?.text = valueA
            mycellMaps.detailTextLabel?.text = valueB
        }
        if indexPath.section == 1{
            let valueAP = itensOnPastEvent[indexPath.row]["titulo"] as? String
            let valueBP = itensOnPastEvent[indexPath.row]["subtitulo"] as? String
            let valueCP = itensOnNewEvent[indexPath.row]["LatLong"] as? CLLocationCoordinate2D
            mycellMaps.textLabel?.text = valueAP
            mycellMaps.detailTextLabel?.text = valueBP
            
        }
        if indexPath.section == 2{
            
            mycellMaps.textLabel?.text = searchResults[indexPath.row]
        }
        
        return mycellMaps
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Novos eventos"
        }
        if section == 1{
            return "Eventos que já aconteceram"
        }
        else{
            return "Resultado de Pesquisa"
        }
    }
    
    /*
    ==========================================================================================
    Segue methods
    ==========================================================================================
    */
    
    
    
    
    
    /*
    ==========================================================================================
    Process Search Bar interaction
    ==========================================================================================
    */
    
    
    var searchResults = [String]()
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        println("Search word = \(searchBar.text)")
        
        var tituloNameQuery = PFQuery(className:"Events")
        tituloNameQuery.whereKey("titulo", containsString: searchBar.text)
        
        var subtituloNameQuery = PFQuery(className:"Events")
        subtituloNameQuery.whereKey("subtitulo", matchesRegex: "(?i)\(searchBar.text)")
        // a regular expression that will match the search word and the value in the Parse class
        // and the comparison will be case insensetive.
        
        var queryFromSearch = PFQuery.orQueryWithSubqueries([tituloNameQuery, subtituloNameQuery])
        
        queryFromSearch.findObjectsInBackgroundWithBlock {
            (resultsFromSearch: [AnyObject]?, error: NSError?) -> Void in
            
            if error != nil {
                var myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle:UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated: true, completion: nil)
                
                return
            }
            
            if let objectsSearch = resultsFromSearch as? [PFObject] {
                
                self.searchResults.removeAll(keepCapacity: false)
                
                for objectFind in objectsSearch {
                    let tituloName = objectFind.objectForKey("titulo") as! String
                    let subtituloName = objectFind.objectForKey("subtitulo") as! String
                    let localizacaoName = tituloName + " " + subtituloName
                    
                    self.searchResults.append(localizacaoName)
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.myTableView.reloadData()
                    self.mySearchBar.resignFirstResponder()
                    
                }
            }
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        mySearchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar)
    {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
        
        
    }
    
    @IBAction func menuButton(sender: AnyObject) {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
    }
    
    @IBAction func refreshButton(sender: AnyObject) {
        mySearchBar.resignFirstResponder()
        mySearchBar.text = ""
        self.searchResults.removeAll(keepCapacity: false)
        self.myTableView.reloadData()
    }
    
    
    /*
    ==========================================================================================
    Process memory issues
    To be completed
    ==========================================================================================
    */
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

