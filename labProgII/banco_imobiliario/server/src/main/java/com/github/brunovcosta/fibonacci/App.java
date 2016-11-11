package com.github.brunovcosta.fibonacci;
import static spark.Spark.*;
public class App {
    public static void main( String[] args ) {
		get("/fib", (req, res) -> {
			return "FOO";
		});
    }
}
