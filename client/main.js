require("./theme.less");

// IE11支持SVG图标
svg4everybody();

import("./main.html");

Template.preloadAssets.helpers({
    absoluteUrl(url){
        return Steedos.absoluteUrl(url)
    }
});

Meteor.startup(function(){
    if (Steedos.isMobile() && Meteor.settings.public && Meteor.settings.public.mobile && Meteor.settings.public.mobile.enabled == false) {
        $('head meta[name=viewport]').remove();
        $('head').append('<meta name="viewport" content="">');
    }
});