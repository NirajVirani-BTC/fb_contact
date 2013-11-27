$(document).ready(function(){
	
	$('#review_rating').raty({half:  true,});

	$(".blockUI").on("click",
    function(event) {
      $.blockUI({ css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
        opacity: .5, 
        color: '#fff' 
    	} 
  	}); 
	});

});