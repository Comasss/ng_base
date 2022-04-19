$(function(){
    $('.container').draggable()

    window.addEventListener('message', function(event){
        let v = event.data

        switch (v.action) {
            case 'showStreet':
                $('.container').fadeIn(500)
                $('.text').html(v.street)
            break;

            case 'hideStreet':
                $('.container').fadeOut(500)
            break;
        }
    })

    document.onkeyup = function(event) {
        if (event.key == 'Escape') {
            $.post('https://fs_streethud/close', JSON.stringify({}));
        }
    }
})