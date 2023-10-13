package org.zerock.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

import lombok.extern.log4j.Log4j;

@Aspect
@Log4j
@Component
public class LogAdvice {
	@After("execution(* org.zerock.controller.BoardController*.*(..))")
	public void boardRequest() {
		log.info("웹 페이지 요청");
	}
	
	@Before("execution(* org.zerock.controller.ReplyController*.*(..))")
	public void replyRequest() {
		log.info("데이터 요청");
	}
	
	@After("execution(* org.zerock.controller.HomeController*.*(..))")
	public void homeRequest() {
		log.info("웹 페이지 요청");
	}
	
	@Before("execution(* org.zerock.controller.MyApiController*.*(..))")
	public void apiRequest() {
		log.info("데이터 요청");
	}
}