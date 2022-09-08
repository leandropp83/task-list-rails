const modal = $("#return_msg");

$(document).ready(function () {

    $(document).delegate('form', 'submit', function(e) {
        // e.preventDefault();        
        let controller = $(this).data('id').replace('add-', '');
        // console.log(JSON.parse(JSON.stringify($(this).serializeArray())));
        return true;
        $.post($('#HTTP_SERVER').val() + controller + '/create', {
            // data: JSON.parse(JSON.stringify($(this).serializeArray())),
            // dataType: "json"
            project: { 
                        name: $('input[name="project[name]"]').val(), 
                        date_in: $('input[name="project[date_in]"]').val(),
                        date_end: $('input[name="project[date_end]"]').val(),
                        authenticity_token: $('input[name=authenticity_token]').val()
                    },
            
        }, function (response) {
            console.log(response);
            try {
                json = JSON.parse(response);
                console.log(json);
                if(json.id) {
                    success(json.id, controller);
                }
            } catch(response) {
                console.log(response.responseText);
                fail(response);
            }
        }).fail(function(e) {
            console.log(e.responseText);
            fail('Falha no cadastro');
        });
    });

    $('.close').on('click', function () {
        modal.hide();
    });

    $('input[type=checkbox]').on('click', function() {
        $.post($('#HTTP_SERVER').val() + '/task/check/' + $(this).attr('data-tid'), {
            checked: $(this).prop('checked')
        }, function (response) {
            console.log(response);
        });
        $(this).closest('li').toggleClass( 'checked' );
        location.reload();
    });

    $('.update-project').on('click', function() {
        let parent = $(this).closest('.project-update');
        let name = parent.find('[data-pname]').val();
        let date_in = parent.find('[data-pdatein]').val();
        let date_end = parent.find('[data-pdateend]').val();
        update({'name': name, 'date_in': date_in, 'date_end': date_end}, $(this).attr('data-id'), 'project');
    });

    $('.update-task').on('click', function() {
        let parent = $(this).closest('.task-update');
        let name = parent.find('input[name=name]').val();
        let date_in = parent.find('input[name=date_in]').val();
        let date_end = parent.find('input[name=date_end]').val();
        let checked = parent.find('input[type=checkbox]').prop('checked');
        update({'name': name, 'date_in': date_in, 'date_end': date_end, 'checked': checked}, $(this).attr('data-id'), 'task');
    });

    $('.accordion-toggle').on('click', function() {
        $(this).closest('li').toggleClass( 'pb-0' );
    });

});

function update(obj, id, type)
{
    $.post($('#HTTP_SERVER').val() + '/' + type + '/update/' + id, {
        json: JSON.stringify(obj)
    }, function (response) {
        console.log(response);
        if(parseInt(response) > 0) {
            show_modal({str: 'Projeto editado com sucesso!', type: 'success'});
        } else if(response == '0') {
            fail('Edite um campo para que o projeto seja atualizado');
        } else {
            fail(response);
        }
    });
}

function success(id, selector)
{
    /*
    if(selector === 'task') {
        clone(id, selector);
    }
    */
    $('form input').each(function()  {
        if(!$(this).hasClass('btn')) {
            $(this).val('');
        }        
    });
    //if(selector === 'project') {
        location.reload();
    /*} else {
        show_modal({str: 'Cadastro realizado com sucesso!', type: 'success'});
    }*/
}

function fail(str)
{
    show_modal({str: str, type: 'warning'});
}

function show_modal(obj)
{
    modal.find('strong').text(obj.str);
    $('div[role="alert"]').removeClass('alert-warning').addClass('alert-' + obj.type);
    modal.show();
}

function clone(id, selector)
{
    let ul = $('.'+selector).find('ul').first();
    ul.append('<li class="list-group-item clone">' + $('.clone-' + selector).html() + '</li>');
    let replace = ul.find('.clone').last();
    replace.find('[data-pname]').html($('input[name=name]').val());
    replace.find('[data-pdatein]').html($('input[name=date_in]').val());
    replace.find('[data-pdateend]').html($('input[name=date_end]').val());
    if(selector === 'project') {
        replace.find('.task').attr('id', 'proj' + id);
        replace.find('[data-toggle="collapse"]').attr('data-target', '#proj' + id);
        replace.find('input[name=project_id]').val(id);
    }    
    replace.find('[data-href]').attr('data-href', $("#HTTP_SERVER").val() + "/" + selector + "/delete/" + id);
}

// Modal delete
document.addEventListener("DOMContentLoaded", function(event) {
    $('#confirm-delete').on('show.bs.modal', function(e) {
        $(this).find('.btn-ok').attr('href', $(e.relatedTarget).data('href'));
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