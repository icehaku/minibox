$(document).ready(function () {
  $("#main_checkbox_list").click(function () {
    $("[data-checkbox-item]").attr('checked', this.checked);
  });
});
