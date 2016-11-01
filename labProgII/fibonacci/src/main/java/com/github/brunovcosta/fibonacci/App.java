package com.github.brunovcosta.fibonacci;
import static spark.Spark.*;
public class App {
    public static void main( String[] args ) {
		get("/fib", (req, res) -> {
			return fib(Integer.parseInt(req.queryParams("n")));
		});
    }

	private static int fib(int n){
		switch(n){
			case 0:
				return 0;
			case 1:
				return 1;
			default:
				return fib(n-1)+fib(n-2);
		}
	}
}
