#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MediaPlayer/MPMusicPlayerController.h>
#import <MediaPlayer/MPMediaItem.h>
#import <libactivator/libactivator.h>
#import <notify.h>

static UIAlertView *alert;

@interface PlayingLyrics : NSObject<LAListener, UIAlertViewDelegate> {

}	

@end

@implementation PlayingLyrics

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event{

alert = [[UIAlertView alloc]initWithTitle:@"PlayingLyrics" message:@"Do you want to show the lyrics of your playing song?" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:@"Yes",nil];

[alert show];
[alert release];

}

- (void)alertView:(UIAlertView *)alert didDismissWithButtonIndex:(NSInteger)buttonIndex{
if(buttonIndex == 1){

MPMusicPlayerController *musicPlayer;
musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
MPMediaItem *currentItem = [musicPlayer nowPlayingItem];

NSString *textLyrics = [currentItem valueForProperty:@"lyrics"];

UIAlertView *alertLyrics = [[UIAlertView alloc]initWithTitle:@"Song lyrics" message:[NSString stringWithFormat:@"%@", textLyrics]  delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];

[alertLyrics show];
[alertLyrics release];

if (textLyrics == nil){

UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"No lyrics" message:@"No lyrics founded in this song" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

[alertView show];
[alertView release];

}
}
}

+ (void)load
{
    
    if (![[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.apple.springboard"]) {return;}
   
    NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"com.abart997.playinglyrics"];
	[p release];
}

@end