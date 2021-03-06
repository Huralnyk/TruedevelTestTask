//
//  RepoViewController.m
//  TruedevelTestTask
//
//  Created by Alexey Huralnyk on 4/5/15.
//  Copyright (c) 2015 Alexey Huralnyk. All rights reserved.
//

#import "WebViewController.h"
#import "GitHubEventFetcher.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, strong) NSURL *pageURL;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // To avoid additional spacing at the top of WebView
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)setRepoURL:(NSURL *)repoURL
{
    _repoURL = repoURL;
    [self showPage];
}

- (void)showPage
{
    [GitHubEventFetcher downloadDataFromURL:self.repoURL withCompletionHandler:^(NSData *data) {
        if(data) {
            NSError *error;            
            NSDictionary *repoDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if(!error) {
                self.pageURL = [NSURL URLWithString:[repoDictionary valueForKey:REPO_PAGE_URL]];
                NSURLRequest *request = [NSURLRequest requestWithURL:self.pageURL];
                [self.webView loadRequest:request];
            } else {
                NSLog(@"%@", [error localizedDescription]);
            }
        } else {
            NSLog(@"Oops! We have no data. Must fix it.");
        }
    }];    
}

#pragma mark - Web View Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"Loading...");
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"Loading is finished");
    [self.spinner stopAnimating];
}

@end
