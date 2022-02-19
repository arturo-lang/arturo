/* Loosely inspired by:
   https://github.com/yglukhov/nimx/blob/master/nimx/private/windows/appkit_window.nim
*/

#include <AppKit/AppKit.h>

static NSString * GetApplicationName(void) {
    NSString *appName;

    appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    if (!appName)
        appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];

    if (![appName length])
        appName = [[NSProcessInfo processInfo] processName];

    return appName;
}

void generateDefaultMainMenu(void){
    NSString *title;

    if (NSApp == nil) return;
    if ([NSApp mainMenu]) return;

    NSMenuItem *menuItem;
    NSMenu* mainMenu = [[NSMenu alloc] init];
    NSString* appName = GetApplicationName(); //[NSString stringWithUTF8String: ttl];

    /***************************************
     Create the main app menu 
     ***************************************/
    NSMenu* appMenu = [[NSMenu alloc] initWithTitle:@""];

    [appMenu addItemWithTitle:[@"About " stringByAppendingString:appName] 
                       action:@selector(orderFrontStandardAboutPanel:) 
                keyEquivalent:@""];

    [appMenu addItem:[NSMenuItem separatorItem]];
    [appMenu addItemWithTitle:@"Preferences…" action:nil keyEquivalent:@","];
    [appMenu addItem:[NSMenuItem separatorItem]];

    NSMenu* serviceMenu = [[NSMenu alloc] initWithTitle:@""];
    menuItem = (NSMenuItem *)[appMenu addItemWithTitle:@"Services" 
                                                action:nil 
                                         keyEquivalent:@""];
    [menuItem setSubmenu:serviceMenu];
    [NSApp setServicesMenu:serviceMenu];
    [serviceMenu release];

    [appMenu addItem:[NSMenuItem separatorItem]];

    [appMenu addItemWithTitle:[@"Hide " stringByAppendingString:appName] 
                       action:@selector(hide:) 
                keyEquivalent:@"h"];

    menuItem = (NSMenuItem *)[appMenu addItemWithTitle:@"Hide Others" 
                                                action:@selector(hideOtherApplications:) 
                                         keyEquivalent:@"h"];
    [menuItem setKeyEquivalentModifierMask:(NSAlternateKeyMask|NSCommandKeyMask)];
    [appMenu addItemWithTitle:@"Show All" 
                       action:@selector(unhideAllApplications:) 
                keyEquivalent:@""];

    [appMenu addItem:[NSMenuItem separatorItem]];

    [appMenu addItemWithTitle:[@"Quit " stringByAppendingString:appName] 
                       action:@selector(terminate:) 
                keyEquivalent:@"q"];

    // Put it into the menubar
    menuItem = [[NSMenuItem alloc] initWithTitle:@"" action:nil keyEquivalent:@""];
    [menuItem setSubmenu:appMenu];
    [mainMenu addItem:menuItem];
    [menuItem release];

    [appMenu release];

    /***************************************
     Create the Edit menu 
     ***************************************/
    NSMenu* editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];

    [editMenu addItemWithTitle:@"Undo" 
                        action:@selector(undo:) 
                 keyEquivalent:@"z"];
    [editMenu addItemWithTitle:@"Redo" 
                        action:@selector(redo:) 
                 keyEquivalent:@"Z"];
    [editMenu addItem:[NSMenuItem separatorItem]];
    [editMenu addItemWithTitle:@"Cut" 
                        action:@selector(cut:) 
                 keyEquivalent:@"x"];
    [editMenu addItemWithTitle:@"Copy" 
                        action:@selector(copy:) 
                 keyEquivalent:@"c"];
    [editMenu addItemWithTitle:@"Paste" 
                        action:@selector(paste:) 
                 keyEquivalent:@"v"];
    [editMenu addItemWithTitle:@"Delete" 
                        action:@selector(delete:) 
                 keyEquivalent:@""];
    [editMenu addItemWithTitle:@"Select All" 
                        action:@selector(selectAll:) 
                 keyEquivalent:@"a"];

    // Put it into the menubar
    menuItem = [[NSMenuItem alloc] initWithTitle:@"Edit" action:nil keyEquivalent:@""];
    [menuItem setSubmenu:editMenu];
    [mainMenu addItem:menuItem];
    [menuItem release];

    [editMenu release];

    /***************************************
     Create the View menu 
     ***************************************/
    NSMenu* viewMenu = [[NSMenu alloc] initWithTitle:@"View"];

    /* Add the fullscreen view toggle menu option, if supported */
    if (floor(NSAppKitVersionNumber) > NSAppKitVersionNumber10_6) {
        menuItem = [viewMenu addItemWithTitle:@"Toggle Full Screen" 
                                       action:@selector(toggleFullScreen:) 
                                keyEquivalent:@"f"];
        [menuItem setKeyEquivalentModifierMask:NSControlKeyMask | NSCommandKeyMask];
    }

    // Put it into the menubar
    menuItem = [[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""];
    [menuItem setSubmenu:viewMenu];
    [mainMenu addItem:menuItem];
    [menuItem release];

    [viewMenu release];

    /***************************************
     Create the Window menu 
     ***************************************/

    /* Create the window menu */
    NSMenu* windowMenu = [[NSMenu alloc] initWithTitle:@"Window"];

    [windowMenu addItemWithTitle:@"Minimize" 
                          action:@selector(performMiniaturize:) 
                   keyEquivalent:@"m"];
    [windowMenu addItemWithTitle:@"Zoom" 
                          action:@selector(performZoom:) 
                   keyEquivalent:@""];

    // Put it into the menubar
    menuItem = [[NSMenuItem alloc] initWithTitle:@"Window" action:nil keyEquivalent:@""];
    [menuItem setSubmenu:windowMenu];
    [mainMenu addItem:menuItem];
    [menuItem release];

    // Set as the windowsMenu
    [NSApp setWindowsMenu:windowMenu];
    [windowMenu release];

    /***************************************
     Create the Window menu 
     ***************************************/
    NSMenu* helpMenu = [[NSMenu alloc] initWithTitle:@"Help"];
    [helpMenu addItemWithTitle: [appName stringByAppendingString:@" Help"] action:@selector(showHelp:) keyEquivalent:@"?"];

    // Put it into the menubar
    menuItem = [[NSMenuItem alloc] initWithTitle:@"Help" action:nil keyEquivalent:@""];
    [menuItem setSubmenu:helpMenu];
    [mainMenu addItem:menuItem];
    [menuItem release];

    // Set as the helpMenu
    [NSApp setHelpMenu:helpMenu];
    [helpMenu release];

    /***************************************
     Finally, create the menubar
     ***************************************/
    [NSApp setMainMenu:mainMenu];
}