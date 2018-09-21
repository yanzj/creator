Creator.Objects.love_friends =
	name: "love_friends"
	label: "好友"
	icon: "event"
	enable_search: true
	fields:

		user_b:
			label:"第二个用户ID"
			type: "lookup"
			reference_to: "users"
			index: true
			omit: true

		a_to_b:
			label:"我喜欢的"
			type: "number"
			scale: 2
			omit: true

		b_to_a:
			label:"适合我的"
			type: "number"
			scale: 2
			omit: true

		match:
			label:"互相匹配度"
			type: "number"
			scale: 2
			omit: true

		open_group_id:
			label: "群"
			type: "text"
			omit: true

		open_groups:
			label: "群"
			type: "[text]"
			omit: true

		owner:
			label:"第一个用户ID"
			type: "lookup"
			reference_to: "users"
			index: true
			omit: true

		heart:
			label: "点“心”"
			type: "boolean"
			omit: true

		heart_at:
			label: "点“心”时间"
			type: "datetime"
			omit: true

		star:
			label: "收录"
			type: "boolean"
			omit: true

		star_at:
			label: "收录时间"
			type: "datetime"
			omit: true

		is_looking_for:
			label: "是否满足筛选条件"
			type: "boolean"
			omit: true

		source:
			label: "分享来源"
			type: "text"
			omit: true

		view_count:
			label:"名片查看次数"
			type: "number"
			omit: true
		
		from:
			label: '名片推荐人'
			type: 'lookup'
			reference_to: 'users'
			omit: true

	list_views:
		all:
			label: "所有"
			columns: ["name"]
			filter_scope: "space"

	permission_set:
		user:
			allowCreate: false
			allowDelete: false
			allowEdit: true
			allowRead: true
			modifyAllRecords: false
			viewAllRecords: true
		admin:
			allowCreate: true
			allowDelete: true
			allowEdit: true
			allowRead: true
			modifyAllRecords: true
			viewAllRecords: true
		member:
			allowCreate: false
			allowDelete: false
			allowEdit: true
			allowRead: true
			modifyAllRecords: false
			viewAllRecords: true
		guest:
			allowCreate: false
			allowDelete: false
			allowEdit: true
			allowRead: true
			modifyAllRecords: false
			viewAllRecords: true

	triggers:
		"before.update.server.love_friends":
			on: "server"
			when: "before.update"
			todo: (userId, doc, fieldNames, modifier, options)->
				if modifier?.$set?.heart
					modifier.$set.heart_at = new Date()
				if modifier?.$set?.star
					modifier.$set.star_at = new Date()


if Meteor.isServer
	Meteor.startup ->
		Creator.getCollection('love_friends')._ensureIndex({
			"owner": 1,
			"user_b": 1
		},{background: true, unique: true})