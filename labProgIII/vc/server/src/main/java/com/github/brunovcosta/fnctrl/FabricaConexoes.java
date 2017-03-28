package com.github.brunovcosta.fnctrl;

import java.sql.*;
import java.util.*;
import java.util.Map.Entry;

public class FabricaConexoes {
	private static Connection connection;
	private static Statement statement;

	public static void open(){
		try{
			Class.forName("org.postgresql.Driver");
			connection = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/fnctrl","postgres","postgres");
			statement = connection.createStatement();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public static void close(){
		try{
			statement.close();
			connection.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public static int update(String sql){
		try {
			int count = statement.executeUpdate(sql);

			return count;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}

	public static ResultSet query(String sql){
		try {
			ResultSet resultSet = statement.executeQuery(sql);

			return resultSet;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
