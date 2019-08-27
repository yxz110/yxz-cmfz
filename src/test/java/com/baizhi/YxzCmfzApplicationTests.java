package com.baizhi;

import io.goeasy.GoEasy;
import net.minidev.json.JSONArray;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;


@RunWith(SpringRunner.class)
@SpringBootTest
public class YxzCmfzApplicationTests {


    @Test
    public void sd() {

        while (true) {

            List<Integer> list = new ArrayList<>();

            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);
            list.add(new Random().nextInt(10) + 1);

            JSONArray array = new JSONArray();
            array.addAll(list);
            String s = array.toJSONString();

            GoEasy goEasy = new GoEasy("http://rest-hangzhou.goeasy.io", "BC-8feb2cd912474440a4994831c59fd3f3");
            goEasy.publish("my_channel", "s");


            try {
                Thread.sleep(2000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }


    }

}
