var aceUploads = {
  uploadsAdded: 1,

  getParameterByName: function(name) {
   	var match = RegExp('[?&]' + name + '=([^&]*)').exec(window.location.search);
  	return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
  },

  newUploadRow: function() {
    params = { count: aceUploads.uploadsAdded++ };
    template = _.template($('#upload_row').html());
    rowHtml = template(params);
    $("#additional_attachments tbody").append(rowHtml);
  },

  setupAddButtonListener: function() {
    $("#addButton").click(function () {
      if(aceUploads.uploadsAdded>10){
        alert("You can only upload 10 attachments at one time.");
        return false;
      } else {
        aceUploads.newUploadRow();
      }
    });
  },

  setupRemoveButtonListener: function() {
    $("#removeButton").click(function () {
      if(aceUploads.uploadsAdded==2)
      {
        alert("There are no additional attachments.");
        return false;
      } else {
        $("#additional_attachments tbody tr:last").remove();
        aceUploads.uploadsAdded--;
      }
    });
  }
}

$(document).ready(function(){
  if ($("#related_customer").length > 0){
    _.templateSettings = { interpolate : /\{\{(.+?)\}\}/g };
    
    aceUploads.newUploadRow();

    var related_customer = aceUploads.getParameterByName("cust_id");
    document.getElementById("related_customer").value = related_customer.toString();

    aceUploads.setupAddButtonListener();
    aceUploads.setupRemoveButtonListener();
  }
});

