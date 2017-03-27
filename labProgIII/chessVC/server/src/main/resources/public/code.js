var apiURL = "/api";
var board = ChessBoard('board', {
	draggable: true,
	dropOffBoard: 'snapback',
	sparePieces: false,
	position: 'start',
	onDrop: function(source, target, piece, newPos, oldPos, orientation){
		$.post(apiURL+"/"+location.hash.substr(1),{fen: ChessBoard.objToFen(newPos)},function(data){
			console.log(data);
		});
	},
	showErrors: 'console'
});
setInterval(function(){
	$.get(apiURL+"/"+location.hash.substr(1),{},function(fen){
		board.position(fen);
	});
},1000);

$("#reset").click(function(evt){
		$.post(apiURL+"/"+location.hash.substr(1),{fen: 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR'},function(data){
			console.log(data);
		});
});
