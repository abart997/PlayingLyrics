#include <objc/runtime.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <libactivator.h>

@interface UIApplication (SpringBoard_PlayingLyricsPrivate)
- (void)launchMusicPlayerSuspended;
@end

@interface SBAlertItem : NSObject
@end

@interface SBUserNotificationAlert : SBAlertItem
- (void)setAlertHeader:(NSString *)header;
- (void)setAlertMessage:(NSString *)msg;
- (void)setDefaultButtonTitle:(NSString *)title;
@end

@interface SBAlertItemsController : NSObject
+ (id)sharedInstance;
- (void)activateAlertItem:(SBAlertItem *)item;
@end

@interface PlayingLyrics : NSObject <LAListener>
@end

@implementation PlayingLyrics
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event{
	[[UIApplication sharedApplication] launchMusicPlayerSuspended];
	
	MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
	MPMediaItem *currentItem = [musicPlayer nowPlayingItem];
	
	NSString *_title = [currentItem valueForProperty:MPMediaItemPropertyTitle];
	NSString *title = _title ? _title : @"Lyrics";
	
	NSString *_lyrics = [currentItem valueForProperty:MPMediaItemPropertyLyrics];
	NSString *lyrics = _lyrics ? _lyrics : @"No Lyrics";
	
	SBUserNotificationAlert *alert = [[objc_getClass("SBUserNotificationAlert") alloc] init];
	[alert setAlertHeader:title];
	[alert setAlertMessage:lyrics];
	[alert setDefaultButtonTitle:@"Close"];
	
	[[objc_getClass("SBAlertItemsController") sharedInstance] activateAlertItem:alert];
	[alert release];
}

+ (void)load {
	NSAutoreleasePool *p = [[NSAutoreleasePool alloc] init];
	[[LAActivator sharedInstance] registerListener:[self new] forName:@"PlayingLyrics"];
	[p drain];
}
@end