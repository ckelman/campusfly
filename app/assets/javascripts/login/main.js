jQuery(document).ready(function($){
	var $form_modal = $('.cd-user-modal'),
		$form_login = $form_modal.find('#cd-login'),
		$form_signup = $form_modal.find('#cd-signup'),
		$form_forgot_password = $form_modal.find('#cd-reset-password'),
		$form_school_verification = $form_modal.find('#cd-verify-email'),  /*verify email*/
		$form_modal_tab = $form_modal.find('.cd-switcher'),   // this is adhoc solution. Check it in case of bug with tab switches
		$tab_login = $form_modal_tab.children('li').eq(0).children('a'),
		$tab_signup = $form_modal_tab.children('li').eq(1).children('a'),
		$forgot_password_link = $form_login.find('.cd-form-bottom-message a'),
		$signup_submit = $form_signup.find("p :submit");					/* clicking the submit button of sign up create account */
		$back_to_login_link = $form_forgot_password.find('.cd-form-bottom-message a'),
		$main_nav = $('.navbar-nav');

		//changes for event creation
	var	$event_modal = $('.cd-event-modal'),
		$event_student = $event_modal.find('#cd-student'),
		$event_business = $event_modal.find('#cd-business'),
		$event_transition = $event_modal.find('#cd-event-creation-transition'),
		$event_modal_tab = $event_modal.find('.cd-switcher'),    //same thing as form_modal check for bugs
		$tab_student = $event_modal_tab.children('li').eq(0).children('a'),
		$tab_business = $event_modal_tab.children('li').eq(1).children('a'),
		//$forgot_password_link = $form_login.find('.cd-form-bottom-message a'),
		$student_submit = $event_student.find("p :submit"),					/* clicking the submit button of student organizer ceate account */
		$business_submit = $event_business.find("p :submit"),					/* clicking the submit button of business organizer create account */
		
		$dashboard_view = $event_transition.find('.cd-form-bottom-message a');  //goes to the organization's dashboard



	//open modal
	$main_nav.children("#trigger").on('click', function(event){

		if( $(event.target).is($main_nav) ) {
			// on mobile open the submenu
			$(this).children('ul').toggleClass('is-visible');
		} else {
			// on mobile close submenu
			$main_nav.children('ul').removeClass('is-visible');
			//show modal layer
			$form_modal.addClass('is-visible');	
			//show the selected form
			( $(event.target).is('.cd-signup') ) ? signup_selected() : login_selected();
		}

	});

	//close modal
	$('.cd-user-modal').on('click', function(event){
		if( $(event.target).is($form_modal) || $(event.target).is('.cd-close-form') ) {
			$form_modal.removeClass('is-visible');
		}	
	});
	//close modal when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$form_modal.removeClass('is-visible');
	    }
    });

	//switch from a tab to another
	$form_modal_tab.on('click', function(event) {
		event.preventDefault();
		( $(event.target).is( $tab_login ) ) ? login_selected() : signup_selected();
	});

	//hide or show password
	$('.hide-password').on('click', function(){
		var $this= $(this),
			$password_field = $this.prev('input');
		
		( 'password' == $password_field.attr('type') ) ? $password_field.attr('type', 'text') : $password_field.attr('type', 'password');
		( 'Hide' == $this.text() ) ? $this.text('Show') : $this.text('Hide');
		//focus and move cursor to the end of input field
		$password_field.putCursorAtEnd();
	});

	//show forgot-password form 
	$forgot_password_link.on('click', function(event){
		event.preventDefault();
		forgot_password_selected();
	});

	//show email verification form  <-----------------------------------------------------------------------------add here the function for viewing email verification
	$signup_submit.on('click', function(event){
		event.preventDefault();
		school_verification_selected();
	});

	//back to login from the forgot-password form
	$back_to_login_link.on('click', function(event){
		event.preventDefault();
		login_selected();
	});

	function login_selected(){
		$form_login.addClass('is-selected');
		$form_signup.removeClass('is-selected');
		$form_forgot_password.removeClass('is-selected');
		$form_school_verification.removeClass('is-selected'); //removing .is-selected to the school verification section
		$tab_login.addClass('selected');
		$tab_signup.removeClass('selected');
	}

	function signup_selected(){
		$form_login.removeClass('is-selected');
		$form_signup.addClass('is-selected');
		$form_forgot_password.removeClass('is-selected');
		$form_school_verification.removeClass('is-selected'); //removing .is-selected to the school verification section
		$tab_login.removeClass('selected');
		$tab_signup.addClass('selected');
	}

	function forgot_password_selected(){
		$form_login.removeClass('is-selected');
		$form_signup.removeClass('is-selected');
		$form_school_verification.removeClass('is-selected');   //removing .is-selected to the school verification section
		$form_forgot_password.addClass('is-selected');
	}

	/*After Sign Up, School Verification*/
	function school_verification_selected(){
		$form_login.removeClass('is-selected');
		$form_signup.removeClass('is-selected');
		$form_forgot_password.removeClass('is-selected');
		$form_school_verification.addClass('is-selected');     //adding .is-selected to the school verification section
	}

	

	





	/*
					event user changes


	*/
	//open modal
	$("#CreateEvent").on('click', function(event){
			//show modal layer
			$event_modal.addClass('is-visible');	
			//show the selected form
			student_selected();
		});

	//close modal
	$('.cd-event-modal').on('click', function(event){
		if( $(event.target).is($event_modal) || $(event.target).is('.cd-close-form') ) {
			$event_modal.removeClass('is-visible');
		}	
	});

	//close modal when clicking the esc keyboard button
	$(document).keyup(function(event){
    	if(event.which=='27'){
    		$event_modal.removeClass('is-visible');
	    }
    });

	//switch from a tab to another
	$event_modal_tab.on('click', function(event) {
		event.preventDefault();
		( $(event.target).is( $tab_student ) ) ? student_selected() : business_selected();
	});

	//show transition section upon submit of Student event
	$student_submit.on('click', function(event){
		event.preventDefault();
		transition_selected();
	});

	//show transition section upon submit of Business event
	$business_submit.on('click', function(event){
		event.preventDefault();
		transition_selected();
	});



	
	function student_selected(){
		$event_student.addClass('is-selected');
		$event_business.removeClass('is-selected');
		$event_transition.removeClass('is-selected');
		$tab_student.addClass('selected');
		$tab_business.removeClass('selected');
	}

	function business_selected(){
		$event_student.removeClass('is-selected');
		$event_business.addClass('is-selected');
		$event_transition.removeClass('is-selected');
		$tab_student.removeClass('selected');
		$tab_business.addClass('selected');
	}	

	function transition_selected(){
		$event_student.removeClass('is-selected');
		$event_business.removeClass('is-selected');
		$event_transition.addClass('is-selected');
		$tab_student.removeClass('selected');
		$tab_business.removeClass('selected');		
	}


	/*
					end of event user changes


	*/





	//IE9 placeholder fallback
	//credits http://www.hagenburger.net/BLOG/HTML5-Input-Placeholder-Fix-With-jQuery.html
	if(!Modernizr.input.placeholder){
		$('[placeholder]').focus(function() {
			var input = $(this);
			if (input.val() == input.attr('placeholder')) {
				input.val('');
		  	}
		}).blur(function() {
		 	var input = $(this);
		  	if (input.val() == '' || input.val() == input.attr('placeholder')) {
				input.val(input.attr('placeholder'));
		  	}
		}).blur();
		$('[placeholder]').parents('form').submit(function() {
		  	$(this).find('[placeholder]').each(function() {
				var input = $(this);
				if (input.val() == input.attr('placeholder')) {
			 		input.val('');
				}
		  	})
		});
	}

});


//credits http://css-tricks.com/snippets/jquery/move-cursor-to-end-of-textarea-or-input/
jQuery.fn.putCursorAtEnd = function() {
	return this.each(function() {
    	// If this function exists...
    	if (this.setSelectionRange) {
      		// ... then use it (Doesn't work in IE)
      		// Double the length because Opera is inconsistent about whether a carriage return is one character or two. Sigh.
      		var len = $(this).val().length * 2;
      		this.setSelectionRange(len, len);
    	} else {
    		// ... otherwise replace the contents with itself
    		// (Doesn't work in Google Chrome)
      		$(this).val($(this).val());
    	}
	});
};