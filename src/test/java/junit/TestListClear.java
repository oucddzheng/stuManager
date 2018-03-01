package junit;

import java.util.ArrayList;
import java.util.List;

public class TestListClear {
	public static void main(String[] args)
    {
        List<Integer> list = new ArrayList<Integer>();
        for(int i=0;i<10;i++)
            list.add(i);
        System.out.println(list);
        list.clear();
        System.out.println(list);
    }
}
