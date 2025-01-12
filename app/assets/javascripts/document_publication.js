(function() {
  $(document).on("click", ".associated_authors a.icon_action_user_list", function(e) {
    e.preventDefault();
    $(this).after($.response_from_simple_remote_resource(this.href));
    return false;
  });

  $(document).on("click", ".icon_action_close_author_list", function(e) {
    e.preventDefault();
    $(this).parent().parent().parent().remove();
    return false;
  });

  $(document).on("click", ".author_action a", function(e, elements) {
    var html;
    e.preventDefault();
    html = $.response_from_simple_remote_resource(this.href);
    $(this).parent().parent().replaceWith(html);
    return false;
  });

  $(document).on("click", ".role_list ul li a", function(e) {
    var href, html;
    e.preventDefault();
    href = $(this).attr("data-remote-resource");
    html = $.response_from_remote_resource(href);
    $(this).parent().parent().parent().parent().parent().parent().replaceWith(html);
    return false;
  });

  $(document).on("click", ".role_action a.action_link", function(e) {
    e.preventDefault();
    $(this).after($.response_from_simple_remote_resource(this.href));
    return false;
  });

  $(document).on("click", "#new_checkbox", function() {
    var href;
    href = $(this).parent().attr("data-remote-resource");
    $.dialog_for_new_checkbox(href);
    return $(".chosen-select").chosen();
  });

  $(document).on("click", "#new_checkbox_form input[type=submit]", function(e) {
    var assoc_name, class_name, content, html, new_id, object, options, p, regexp, url;
    e.preventDefault();
    class_name = this.parentNode.parentNode.getAttribute("data-class-name");
    p = $.param($("#new_checkbox_form").serializeArray());
    url = $("#new_checkbox_form").attr("action") + '.js';
    options = {
      url: url,
      type: "POST",
      data: p,
      async: false
    };
    object = jQuery.parseJSON($.ajax(options).responseText);
    content = $("#" + class_name).find(".fields_template")[0];
    assoc_name = $("#" + class_name).attr("data-has-many-association");
    regexp = new RegExp("new_" + assoc_name, "g");
    new_id = new Date().getTime();
    html = $(content).html().replace("-1", object.id).replace("template_string", object.name);
    $($("#" + class_name).find("ul")[0]).append(html.replace(regexp, new_id));
    $("#dialog").dialog("close");
    return $("#dialog").html('');
  });

  $(document).on("click", ".new_period", function(e) {
    e.preventDefault();
    $.dialog_for_new_period(this.href);
    return $(".chosen-select").chosen();
  });

  $(document).on("click", "#new_period_form input[type=submit]", function(e) {
    var options, p, regularcourse_id, url;
    e.preventDefault();
    regularcourse_id = $("#new_period_form").attr("data-regularcourse-id");
    p = $.param($("#new_period_form").serializeArray());
    url = $("#new_period_form").attr("action");
    options = {
      url: url,
      type: "POST",
      data: p,
      async: false
    };
    $($("#regularcourse_" + regularcourse_id).find('.periods ul')[0]).append($.ajax(options).responseText);
    $("#dialog").dialog("close");
    return $("#dialog").html('');
  });

  $(document).on("click", ".delete_period", function(e) {
    e.preventDefault();
    return $(this).parent().remove();
  });

  $(document).on("change", ".radio-set-thesisstatus", function(e) {
    var new_label;
    if (this.name === "thesis[thesisstatus_id]" && this.checked) {
      if (this.value === "3") {
        new_label = "<abbr title=\"required\">*</abbr>Fecha de presentación de examen";
        return $("label[for=thesis_end_date]").html(new_label);
      } else {
        new_label = "<abbr title=\"required\">*</abbr>Fecha estimada de presentación de examen";
        return $("label[for=thesis_end_date]").html(new_label);
      }
    }
  });

}).call(this);
