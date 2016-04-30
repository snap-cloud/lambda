function addConfigFormRow(evt) {
  if (evt) { evt.preventDefault(); }
  var rows = $('.key-value-group');
  var row = rows.first().clone();
  var num = rows.length + 1;
  row.find('input').each(function (idx, item) {
    $(item).attr('id', 'configuration_value_' + num);
    $(item).attr('name', 'configuration_value[' + num + ']');
    $(item).val(null);
  });
  row.find('select').each(function (idx, item) {
    $(item).attr('id', 'configuration_key_' + num);
    $(item).attr('name', 'configuration_key[' + num + ']');
    $(item).val(null);
  });
  $('.key-value-body').append(row);
}