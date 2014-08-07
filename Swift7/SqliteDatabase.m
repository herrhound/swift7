//
//  SqliteDatabaseManager.m
//  iBwaveMobile
//
//  Created by Bob Quenneville on 6/22/11.
//  Copyright 2011 by iBwave. All rights reserved.
//

#import "SqliteDatabase.h"

@interface SqliteDatabase()
{
    sqlite3  *database_;
}
@end

@implementation SqliteDatabase


+ (id)databaseWithPath:(NSString*)databasePath;
{
    return [[SqliteDatabase alloc] initWithPath:databasePath];
}


- (id)initWithPath:(NSString*)databasePath
{
    self = [super init];
    if (self) {
        self.databasePath = databasePath;
    }
    
    return self;
}

-(void)dealloc
{
    [self closeDatabase];
}

- (BOOL)openDatabase
{
    if (database_ != nil) {
        //NSLog(@"Warning the database was not closed.");
        return NO;
    }
    
    if (sqlite3_open([_databasePath UTF8String], &database_) != SQLITE_OK)
    {
        return NO;
    }
    
    return YES;
}

- (void)closeDatabase
{
    if (database_ != nil) {
        sqlite3_close(database_);
        database_ = nil;
    }else {
        //NSLog(@"Warning the database was not opened.");
    }
}

- (BOOL)beginTransaction
{
    return [self processExecuteStatement:@"BEGIN TRANSACTION;"];
}

- (BOOL)commitTransaction
{
    return [self processExecuteStatement:@"COMMIT TRANSACTION;"];
}

- (BOOL)rollbackTransaction
{
    return [self processExecuteStatement:@"ROLLBACK TRANSACTION;"];
}

-(NSArray*)processSelectStatement:(NSString *)sql
{	
	NSMutableArray* array = [NSMutableArray arrayWithCapacity:10];
	    
	const char *sqlStatement = [sql UTF8String];
	
	sqlite3_stmt *compiledStatement = nil;
	
	if (sqlite3_prepare_v2(database_, sqlStatement, -1, &compiledStatement, NULL) != SQLITE_OK) 
    {
		return nil;
	}
	
	while (sqlite3_step(compiledStatement) == SQLITE_ROW) 
	{
		int columns = sqlite3_column_count(compiledStatement);
		NSMutableArray* row = [NSMutableArray arrayWithCapacity:columns];
		
		for (int i = 0; i < columns; i++) 
        {
            int type = sqlite3_column_type(compiledStatement, i);
            
            switch (type) 
            {
                case SQLITE_TEXT:
                    [row addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)]];
                    break;
                case SQLITE_INTEGER:
                    [row addObject:[NSNumber numberWithInt:(int)sqlite3_column_int(compiledStatement, i)]];
                    break; 
                case SQLITE_NULL:
                    //TODO: return [NSNull null] when it is number type of data.
                    
                    /* change to the value returned when NULL is encountered must be reflected 
                     * in ProjectDBHelper::objectOrNilFromColumnResult
                     */
                    [row addObject:[NSString string]];
                    break;
                case SQLITE_FLOAT:
                    [row addObject:[NSNumber numberWithDouble:(double)sqlite3_column_double(compiledStatement, i)]];
                    break;
                case SQLITE_BLOB:
                    [row addObject:[NSData dataWithBytes:sqlite3_column_blob(compiledStatement, i) length:sqlite3_column_bytes(compiledStatement, i)]];
                    break;
                default:
                    break;
            }
		}
		
		[array addObject:row];
	}
	
    sqlite3_finalize(compiledStatement);
    
	return array;
}

- (BOOL)processExecuteStatement:(NSString *)sql
{
    sqlite3_stmt *compiledStatement;
        
    if (sqlite3_prepare_v2(database_, [sql UTF8String], -1, &compiledStatement, NULL) != SQLITE_OK) {
        return NO;
    }
        
    int success = sqlite3_step(compiledStatement);
        
    sqlite3_finalize(compiledStatement);
    
    return (success == SQLITE_DONE);
}
/*
- (int)lastInsertedRowID
{
    return sqlite3_last_insert_rowid(database_);
}
*/
-(void)checkAndCreateDatabase
{
	BOOL exists;
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	exists = [fileManager fileExistsAtPath:_databasePath];
	
	if (exists)
		return;
	
}

@end
