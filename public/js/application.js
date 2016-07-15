$(document).ready(function(){
	$balChar = 140 - $('textarea').val().length;
	$('#new_status').append('<h1>'+$balChar+'</h1>');

	$('textarea').on('input change', function(){
		$balChar = 140 - $('textarea').val().length;
		$('#new_status h1').remove();
		$('#new_status').append('<h1>'+$balChar+'</h1>');
		if ($balChar < 1 || $balChar >139 ){
			$('button').attr("disabled", "true");
		}else{
			$('button').removeAttr("disabled");
		}
		
	})



});