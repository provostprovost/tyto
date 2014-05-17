(function () {
  var $container = $('.isotope-container');

  $container.isotope({
    itemSelector: '.assignment-li',
    layoutMode: 'fitRows'
  });

  $('#filters').on('click', 'a', function() {
    var filterValue = $(this).attr('data-filter');
    $container.isotope({ filter: filterValue });
  });
})();


