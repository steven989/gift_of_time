$(function(){
    createGift();
    adminEdit();
});


// Create gift button

function createGift() {
    $('#create_gift').off('click').on('click',function(){
        event.preventDefault();
        $.ajax({
            url:  $(this).parent().attr('action'),
            type: 'POST',
            dataType: 'json',
            data: $(this).parent().serialize()
        }).done(function(data){
            var message = data.message;
            dimmedModalMessage(message);
            $('.basic.modal .content .button').on('click',function(){window.location.replace(data.redirect_url)});
        });
    });
}

function adminEdit() {
    $('.admin_update').off('click').on('click',function(){
        $.ajax({
            url: $(this).attr('href'),
            type: 'GET',
            dataType: 'html',
            data: {
                resource: $(this).data('resource'),
                id: $(this).data('id')
            }
        }).done(function(data){
            $('.popup_form').html(data);
            toggleVisibility.call($('.popup_form_background'));
            adminUpdate();
        });
    });
}

function adminUpdate() {
    $('.admin_update_send').off('click').on('click',function(){
        event.preventDefault();
        $.ajax({
            url:  $(this).parent().attr('action'),
            type: 'PUT',
            dataType: 'json',
            data: $(this).parent().serialize()
        }).done(function(data){
            if (data.message == "") {
            var message = "Update successful"
            dimmedModalMessage(message);
            $('.popup_form_background').css({
                'min-height': $(document).height()
            });
            $('.basic.modal .content .button').on('click',function(){window.location.replace(data.redirect_url)});
            } else {
            var message = data.message;
            dimmedModalMessage(message);
            $('.popup_form_background').css({
                'min-height': $(document).height()
            });
            };    
        });
    })
}