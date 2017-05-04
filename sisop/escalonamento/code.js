function sizeOfQueue(queue,index){
	var sum = 0;
	for(var i=0;i<index;i++)
		sum+=queue[i];
	return sum;
}
var queue = [];

function add(){
	var size = +document.getElementById("job-size").value;
	queue.push(size);
	render();
}

function sub(){
	queue.shift();
	render();
}

function render(){
	d3.select("#screen").selectAll("rect")
		.data(d3.range(queue.length))
		.enter()
		.append("rect")
		.attr("width",function(index){
			return queue[index];
		})
		.attr("height",12)
		.attr("y",0)
		.attr("x",function(index){
			return sizeOfQueue(queue,index);
		})
		.style("fill",function(index){
			var hue = 360*Math.random();
			return d3.hsl(hue,1,0.5);
		});
	d3.select("#queue-viz").text(JSON.stringify(queue));
	
}
