$(function(){
    var $container = $('#items');
    $container.imagesLoaded( function(){
        $container.masonry({
            itemSelector : '.thumbnail'
        });
    });
});
