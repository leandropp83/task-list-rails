$(document).ready(function () {
    // Check update
    $('input[type=checkbox]').on('click', function() {
        // let token = $(this).parents('form').find('input[name=authenticity_token]').val();
        $.ajax({
          type: "POST",
          url: $('#HTTP_SERVER').val() + 'tasks/' + $(this).attr('data-id') + '/check',
          data: {
              task: { checked: $(this).prop('checked') }
          },
          beforeSend(xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
          },
          success: function () {
            location.reload(); // até ajustar os gráficos para atualizarem via js também
          }
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