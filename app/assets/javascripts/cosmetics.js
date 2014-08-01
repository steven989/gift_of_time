$(function(){
    toggleUserProfileMenu();
    datepicker_userInfo();
    formatTable();
    postVolunteer();
});


// unhide profile option menu on hover user name

function toggleUserProfileMenu() {

    $('#user').off('mouseover').on('mouseover',function(){
        $('.user_options_menu').removeClass('hidden');
    });
    
    $('#user').off('mouseleave').on('mouseleave',function(){
        $('.user_options_menu').addClass('hidden');
    });

        // $('#user').off('click').on('click',function(){
        //         window.open("/user/profile#summary","_self")
        // });
}

// datepicker

function datepicker_userInfo() {
    $('#user_birthday').datepicker({dateFormat: 'yy-mm-dd'});
    $('#gift_expected_completion_date').datepicker({dateFormat: 'yy-mm-dd'});
}

// dimmed page message

function dimmedModalMessage(message) {
    $('.basic.modal .content .message').html(message)
    $('.basic.modal').modal('show');
    $('.basic.modal .content .button').off('click').on('click',function(){
      $('.basic.modal').modal('hide');
  });  
}

// format as table using plugin (DataTable)

function formatTable() {
    $('#volunteer_bulletin').DataTable({
        "order": [[ 7, "desc" ]]
    });

    $('#admin_users').DataTable({
        "order": [[ 9, "desc" ]]
    });

    $('#admin_gifts').DataTable({
        "order": [[ 16, "desc" ]]
    });

    $('#admin_volunteers').DataTable({
        "order": [[ 9, "desc" ]]
    });
}

// show post volunteer form

function postVolunteer() {
    $('.add_volunteer_button').off('click').on('click',function(){
        $('.popup_form_background').css({
            'min-height': $(document).height()
        });
        toggleVisibility.call($('.popup_form_background'))
    });

    $('.popup_form_background').off('click').on('click',function(){
        toggleVisibility.call($('.popup_form_background'))
    });

    $('.popup_form_background .popup_form').off('click').on('click',function(){
        event.stopPropagation();
    });

    $('.popup_form_background .popup_form .button').off('click').on('click',function(){
        toggleVisibility.call($('.popup_form_background'))
    });

}

// toggle visibility
function toggleVisibility() {
    if ($(this).hasClass('hidden')) {
        $(this).removeClass('hidden');
    } else {
        $(this).addClass('hidden'); 
    };
}