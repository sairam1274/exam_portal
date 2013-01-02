
function show_topics(technology) {
    $(technology).next('ul').slideToggle("slow");
}

$("#question_question_type").live("change", function(){

    if($(this).val()=="multiple")
    {
      $("#list_option_type").show();
      change_option_type("checkbox");
    }
    else if($(this).val()=="single")
    {
      $("#list_option_type").show();
      change_option_type("radio");
    }
    else if($(this).val()=="free_text")
    {
     $("#list_option_type").hide();
    }

});

$("#list_option_type").live("mouseover", function(){

     if($("#question_question_type").val()=="multiple")
    {
      $("#list_option_type").show();
      change_option_type("checkbox");
    }
    else if($("#question_question_type").val()=="single")
    {
      $("#list_option_type").show();
      change_option_type("radio");
    }
    else if($("#question_question_type").val()=="free_text")
    {
     $("#list_option_type").hide();
    }
});

function change_option_type(input_type) {
    $(".is_correct_option").each(function(index) {
        $(this).get(0).type = input_type;
    });
}


$("#question_technology_id").live("change", function(){
    $.ajax({
            url: '/admin/questions/list_option_type?technology_id='+$(this).val(),
            type : "GET",
            success: function(data) {
                $("#question_topic_id").children().remove();
                $("#question_topic_id").append('<option value="">Select Topic</option>');
                $.each(data, function(index, item) {
                   $("#question_topic_id").append("<option value="+ item[1] +">" + item[0] +"</option>")
                     //alert(item[1]);
                 });
            }
        });
})