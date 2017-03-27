package com.github.brunovcosta.vchess;
import static spark.Spark.*;

import java.sql.*;
import java.util.*;
import java.util.Map.Entry;

public class App {
	private static Connection connection;
	private static Statement statement;
	public static void main( String[] args ) {
		staticFiles.location("/public");
		get("/api/:name", (req, res) -> {
			String name = req.params(":name").toString();
			String fen = getFen(name);
			if(fen.equals("none")){
				newGame(req.params(":name"));
				fen = getFen(name);
			}
			return fen;
		});
		post("/api/:name", (req, res) -> {
			String name = req.params(":name").toString();
			String fen = req.queryParams("fen").toString();
			setFen(name,fen);
			return 200;
		});

		before((req,res) ->{
			openConnections();
		});
		after((req,res) ->{
			closeConnections();
		});

	}

	private static void openConnections(){
		try{
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/vchess","postgres","postgres");
			statement = connection.createStatement();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	private static void closeConnections(){
		try{
			statement.close();
			connection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	private static void setFen(String name,String fen){
		try {
			System.out.println("update games set fen = '"+fen+"' where name = '"+name+"'");
			update("update games set fen = '"+fen+"' where name = '"+name+"'");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	private static int newGame(String name){
		return update("insert into games(name) values ('"+name+"')");
	}

	private static String getFen(String name){
		try {
			System.out.println("select fen from games where name = '"+name+"'");
			ResultSet rs = query("select fen from games where name = '"+name+"'");
			if(rs.next())
				return rs.getString("fen");
			else
				return "none";
		} catch(Exception e){
			e.printStackTrace();
			return "error";
		}

	}

	private static int update(String sql){
		try {
			int count = statement.executeUpdate(sql);

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	private static ResultSet query(String sql){
		try {
			ResultSet resultSet = statement.executeQuery(sql);

			return resultSet;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
