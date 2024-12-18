package kr.or.iei.common.annotation;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;


//사용자 어노테이션
@Retention(RUNTIME) 
@Target(METHOD)  
public @interface NoLoginChk {
}
