package com.vemm8ks2.sbb;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class HelloLombok {

	final private String hello;
	final private int lombok;
	
	public static void main(String[] args) {
		
		HelloLombok helloLombok = new HelloLombok("헬로", 5);
		
		System.out.println(helloLombok.getHello());
		System.out.println(helloLombok.getLombok());
	}
}
