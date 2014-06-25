$(function(){
    createGift();
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