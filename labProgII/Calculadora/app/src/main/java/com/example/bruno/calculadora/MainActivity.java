package com.example.bruno.calculadora;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    String displayString;
    TextView resultDisplay;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        resultDisplay = (TextView)findViewById(R.id.resultDisplay);
        displayString = "";
    }
    void updateDisplay(){
        resultDisplay.setText(displayString);
    }
    public void ac(View view){
        displayString = "";
        updateDisplay();
    }
    public void sign(View view){
        displayString = "-("+displayString+")";
        updateDisplay();
    }
    public void percent(View view){}
    public void plus(View view){
        displayString+="+";
        updateDisplay();
    }
    public void minus(View view){
        displayString+="-";
        updateDisplay();
    }
    public void times(View view){
        displayString+="x";
        updateDisplay();
    }
    public void divide(View view){
        displayString+="÷";
        updateDisplay();
    }
    public void equals(View view){
        displayString = ""+Evaluator.eval(displayString);
        updateDisplay();
        displayString="";
    }
    public void zero(View view){
        displayString+=0;
        updateDisplay();
    }
    public void one(View view){
        displayString+=1;
        updateDisplay();
    }
    public void two(View view){
        displayString+=2;
        updateDisplay();
    }
    public void three(View view){
        displayString+=3;
        updateDisplay();
    }
    public void four(View view){
        displayString+=4;
        updateDisplay();
    }
    public void five(View view){
        displayString+=5;
        updateDisplay();
    }
    public void six(View view){
        displayString+=6;
        updateDisplay();
    }
    public void seven(View view){
        displayString+=7;
        updateDisplay();
    }
    public void eight(View view){
        displayString+=8;
        updateDisplay();
    }
    public void nine(View view){
        displayString+=9;
        updateDisplay();
    }
    public void comma(View view){
        displayString+=".";
        updateDisplay();
    }
}
