package com.github.brunovcosta.vc;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AbsListView;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class MainActivity extends AppCompatActivity {

    private ArrayList<Servico> servidores;

    private ListView list;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        list = (ListView)findViewById(R.id.list);
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Toast.makeText(
                        getApplicationContext(),
                        servidores.get(position).getPerc_Mem_Livre()+"% MEM "+servidores.get(position).getPerc_CPU_Livre()+"% CPU",
                        Toast.LENGTH_SHORT
                ).show();
            }
        });
        servidores = new ArrayList<Servico>();

    }
    public void updateList(View v){
        //TODO criar atualização real
        servidores.clear();
        for(int t=0;t<5;t++){
            servidores.add(new Servico(Servico.Tipo.WEB));
        }
        Collections.sort(servidores);
        ArrayAdapter<Servico> adapter = new ArrayAdapter<Servico>(this,android.R.layout.simple_list_item_1,servidores);
        list.setAdapter(adapter);

    }
}
