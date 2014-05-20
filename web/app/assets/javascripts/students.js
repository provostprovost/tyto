(function () {
  $('.assignment-container').on('mouseenter', function() {
    $(this).addClass('animated swing');
    console.log(this);
    console.log('i should be swinging');
  })
  $('.assignment-container').on('mouseleave', function() {
    $(this).addClass('animated swing');
    console.log(this);
    console.log('i should stop swinging');
  })
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

$("input[type='tel']").keyup(function() {
    var curchr = this.value.length;
    var curval = $(this).val();
    if (curchr == 3) {
        $(this).val("(" + curval + ")" + "-");
    } else if (curchr == 9) {
        $(this).val(curval + "-");
    }
});
