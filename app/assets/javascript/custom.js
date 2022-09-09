$(document).ready(function () {
    // Check update
    $('input[type=checkbox]').on('click', function() {
        $.post($('#HTTP_SERVER').val() + 'tasks/' + $(this).attr('data-id') + '/check', {
            task: { checked: $(this).prop('checked') }
        }, function (response) {
            // console.log(response);
        });
        $(this).closest('li').toggleClass( 'checked' );
    });

    $('.accordion-toggle').on('click', function() {
        $(this).closest('li').toggleClass( 'pb-0' );
    });
});

// validate 
$(document).ready(function () {
  $("form").on("submit", function() {
    let submit = $(this).find("input[type=submit]");
    submit.attr("disabled", "disabled");
    setTimeout(function () {
      submit.removeAttr("disabled");
    }, 3000);
  });
});

$(document).on("focus", "input[name*='date']", function() {
  $(this).mask('00/00/0000 00:00:00', {reverse: false});
});