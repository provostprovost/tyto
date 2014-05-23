(function () {
  $('.assignment-container').on('mouseenter', function() {
    $(this).addClass('animated swing');
  })
  $('.assignment-container').on('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function() {
    $(this).removeClass('animated swing');
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
