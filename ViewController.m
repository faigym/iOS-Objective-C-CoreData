//
//  ViewController.m
//  ObjC-BCIT-COMP4977
//
//  Created by Sean on 2/24/15.
//  Copyright (c) 2015 BCIT. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@synthesize fNameField;
@synthesize lNameField;
@synthesize stuNumField;

- (IBAction)saveBtn:(UIButton *)sender {
    
    NSString *fName = [fNameField text];
    NSString *lName = [lNameField text];
    NSString *stuNum = [stuNumField text];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *newStudent;
    newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:context];
    [newStudent setValue:fName forKey:@"fName"];
    [newStudent setValue:lName forKey:@"lName"];
    [newStudent setValue:stuNum forKey:@"stuNum"];
    
    NSLog(@"Obj saved");
    
    NSError *error;
    [context save:&error];
}


- (IBAction)loadBtn:(UIButton *)sender
{
    NSString *fName = [fNameField text];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Students" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(fName = %@)", fName];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0)
    {
        NSLog(@"No matches");
    }
    else
    {
        unsigned long num = [objects count];
        matches = objects[num - 1];
        [fNameField setText:[matches valueForKey:@"fName"]];
        [lNameField setText:[matches valueForKey:@"lName"]];
        [stuNumField setText:[matches valueForKey:@"stuNum"]];
        
        //Display one obj
    }
}


@end
