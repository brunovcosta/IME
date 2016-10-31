package com.example.bruno.calculadora;

import java.net.DatagramPacket;
import java.util.ArrayList;

/**
 * Created by bruno on 13/09/16.
 */
public class Evaluator {
    public static double eval(String cmd){
        ArrayList<Double> numbers = new ArrayList<>();
        ArrayList<Character> operations = new ArrayList<>();
        String lastValue="";
        for(char ch : cmd.toCharArray()){
            switch (ch){
                case '+':
                    numbers.add(Double.parseDouble(lastValue));
                    operations.add(ch);
                    lastValue="";
                    break;
                case '-':
                    numbers.add(Double.parseDouble(lastValue));
                    operations.add(ch);
                    lastValue="";
                    break;
                case '÷':
                    numbers.add(Double.parseDouble(lastValue));
                    operations.add(ch);
                    lastValue="";
                    break;
                case 'x':
                    numbers.add(Double.parseDouble(lastValue));
                    operations.add(ch);
                    lastValue="";
                    break;
                default:
                    lastValue+=ch;
            }
        }
        numbers.add(Double.parseDouble(lastValue));
        double res=numbers.get(0);
        for(int t=1;t<numbers.size();t++){
            switch (operations.get(t-1)){
                case '+':
                    res+=numbers.get(t);
                    break;
                case '-':
                    res-=numbers.get(t);
                    break;
                case 'x':
                    res*=numbers.get(t);
                    break;
                case '÷':
                    res/=numbers.get(t);
                    break;
                default:
                    break;
            }
        }
        return res;
    }
}
