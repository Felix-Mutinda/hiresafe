$(document).ready(function() {
    let lnmBtn = $("#lnm-initiate");
    let url = "/payments/stk_push";
    
    lnmBtn.click(function(e) {
        // disable btn to avoid multiple requests
        $(this).prop("disabled",true);
        $(this).text("Processing...");
        
        $.get(url, function(data, status, xhr) {
            if (data.ResponseCode == "0") {
                $("body").prepend(
                    "<p class='alert alert-info'>Refresh page to update payment</p>"   
                );
            } else {
                $("body").prepend(
                    "<p class='alert alert-info'>Unable to complete payment, please try again</p>"   
                );
            }
        });
    });
});