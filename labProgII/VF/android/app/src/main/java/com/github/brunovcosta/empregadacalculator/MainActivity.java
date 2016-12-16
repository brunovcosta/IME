package com.github.brunovcosta.empregadacalculator;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.text.method.KeyListener;
import android.view.KeyEvent;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    EditText input;
    TextView output;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        input = (EditText)findViewById(R.id.input);
        output = (TextView) findViewById(R.id.output);

        input.setOnKeyListener((v,keyCode,event) ->{
            double liquido;
            try{
                liquido = Double.parseDouble(input.getText().toString());
            }catch (Exception e){
                liquido=0;
            }
            output.setText(String.format("R$ %.2f",custo(liquido)) );
                return false;
            }
        );
    }

    private double custo(double liquido){
        return (liquido/0.92)*(1+0.08+0.008+0.08+0.032);
    }


}
