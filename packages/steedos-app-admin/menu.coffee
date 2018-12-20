
# Menu 支持两种类型的参数
# - template_name 指向 Meteor Template, url=/app/admin/_template/{template_name}/
# - object_name 指向对象, url=/app/admin/{object_name}/grid/all/
Creator.Menus.push( 
    { _id: 'account', name: '我的账户', permission_sets: ["user"], sort: 10, expanded: false },
    # { _id: 'account_personal', name: '个人信息', permission_sets: ["user"], template_name: "account_personal", parent: 'account', sort: 10 },
    { _id: 'account_avatar', name: '头像', permission_sets: ["user"], template_name: "account_avatar", parent: 'account', sort: 20 },
    { _id: 'account_setting', name: '账户', permission_sets: ["user"], template_name: "account_setting", parent: 'account', sort: 30 },
    { _id: 'account_password', name: '密码', permission_sets: ["user"], template_name: "account_password", parent: 'account', sort: 40 },
    { _id: 'account_background', name: '背景图', permission_sets: ["user"], template_name: "account_background", parent: 'account', sort: 50 }

    { _id: 'menu_users', name: '用户', permission_sets: ["admin"], sort: 20, expanded: false },
    { _id: 'organizations', name: '部门', permission_sets: ["admin"], object_name: "organizations", parent: 'menu_users', sort: 10 },
    { _id: 'space_users', name: '用户', permission_sets: ["admin"], object_name: "space_users", parent: 'menu_users', sort: 20 },
    { _id: 'permission_set', name: '权限组', permission_sets: ["admin"], object_name: "permission_set", parent: 'menu_users', sort: 30 },
    { _id: 'spaces', name: '公司信息', permission_sets: ["admin"], object_name: "spaces", parent: 'menu_users', sort: 40 },
    { _id: 'contacts_limit', name: '通讯录权限', permission_sets: ["admin"], template_name: "contacts_settings", parent: 'menu_users', sort: 50 },
    
    { _id: 'about', name: '关于', permission_sets: ["user"], template_name: "creator_about", sort: 1000 },
);