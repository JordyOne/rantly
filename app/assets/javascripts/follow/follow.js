FOLLOW = {
    follow: function (elements) {
        elements.one('click', function (e) {
            e.preventDefault();
            e.stopPropagation();

            FOLLOW.followElement = $(this);
            url = $(this).attr('href');
            FOLLOW.postFollow(url);
        })
    },

    unfollow: function (elements) {
        elements.one('click', function (e) {
            e.preventDefault();
            e.stopPropagation();

            FOLLOW.unfollowElement = $(this);
            var url = $(this).attr('href');

            FOLLOW.deleteFollow(url);
        })
    },

    postFollow: function (url) {
        var followerId = url.split('/')[2];
        var followedId = url.split('=').pop();
        var data = {relationship: {
                        follower_id: followerId,
                        followed_id: followedId
                        }
                    };
        $.ajax({
            url: '/users/' + followerId + '/relationships',
            data: data,
            method: 'POST',
            success: FOLLOW.switchFollowLinks()
        })
    },

    deleteFollow: function (url) {
        var followerId = url.split('/')[2];
        var followedId = url.split('/').pop();
        var data = {relationship: {
                        follower_id: followerId,
                        followed_id: followedId
                        }
                    };
        $.ajax({
            url: '/users/' + followerId + '/relationships/' + followedId,
            data: data,
            method: 'DELETE',
            success: FOLLOW.switchUnfollowLinks()
        })
    },

    switchUnfollowLinks: function () {
        var href = FOLLOW.unfollowElement.attr('href');
        var otherUserId = href.split('/').pop();
        var currentUserId = href.split('/')[2];

        $('a[href="' + href + '"]').each(function () {
            $(this).text('Follow')
                .attr('href', '/users/' + currentUserId +
                        '/relationships?id=' + otherUserId)
                .attr('data-method', 'post')
                .attr('class', 'follow-link');
            FOLLOW.follow($(this));
        });
    },

    switchFollowLinks: function () {
        var href = FOLLOW.followElement.attr('href');
        var otherUserId = href.split('=').pop();
        var currentUserId = href.split('/')[2];

        $('a[href="' + href + '"]').each(function () {
            $(this)
                .text('Unfollow')
                .attr('href', '/users/' + currentUserId +
                        '/relationships/' + otherUserId)
                .attr('data-method', 'delete')
                .attr('class', 'unfollow-link');
            FOLLOW.unfollow($(this));
        });
    }
};