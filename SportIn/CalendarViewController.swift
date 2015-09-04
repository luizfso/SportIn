//
//  CalendarViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 8/24/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//

import UIKit
import Parse
import MapKit
import CoreLocation


class CalendarViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var eventsMaps: MKMapView!
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    
    var listOfEvents = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    var searchResults = [String]()
    
    let eventsNew = [
        ("Peneira do Xico","Lorem Ipsum"),
        ("Selecao de Players","Lorem Ipsum"),
        ("Feira de Taletos","Lorem Ipsum"),
        ("Bate papo com KAKA","Lorem Ipsum")]
    
    let eventsPast = [
        ("Selecao do Sao Paulo","Lorem Ipsum?"),
        ("Selecao do Santos","Lorem Ipsum"),
        ("Selecao de base Corinthians","Lorem Ipsum"),
        ("Encontro de altetas","Lorem Ipsum"),
        ("Corrida no parque Ibira","Lorem Ipsum")]
    
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
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section == 0 {
            return eventsNew.count
        }
        if section == 1{
            return eventsPast.count
        }
        if section == 2{
        return searchResults.count
        }
        return 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    /*
    let eventsNew = [
    ("Peneira do Xico","Lorem Ipsum"),
    ("Selecao de Players","Lorem Ipsum"),
    ("Feira de Taletos","Lorem Ipsum"),
    ("Bate papo com KAKA","Lorem Ipsum")]
    
    let eventsPast = [
    ("Selecao do Sao Paulo","Lorem Ipsum?"),
    ("Selecao do Santos","Lorem Ipsum"),
    ("Selecao de base Corinthians","Lorem Ipsum"),
    ("Encontro de altetas","Lorem Ipsum"),
    ("Corrida no parque Ibira","Lorem Ipsum")]
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
    return eventsNew.count
    }else {
    return eventsPast.count
    }
    }
    */
    
    
    
    
    /*
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    */
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let mycellMaps = tableView.dequeueReusableCellWithIdentifier("cellMaps", forIndexPath: indexPath) as! UITableViewCell
        
        if indexPath.section == 0 {
            let (courseTitle,courseAuthor) = eventsNew[indexPath.row]
            mycellMaps.textLabel?.text = courseTitle
            mycellMaps.detailTextLabel?.text = courseAuthor
        }
        if indexPath.section == 1{
            let (courseTitle,courseAuthor) = eventsPast[indexPath.row]
            mycellMaps.textLabel?.text = courseTitle
            mycellMaps.detailTextLabel?.text = courseAuthor
        }
        if indexPath.section == 2{
            
            mycellMaps.textLabel?.text = searchResults[indexPath.row]
        }

       
        
        return mycellMaps
    }
    
    /*
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCellWithIdentifier("cellMaps", forIndexPath: indexPath) as! UITableViewCell
    
    if indexPath.section == 0 {
    let (courseTitle,courseAuthor) = eventsNew[indexPath.row]
    cell.textLabel?.text = courseTitle
    cell.detailTextLabel?.text = courseAuthor
    }
    else {
    let (courseTitle,courseAuthor) = eventsPast[indexPath.row]
    cell.textLabel?.text = courseTitle
    cell.detailTextLabel?.text = courseAuthor
    }
    // Retrieve an image
    //var myImage = UIImage(named: "CellIcon")
    //cell.imageView?.image = myImage
    
    return cell
    }
    */
    
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
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    if section == 0 {
    return "Novos eventos"
    }
    else {
    return "Eventos que já aconteceram"
    }
    }
    */
    
    
    
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
