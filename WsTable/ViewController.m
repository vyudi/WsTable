//
//  ViewController.m
//  WsTable
//
//  Created by Vitor Yudi Hansen on 07/08/13.
//  Copyright (c) 2013 Vitor Yudi Hansen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize lista,mainTableView,urlJs;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    lista = [[NSMutableArray alloc]init];
    BOOL conected = [self isNetworkAvailable];
    
    if(conected){

        urlJson = [NSURL URLWithString:@"http://p2center.com/cidade/rest/listaExpositor/pt"];
        
        [self parseJSONWithURL:urlJson];
        
    }else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Erro"
                                                            message:@"Para acessar esse conteúdo é necessário conectar com a internet. Tente novamente."
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];

    }
    
}

- (void) parseJSONWithURL:(NSURL *) jsonURL
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    dispatch_async(queue, ^{
        NSError *error = nil;
        
        NSString *json = [NSString stringWithContentsOfURL:jsonURL
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
        if (error == nil){
 
            NSData *jsonData = [json dataUsingEncoding:NSASCIIStringEncoding];
            jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];

            if (error == nil)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

                    NSDictionary *dict;
                    for(NSDictionary *dicta in jsonDict){
                        dict = [dicta valueForKey:@"expositor"];
                        
                        Expositor *ex = [[Expositor alloc]init];
                        ex.nome=[dict valueForKey:@"nome_fantasia"];
                        ex.website=[dict valueForKey:@"site_expositor"];
                        [lista addObject:ex];
                        
                    }

                    [self.mainTableView reloadData];
                });
            }

        }
    });
}

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        return NO;
    }
    else{
        NSLog(@"-> connection established!\n");
        return YES;
    }
}

- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", url, [responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [lista count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"thingCell";
    
    UITableViewCell *cell = [self.mainTableView dequeueReusableCellWithIdentifier:cellID];
    
    if ( cell == nil )
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        
    }
    
    Expositor *thing = [lista objectAtIndex:[indexPath row]];
    cell.textLabel.text = [thing nome];

    cell.detailTextLabel.text = [thing website];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Expositor *exp = [lista objectAtIndex:indexPath.row];
    // Get current device
    NSString *urlS = [exp website];

    
    [self openUrl:urlS];
    
    
}

-(void)openUrl:(NSString*)urlS{
    NSURL *url = [ [ NSURL alloc ] initWithString: urlS ];
    [[UIApplication sharedApplication] openURL:url];
}


@end
