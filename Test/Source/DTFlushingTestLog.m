//
//  DTFlushingTestLog.m
//  DTFoundation
//
//  Created by Oliver Drobnik on 27/11/13.
//  Copyright (c) 2013 Cocoanetics. All rights reserved.
//

#import "DTFlushingTestLog.h"

#if COVERAGE
// GCOV Flush function
extern void __gcov_flush(void);
#endif

static id mainSuite = nil;

@implementation DTFlushingTestLog

+ (void)initialize
{
	[[NSUserDefaults standardUserDefaults] setValue:@"DTFlushingTestLog" forKey:SenTestObserverClassKey];
	
	[super initialize];
}

+ (void)testSuiteDidStart:(NSNotification *)notification
{
	[super testSuiteDidStart:notification];
	
	SenTestSuiteRun *suite = notification.object;
	
	if (mainSuite == nil)
	{
		mainSuite = suite;
	}
}

+ (void)testSuiteDidStop:(NSNotification *)notification
{
	[super testSuiteDidStop:notification];
	
#if COVERAGE
	
	SenTestSuiteRun* suite = notification.object;
	
	if (mainSuite == suite)
	{
		// workaround for missing flush with iOS 7 Simulator
		__gcov_flush();
	}
#endif
	
}

@end
