//
//  SqliteDatabaseManager.h
//  iBwaveMobile
//
//  Created by Bob Quenneville on 6/22/11.
//  Copyright 2011 by iBwave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SqliteDatabase : NSObject 

@property (nonatomic) NSString* databasePath;

+ (id)databaseWithPath:(NSString*)databasePath;
- (id)initWithPath:(NSString*)databasePath;
- (NSArray*) processSelectStatement:(NSString *)sql;
- (BOOL) processExecuteStatement:(NSString *)sql;
//- (int) lastInsertedRowID;
- (BOOL) openDatabase;
- (void) closeDatabase;
- (BOOL) beginTransaction;
- (BOOL) commitTransaction;
- (BOOL) rollbackTransaction;

@end
