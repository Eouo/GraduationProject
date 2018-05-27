package com.iozhaq.utils;

import java.util.ArrayList;
import java.util.List;

public class ListHelper {
    public static List<String> getList(String id) {
        List<String> list = new ArrayList<String>();
        String[] str = id.split(",");
        for (int i = 0; i < str.length; i++) {
            list.add(str[i]);
        }
        return list;
    }
}
