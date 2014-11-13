RANT = {

    rantPostHandler: function () {
        $('#rant-submit-button').click(function (e) {
            e.preventDefault();
            e.stopPropagation();

            $('.errors').empty();

            var url = $('#new_rant').attr('action');
            $.post(url, RANT.produceJson(), function (rant) {
                RANT.clearInputsAndSetFlash(rant)
            }).fail(function () {
                RANT.handleErrors()
            })
        })
    },

    clearInputsAndSetFlash: function (rant) {
        RANT.postRant(rant);
        RANT.setFlash();
        $('#rant_text').val('');
        $('#rant_title').val('');
    },

    produceJson: function () {
        return {rant: {
            text: $('#rant_text').val(),
            title: $('#rant_title').val()
        }}
    },

    setFlash: function () {
        $('.flash')
            .empty()
            .show()
            .append('Your rant has been posted!')
            .fadeOut(5000)
    },

    handleErrors: function () {
        if ($('#rant_text').val() === '') {
            RANT.appendEmptyError($('.rant-error'));
        } else {
            RANT.validateRantLength();
        }

        if ($('#rant_title').val() === '') {
            RANT.appendEmptyError($('.title-error'));
        } else {
            RANT.validateTitleLength();
        }
    },

    appendEmptyError: function (element) {
        element.append("can't be blank");
    },

    validateTitleLength: function () {
        if ($('#rant_title').val().length > 50) {
            $('.title-error').append('is too long (maximum 50 characters)')
        }
    },

    validateRantLength: function () {
        if ($('#rant_text').val().length < 140) {
            $('.rant-error').append('is too short (minimum 140 characters)')
        }
    },

    postRant: function (rant) {
        $.getJSON('/users/' + rant.user_id, function (user) {
            console.log(RANT.formatRant(rant, user));
            $('#user-rants').append(RANT.formatRant(rant, user));
            RANT.fadeInRant();
        });
    },

    formatRant: function (rant, user) {
        return '<div class="single-rant">' + rant.text +
            '<br><a href="/users/' + user.id + '/rants/' + rant.id +
            '" class="rant-delete-link" method="DELETE">Delete</a>'
    },

    fadeInRant: function () {
        $('#user-rants:last-child').fadeIn(3000);
    }
};

