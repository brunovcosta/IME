package com.github.brunovcosta.fnctrl;

import java.sql.*;
import java.time.*;
import java.time.format.*;
import java.util.Date;
import java.util.ArrayList;

public class GastosDAO {
	private String d2s(Date d){
		return d.toInstant()
			.atOffset( ZoneOffset.UTC )
			.format( DateTimeFormatter.ISO_LOCAL_DATE_TIME )
			.replace( "T" , " " );
	}
	public boolean inserir(Gastos g){
		int count;
		String strDate = d2s(g.getCreatedAt());
		if(g.getAmount()>0)
			count = FabricaConexoes.update("insert into incoming values ('"+g.getUserName()+"','"+strDate+"','"+g.getDescription()+"','"+g.getAmount()+"')");
		else
			count = FabricaConexoes.update("insert into outcoming values ('"+g.getUserName()+"','"+strDate+"','"+g.getDescription()+"','"+(-g.getAmount())+"')");
		return (count!=0);
	}

	public boolean updateValor(Gastos g,float valor){
		FabricaConexoes.open();
		int inCount = FabricaConexoes.update(
			"update incoming set amount='"+
			valor+
			"'where created_at = '"+
			d2s(g.getCreatedAt())+
			"'"
		);
		int outCount = FabricaConexoes.update(
			"update outcoming set amount='"+
			valor+
			"'where created_at = '"+
			d2s(g.getCreatedAt())+
			"'"
		);
		FabricaConexoes.close();

		return (inCount+outCount != 0);
	}

	public boolean deleteValor(float valor, Date data){
		FabricaConexoes.open();
		int inCount = FabricaConexoes.update(
			"delete from incoming where created_at='"+
			d2s(data)+
			"'"
		);
		int outCount = FabricaConexoes.update(
			"delete from outcoming where created_at='"+
			d2s(data)+
			"'"
		);
		FabricaConexoes.close();

		return (inCount+outCount != 0);
	}

	public ArrayList<Gastos> listar(String userName){
		ArrayList<Gastos> list = new ArrayList<>();

		FabricaConexoes.open();
		ResultSet rs = FabricaConexoes.query("select * from balance where user_name = '"+userName+"'");
		try{
			while(rs.next()){
				Gastos g = new Gastos(
						rs.getString("user_name"),
						rs.getDate("created_at"),
						rs.getString("description"),
						rs.getInt("amount")
						);
				list.add(g);
			}
		}catch(SQLException e){ }
		FabricaConexoes.close();
		return list;
	}
}
