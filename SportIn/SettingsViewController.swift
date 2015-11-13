//
//  SettingsViewController.swift
//  SportIn
//
//  Created by Luiz Fernando Santiago on 9/3/15.
//  Copyright (c) 2015 Luiz Fernando Santiago. All rights reserved.
//?

import UIKit
import Parse


class SettingsViewController: UIViewController {
    
        let personalSettings = [
            ("Parceiros","Saiba quem sao nossos parceiros"),
            ("Opcao de Compartilhamento","ajuste suas opcoes de share"),
            ("Privacidade","Ajuste sua opcão de privacidade"),
            ("Push e Notificacoes","Receba ou não notificaçoes")]
        
        let professionalSettings = [
            ("Opcao Premium","Ainda não é premium?"),
            ("Apple Watch","Sincronizar com iWatch"),
            ("Informativo de Esportes","Nossa fonte de colaboradores"),
            ("Ativacao de dados","Usar 3G para conexoes"),
            ("controle de musica","Controlar musica de fundo")]
        
        let otherslSettings = [
            ("Mais Configs","Lorem Ipsum"),
            ("Outras Informacoes","Lorem Ipsum"),
            ("Menos informacoes","Lorem Ipsum"),
            ("Selecioanr outro idioma","Lorem Ipsum")]
        
        let aboutlSettings = [
            ("Sobre o SportIn","Lorem Ipsum"),
            ("Tour no App","Lorem Ipsum"),
            ("Suporte ao Usuario","Lorem Ipsum"),
            ("Termo de Privacidade","Lorem Ipsum"),
            ("Termo de Uso","Lorem Ipsum")]
        
        
        func numberOfSectionsInTableView(tableView: UITableView) -> Int {
            return 4
        }
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            if section == 0 {
                return personalSettings.count
            }
            if section == 1 {
                return professionalSettings.count
            }
            if section == 2 {
                return otherslSettings.count
            }
            if section == 3 {
                return aboutlSettings.count
            
            }
            return 0
    }

        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) 
            
            if indexPath.section == 0 {
                let (courseTitle,courseAuthor) = personalSettings[indexPath.row]
                cell.textLabel?.text = courseTitle
                cell.detailTextLabel?.text = courseAuthor
            }
            if indexPath.section == 1 {
                let (courseTitle,courseAuthor) = professionalSettings[indexPath.row]
                cell.textLabel?.text = courseTitle
                cell.detailTextLabel?.text = courseAuthor
            }
            if indexPath.section == 2 {
                let (courseTitle,courseAuthor) = otherslSettings[indexPath.row]
                cell.textLabel?.text = courseTitle
                cell.detailTextLabel?.text = courseAuthor
            }
            if indexPath.section == 3 {
                let (courseTitle,courseAuthor) = aboutlSettings[indexPath.row]
                cell.textLabel?.text = courseTitle
                cell.detailTextLabel?.text = courseAuthor
            }
            
            // Retrieve an image
            //var myImage = UIImage(named: "CellIcon")
            //cell.imageView?.image = myImage
            
            
            return cell
        }
        
        func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Configuração Basica"
            }
            if section == 1 {
                return "Configuração de Profissional"
            }
            if section == 2 {
                return "Outras Configurações"
            } else {
                return "Sobre o SportIn"
            }
        }
        
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false
            
            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem()
            
            
            // codigo para personalizar o navigationBar
            self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        }
        
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // MARK: - Table view data source
        
        @IBAction func menuButton(sender: AnyObject) {
            let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.drawerContainer!.toggleDrawerSide(MMDrawerSide.Left, animated: true, completion: nil)
        }
        
        /*
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        // Configure the cell...
        
        return cell
        }
        */
        
        /*
        // Override to support conditional editing of the table view.
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
        }
        */
        
        /*
        // Override to support editing the table view.
        override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        // Delete the row from the data source
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        }
        */
        
        /*
        // Override to support rearranging the table view.
        override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        }
        */
        
        /*
        // Override to support conditional rearranging of the table view.
        override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
        }
        */
        
        /*
        // MARK: - Navigation
        
        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        }
        */
        
}

