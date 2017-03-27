var apiURL = "/api";
var board = ChessBoard('board', {
	draggable: true,
	dropOffBoard: 'snapback',
	sparePieces: false,
	position: 'start',
	onDrop: function(source, target, piece, newPos, oldPos, orientation){
		$.post(apiURL+"/"+location.hash.substr(1),{fen: ChessBoard.objToFen(newPos)},function(data){
			console.log("Source: " + source);
			console.log("Target: " + target);
			console.log("Piece: " + piece);
			console.log("New position: " + ChessBoard.objToFen(newPos));
			console.log("Old position: " + ChessBoard.objToFen(oldPos));
			console.log("Orientation: " + orientation);
			console.log("--------------------");
		});
	},
	showErrors: 'console'
});
setInterval(function(){
	$.get(apiURL+"/"+location.hash.substr(1),{},function(fen){
		board.position(fen);
	});
},1000);
