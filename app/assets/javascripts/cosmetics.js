$(function(){
    toggleUserProfileMenu();
    datepicker_userInfo();
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
    $('.user_info #user_birthday').datepicker();
}