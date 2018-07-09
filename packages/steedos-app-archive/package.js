Package.describe({
	name: 'steedos:app-archive',
	version: '0.0.5',
	summary: 'Creator archive',
	git: ''
});

Package.onUse(function(api) {
	api.use('steedos:creator@0.0.5');
	api.use('coffeescript@1.11.1_4');

	api.use('steedos:logger@0.0.2');

	api.addFiles('core.coffee');	
	api.addFiles('client/core.coffee','client');
	api.addFiles('archive.coffee');
	api.addFiles('models/archives/archive_keji.coffee');
	api.addFiles('models/archives/archive_kejiditu.coffee');
	api.addFiles('models/archives/archive_wenshu.coffee');
	api.addFiles('models/archives/archive_kuaiji.coffee');
	api.addFiles('models/archives/archive_kejiditu.coffee');
	api.addFiles('models/archives/archive_rongyu.coffee');
	api.addFiles('models/archives/archive_shengxiang.coffee');
	api.addFiles('models/archives/archive_dianzi.coffee');
	api.addFiles('models/archives/archive_tongji.coffee');
	api.addFiles('models/archives/archive_shenji.coffee');
	
	
	api.addFiles('manage.coffee');
	api.addFiles('models/manages/archive_borrow.coffee');
	api.addFiles('models/manages/archive_destroy.coffee');	

	
	api.addFiles('setting.coffee');
	api.addFiles('models/settings/archive_organization.coffee');
	api.addFiles('models/settings/archive_classification.coffee');
	api.addFiles('models/settings/archive_transfer.coffee');
	api.addFiles('models/settings/archive_entity_relation.coffee');
	api.addFiles('models/settings/archive_fonds.coffee');
	api.addFiles('models/settings/archive_retention.coffee');
	api.addFiles('models/settings/archive_rules.coffee');
	api.addFiles('models/settings/archive_audit.coffee');
	api.addFiles('server/methods/archive_borrow.coffee', 'server');
	api.addFiles('server/methods/archive_destroy.coffee', 'server');
	api.addFiles('server/methods/archive_receive.coffee', 'server');
	api.addFiles('server/methods/archive_transfer.coffee', 'server');
	api.addFiles('server/methods/archive_new_audit.coffee', 'server');
	api.addFiles('server/methods/archive_export.coffee', 'server');


})