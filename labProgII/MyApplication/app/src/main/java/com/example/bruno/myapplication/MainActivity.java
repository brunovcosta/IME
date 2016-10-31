package com.example.bruno.myapplication;

import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {
    EditText password;
    EditText passwordConfirmation;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        password=(EditText)findViewById(R.id.password);
        passwordConfirmation=(EditText)findViewById(R.id.passwordConfirmation);

    }
    public void click(View v){
        if(password.getText().toString().equals(passwordConfirmation.getText().toString())){
            if(salvar(password.getText().toString())){
                Toast.makeText(this,"Senha salva com sucesso!",Toast.LENGTH_LONG).show();
            }else{
                Toast.makeText(this,"Erro ao salvar esta senha. Tente novamente.",Toast.LENGTH_LONG).show();
            }
        }else{
            Toast.makeText(this,"Senhas não conferem",Toast.LENGTH_LONG).show();
        }
    }
    private boolean salvar(String s){
        try{
            //TODO realizar operações de salvar
            return true;
        }catch (Exception e){
            return true;
        }
    }
}
