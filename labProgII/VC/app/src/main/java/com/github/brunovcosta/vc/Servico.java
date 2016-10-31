package com.github.brunovcosta.vc;

import java.util.Random;

public class Servico implements Comparable<Servico>{
    @Override
    public int compareTo(Servico another) {
        return another.getPrioridade()-getPrioridade();
    }

    public enum Tipo{WEB,BANCO_DE_DADOS,EMAIL};

    private Tipo tipo;

    private int Fator_Servico;
    private double perc_CPU_Livre;
    private double perc_mem_livre;

    public Servico(Tipo tipo){
        this.tipo = tipo;
        calcFator();
        perc_CPU_Livre = (new Random()).nextInt(100);
        perc_mem_livre = (new Random()).nextInt(100);
    }
    public int getFator(){
        return Fator_Servico;
    }
    public double getPerc_CPU_Livre(){
        return perc_CPU_Livre;
    }
    public double getPerc_Mem_Livre(){
        return perc_mem_livre;
    }
    public String getNomeServidor(){
        //TODO utilizar conexão real.
        return "psql";
    }
    public int getPrioridade(){
        return (int)(Fator_Servico*(perc_CPU_Livre/100+perc_mem_livre/100));
    }
    private void calcFator(){
        switch (tipo){
            case WEB:
                Fator_Servico = 6;
            break;
            case BANCO_DE_DADOS:
                Fator_Servico = 7;
            break;
            case EMAIL:
                Fator_Servico = 9;
            break;
        }
    }

    @Override
    public String toString() {
       return getNomeServidor()+" - "+getPrioridade();
    }
}
