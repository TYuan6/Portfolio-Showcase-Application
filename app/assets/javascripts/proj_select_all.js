    RP1 = {
        setup: function() {
            // construct new DOM elements
            $('th[class*=all_group]').each(function(){
                var className = $(this).attr('class')
                $(this).replaceWith($('<th><label for="filter" class="explanation">' +
                    'Select All' +
                    '</label>' +
                    '<input type="checkbox" id="filter" class=' + className + ' /></th>'));
            });
            $('input[class*=all_group]').each(function(){
                $(this).change(RP1.select_group());
            });
            
        },
        select_group: function(){
            var checkBoxClass = $(this).attr('class')
            checkBoxClass = checkBoxClass.substring(4, checkBoxClass.length)
            if ($(this).is(':checked')){
                $('td[class=' + checkBoxClass + ']').each(function(){
                    $(this).prop("checked", true)
                });
            }
            else{
                $('td[class=' + checkBoxClass + ']').each(function(){
                    $(this).prop("checked", false)
                });
            }
            
        }
    };
    $(RP1.setup);       // when document ready, run setup code
    

