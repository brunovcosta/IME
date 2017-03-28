package com.github.brunovcosta.fnctrl;

import static spark.Spark.*;
import java.text.SimpleDateFormat;

public class App {
    public static void main( String[] args ) {

		GastosDAO dao = new GastosDAO();

		staticFiles.location("/public");
		get("/gastos/:name", (req, res) -> {
			return dao.listar(req.params(":name"));
		});

		post("/gastos/:name/create", (req, res) -> {
			Gastos g = new Gastos(
				req.queryParams("userName"),
				new SimpleDateFormat().parse(req.queryParams("createdAt")),
				req.queryParams("description"),
				Integer.parseInt(req.queryParams("amount"))
			);
			return dao.inserir(g);
		});

		post("/gastos/:name/update_valor", (req, res) -> {
			Gastos g = new Gastos(
				req.queryParams("userName"),
				new SimpleDateFormat().parse(req.queryParams("createdAt")),
				req.queryParams("description"),
				Integer.parseInt(req.queryParams("amount"))
			);
			return dao.updateValor(g,Float.parseFloat(req.queryParams("amount")));
		});

		post("/gastos/:name/delete", (req, res) -> {
			return dao.deleteValor(
				Float.parseFloat(req.queryParams("amount")),
				new SimpleDateFormat().parse(req.queryParams("createdAt")));
		});

    }
}
