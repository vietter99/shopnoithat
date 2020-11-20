if ($("#login-form").length) {
    $("#login-form").validate({
        rules: {
            email: {
                required: true,
                minlength: 6,
                email:true
            },
            password: {
                required: true,
                minlength: 8
            },
        },
        messages: {
            email: {
                required:'Không được bỏ trống',
                minlength: 'Điền ít nhất 6 ký tự',
                email:'Bạn nhập email sai định dạng',
            },
            password: {
                required:'Không được bỏ trống',
                minlength: 'Điền ít nhất 8 ký tự',
            },
        }


    });
}

$("#login-form").submit(function(e) {
    e.preventDefault(); // avoid to execute the actual submit of the form.
    var form = $(this);
    var url = form.attr('action');
    if( form.valid() ) {
        $.ajax({
            method: "POST",
            url: url,
            data: form.serialize(),
            dataType: "json",
            beforeSend: function () {
            },
            success: function (result) {
                console.log(result);
                if (result.code == 1) {
                    const Toast = Swal.mixin({
                        toast: true,
                        position: 'top-end',
                        showConfirmButton: false,
                        timer: 1000,
                        timerProgressBar: true,

                    });
                    Toast.fire({
                        icon: 'success',
                        title: 'Đăng nhập thành công',

                    });
                    if (Toast) {
                        window.location = baseURL + 'project';
                    }
                } else {
                    swal.fire("Lỗi!", result.message, "warning");
                    $("#login-form").trigger("reset");
                }
            },
            error: function () {
                console.log('Lỗi Ajax!!')
            },
        });
    }
});
$("#register-form").submit(function(e) {
    e.preventDefault(); // avoid to execute the actual submit of the form.
    var form = $(this);
    var url = form.attr('action');
    console.log(form);
    $.ajax({
        method: "POST",
        url: url,
        data: form.serialize(),
        dataType: "json",
        beforeSend: function () {
        },
        success: function (result) {
            console.log(result);
            if (result.code == 1) {
                const Toast = Swal.mixin({
                    toast: true,
                    position: 'top-end',
                    showConfirmButton: false,
                    timer: 1000,
                    timerProgressBar: true,

                });
                Toast.fire({
                    icon: 'success',
                    title: 'Đăng kí thành công',

                });
                if (Toast) {
                    window.location = baseURL +'admin/login';
                }
            }
        },
        error: function () {
            console.log('Lỗi Ajax!!')
        },
    });
});
$("#profile-form").submit(function(e) {
    e.preventDefault(); // avoid to execute the actual submit of the form.
    var form = $(this);
    var url = form.attr('action');
    console.log(form);
    $.ajax({
        method: "POST",
        url: url,
        data: form.serialize(),
        dataType: "json",
        beforeSend: function () {
        },
        success: function (result) {
            console.log(result);
            // if (result.code == 1) {
            //     swal({
            //         title: "Chúc mừng!",
            //         text: result.message,
            //         type: "success",
            //         showCancelButton: false,
            //         confirmButtonClass: "btn-success",
            //         confirmButtonText: "Xác nhận",
            //         closeOnConfirm: true
            //     });
            // }else{
            //     swal("Lỗi!",result.message, "warning");
            // }
        },
        error: function () {
            console.log('Lỗi')
        },
    });
});

