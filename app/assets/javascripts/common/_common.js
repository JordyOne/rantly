SITE = {
    common: {
        init: function () {
            FOLLOW.follow($('.follow-link'));
            FOLLOW.unfollow($('.unfollow-link'));

            RANT.rantPostHandler();
            FAVORITE.favorite($('.favorite-button-link'));
            FAVORITE.unfavorite($('.unfavorite-button-link'));
        }
    },
    users: {}
};

UTIL = {
    exec: function (controller, action) {
        var ns = SITE,
            action = (action === undefined) ? "init" : action;

        if (controller !== "" && ns[controller] && typeof ns[controller][action] == "function") {
            ns[controller][action]();
        }
    },

    init: function () {
        var body = document.body,
            controller = body.getAttribute("data-controller"),
            action = body.getAttribute("data-action");

        UTIL.exec("common");
        UTIL.exec(controller);
        UTIL.exec(controller, action);
    }
};

$(document).ready(UTIL.init);