SEARCH = {
    search: function () {
        $('#search-form').submit(function (e) {
            e.preventDefault();
            $('#rant-list').empty();

            var searchTerm = $('#search-value').val();
            var data = {search: {search_term: searchTerm}};

            $.ajax({
                url: '/searches',
                data: data,
                method: 'GET',
                success: function (rants) {
                    if (rants.length > 0) {
                        for (i = 0; i < rants.length; i++) {
                            $('#rant-list').append('<li id="single-rant">' +
                                rants[i].text);
                        }
                    } else {
                        $('#rant-list').append('No Results Match Your Search')
                    }
                }
            })
        })
    }
};



