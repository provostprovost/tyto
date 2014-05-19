(function () {
  var $container = $('.isotope-container');

  $container.isotope({
    itemSelector: '.assignment-li',
    layoutMode: 'fitRows',
    getSortData: {
      deadline: '.deadline'
    },
    sortBy: 'deadline',
    filter: '.incomplete'
  });

  $('#filters, #classroom-container').on('click', 'a', function() {
    var filterValue = $(this).attr('data-filter');
    $container.isotope({ filter: filterValue });
    $('#filters dd').removeClass('active');
    $(this).closest('dd').addClass('active');
  });
})();


