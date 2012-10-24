// Copyright (C) 2011 by Robert Lowe <rob[!]iblargz.com>
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
// shortcut.m
//
// Credits to chapados for putting some of this together some time ago
// https://gist.github.com/114521
//
// I was only able to hack this a small bit to get it working with macruby
// If anyone is able to kick my butt in Objective+C/MacRuby, please do it, I could learn from you!
// 
// It's pretty ugly.
//
// TODO: 
//  * Unregister binded keys!
//  * Handle signatures?
//
// compile:
// gcc shortcut.m -o shortcut.bundle -g -framework Foundation -framework Carbon -framework Cocoa -dynamiclib -fobjc-gc -arch i386 -arch x86_64

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface Shortcut : NSObject
{
    id delegate;
}
@property (assign) id delegate;
- (int) addShortcut: (int)code withKeyModifier:(int)modifier;
- (void) hotkeyWasPressed: (NSString*)hotKeyID;
@end
OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData);


@implementation Shortcut
@synthesize delegate;

OSStatus myHotKeyHandler(EventHandlerCallRef nextHandler, EventRef anEvent, void *userData)
{
    if ( userData != NULL ) {
        id delegate = (id)userData;
        if ( delegate ) {
          EventHotKeyID myHotKeyID;
          GetEventParameter(anEvent, kEventParamDirectObject, typeEventHotKeyID,NULL,
          sizeof(myHotKeyID),NULL,&myHotKeyID);

          NSString* ObjectiveFail = [NSString stringWithFormat:@"%i", myHotKeyID.id];
          
          [delegate hotkeyWasPressed: ObjectiveFail]; // I don't why but macruby get crashy when I returned an int so, whatever, to_i that sh-t.
        }
    }
    return noErr;
}

- (int) addShortcut: (int)code withKeyModifier:(int)modifier
{
  static UInt32 _id = 0;

  EventHotKeyRef myHotKeyRef;
  EventHotKeyID  myHotKeyID;

  EventTypeSpec eventType;
  eventType.eventClass=kEventClassKeyboard;
  eventType.eventKind=kEventHotKeyPressed;

  EventTargetRef eventTarget = (EventTargetRef) GetEventMonitorTarget(); //GetApplicationEventTarget()?

  myHotKeyID.signature='mhk1';
  myHotKeyID.id=_id++;

  if ( delegate == nil )
    delegate = self;

  InstallEventHandler(eventTarget, &myHotKeyHandler, 1, &eventType, (void *)delegate, NULL);
  RegisterEventHotKey(code, modifier, myHotKeyID, eventTarget, 0, &myHotKeyRef);

  return (int)myHotKeyID.id;
}

- (void) hotkeyWasPressed: (NSString*)hotKeyID { 
  NSLog(@"Shh, you shouldn't see me!");
};

@end

void Init_shortcut(void) {}