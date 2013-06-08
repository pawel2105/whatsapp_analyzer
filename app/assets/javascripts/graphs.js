google.load('visualization', '1.0', {'packages':['corechart']});
google.setOnLoadCallback(drawChart);

function drawChart() {

	if (document.getElementById('word_one')) {

		// Word 1 chart
		var word_one_graph = new google.visualization.DataTable();
		word_one_graph.addColumn('string', 'User');
		word_one_graph.addColumn('number', 'Uses');

		var word_one_array = [];
		var length_of_word_one_array = word_one.length;
		for(var i=0;i<length_of_word_one_array;i++){
			word_one_array.push([word_one[i][0],word_one[i][1]]);
		}
		word_one_graph.addRows(word_one_array);

		var total_for_word_one = []
		for (i=0;i<word_one.length;i++) {
			total_for_word_one.push(word_one[i][1]);
		}

		var sum_for_word_one = total_for_word_one.reduce(function(pV, cV){
	    return cV + pV;
		});

		var options = {'title': ' (' + sum_for_word_one + ' total)',
		               'width':400,
		               'height':300};

		var chart = new google.visualization.PieChart(document.getElementById('word_one'));
		chart.draw(word_one_graph, options);

		// Word 2 chart
		var word_two_graph = new google.visualization.DataTable();
		word_two_graph.addColumn('string', 'User');
		word_two_graph.addColumn('number', 'Uses');

		var word_two_array = [];
		var length_of_word_two_array = word_two.length;
		for(var i=0;i<length_of_word_two_array;i++){
			word_two_array.push([word_two[i][0],word_two[i][1]]);
		}
		word_two_graph.addRows(word_two_array);

		var total_for_word_two = []
		for (i=0;i<word_two.length;i++) {
			total_for_word_two.push(word_two[i][1]);
		}

		var sum_for_word_two = total_for_word_two.reduce(function(pV, cV){
	    return cV + pV;
		});

		var options = {'title': ' (' + sum_for_word_two + ' total)',
		               'width':400,
		               'height':300};

		var chart = new google.visualization.PieChart(document.getElementById('word_two'));
		chart.draw(word_two_graph, options);

		// Word 3 chart
		var word_three_graph = new google.visualization.DataTable();
		word_three_graph.addColumn('string', 'User');
		word_three_graph.addColumn('number', 'Uses');

		var word_three_array = [];
		var length_of_word_three_array = word_three.length;
		for(var i=0;i<length_of_word_three_array;i++){
			word_three_array.push([word_three[i][0],word_three[i][1]]);
		}
		word_three_graph.addRows(word_three_array);

		var total_for_word_three = []
		for (i=0;i<word_three.length;i++) {
			total_for_word_three.push(word_three[i][1]);
		}

		var sum_for_word_three = total_for_word_three.reduce(function(pV, cV){
	    return cV + pV;
		});

		var options = {'title': ' (' + sum_for_word_three + ' total)',
		               'width':400,
		               'height':300};

		var chart = new google.visualization.PieChart(document.getElementById('word_three'));
		chart.draw(word_three_graph, options);

	}

	// Swearwords per user
	var swearwords_graph = new google.visualization.DataTable();
	swearwords_graph.addColumn('string', 'User');
	swearwords_graph.addColumn('number', 'Count');

	var swearword_array = [];
	var length_of_swearword_array = swearwords.length;
	for(var i=0;i<length_of_swearword_array;i++){
		swearword_array.push([swearwords[i][0],swearwords[i][1]]);
	}
	swearwords_graph.addRows(swearword_array);

	var total_for_swearwords = []
		for (i=0;i<swearwords.length;i++) {
			total_for_swearwords.push(swearwords[i][1]);
		}

		var sum_for_swearwords = total_for_swearwords.reduce(function(pV, cV){
	    return cV + pV;
		});

	var swearword_options = {'title':'Swearwords ( ' + sum_for_swearwords + ' total)', 'colors': ['#917130'], 'legend': 'none'};

	var chart = new google.visualization.ColumnChart(document.getElementById('long_swearwords'));
	chart.draw(swearwords_graph, swearword_options);

	// Create the most frequent messages table.
	var jew_data = new google.visualization.DataTable();
	jew_data.addColumn('string', 'User');
	jew_data.addColumn('number', 'Count');
	var empty_array = [];
	var length_of_array = most_frequent.length;
	for(var i=0;i<length_of_array;i++){
		empty_array.push([most_frequent[i][0],most_frequent[i][1]]);
	}
	jew_data.addRows(empty_array);

	var jew_options = {'title':'Most frequent words', 'height':300, 'colors': ['#EC7404'], 'legend': 'none'};

	var chart = new google.visualization.ColumnChart(document.getElementById('most_frequent'));
	chart.draw(jew_data, jew_options);

	// Messages per user chart
	var total_messages_in_chat = []
	for (i=0;i<msgs_per_user.length;i++) {
		total_messages_in_chat.push(msgs_per_user[i][1]);
	}

	var sum_of_chats = total_messages_in_chat.reduce(function(pV, cV){
    return cV + pV;
	});

	var msgs_per_user_graph = new google.visualization.DataTable();
	msgs_per_user_graph.addColumn('string', 'User');
	msgs_per_user_graph.addColumn('number', 'Count');

	var msgs_per_user_array = [];
	var length_of_msgs_per_user_array = msgs_per_user.length;
	for(var i=0;i<length_of_msgs_per_user_array;i++){
		msgs_per_user_array.push([msgs_per_user[i][0],msgs_per_user[i][1]]);
	}
	msgs_per_user_graph.addRows(msgs_per_user_array);

	var options = {'title':'Total messages (' + sum_of_chats + ' total)', 'height':300, 'colors': ['green'], 'legend': 'none'};

	var chart = new google.visualization.BarChart(document.getElementById('msgs_per_user'));
	chart.draw(msgs_per_user_graph, options);

}