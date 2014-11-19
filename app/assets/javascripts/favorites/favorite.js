
FAVORITE = {

    favoriteElement: null,
    unfavoriteElement: null,

    favorite: function (elements) {
        elements.one('click', function (e) {
            e.preventDefault();
            e.stopPropagation();

            FAVORITE.favoriteElement = $(this);
            var url = $(this).attr('href');
            FAVORITE.postFavorite(url);
        })
    },

    unfavorite: function (elements) {
        elements.one('click', function (e) {
            e.preventDefault();
            e.stopPropagation();

            FAVORITE.unfavoriteElement = $(this);
            var url = $(this).attr('href');
            FAVORITE.deleteFavorite(url);
        })
    },

    postFavorite: function (url) {
        $.post(url).success(FAVORITE.changeUnfavoriteLinks());
    },

    deleteFavorite: function (url) {
        $.ajax({
            url: url,
            method: 'DELETE',
            success: FAVORITE.changeFavoriteLinks()
        })
    },

    changeFavoriteLinks: function () {
        var href = FAVORITE.unfavoriteElement.attr('href');

        $("a[href='" + href + "']").each(function () {
            FAVORITE.deincrementFavoriteCount(this);
            $(this).text('Favorite');
            FAVORITE.favorite($(this));
        });
    },

    changeUnfavoriteLinks: function () {
        var href = FAVORITE.favoriteElement.attr('href');

        $("a[href='" + href + "']").each(function () {
            FAVORITE.incrementFavoriteCount(this);
            $(this).text('Unfavorite');
            FAVORITE.unfavorite($(this));
        });
    },

    incrementFavoriteCount: function (element) {
        var div = $(element).siblings('span').find('.favorite-count');
        var count = (parseInt(div.attr('data-count')) + 1).toString();

        div.empty();

        div.append(count);
    },

    deincrementFavoriteCount: function (element) {
        var div = $(element).siblings('span').find('.favorite-count');
        var count = (div.attr('data-count'));

        div.empty();

        div.append(count);
    }
};
