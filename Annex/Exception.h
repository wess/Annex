//
//  Header.h
//  Annex
//
//  Created by Wess Cope on 10/1/13.
//  Copyright (c) 2013 Wess Cope. All rights reserved.
//

#ifndef __Exception_Annex_Header_h
#define __Exception_Annex_Header_h

static void __AnnexUnimplementedMethod(SEL selector,id object,const char *file,int line)
{
    NSLog(@"-[%@ %s] unimplemented in %s at %d",[object class],sel_getName(selector),file,line);
}

#define AnnexUnimplementedMethod() __AnnexUnimplementedMethod(_cmd, self, __FILE__, __LINE__)

#endif
