package junit;

import java.util.Random;

import org.junit.Test;

public class TestMath {
	
	@Test
	public void f() {
		Random random = new Random();
		System.out.println(random.nextFloat());
		System.out.println(random.nextDouble());
		  
	}

}
