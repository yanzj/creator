Creator.Objects.archive_document = 
	name: "archive_document"
	icon: "drafts"
	label: "文件归档"
	enable_search: true
	enable_files: true
	enable_api: true
	open_window: false
	fields:
		classification:
			type: "lookup"
			label: "流程分类"
			reference_to: "categories"
		flow:
			type: "lookup"
			label: "流程"
			reference_to: "flows"
			depend_on: ["classification"]
			filtersFunction: (filters, context) ->
    			console.log('filtersFunction', filters, context);
    			if _.isArray(context?.classification)
     				return {category: {$in: context.classification}}
   				else if _.isString(context?.classification) && !_.isEmpty(context?.classification)
     				return {category: context.classification}
		name:
			type: "text"
			label: "标题"
			sortable: true
			default_width: 600
		flow_name:
			type: "text"
			label: "流程名称"
			hidden: true
			default_width: 300
		submitter:
			type: "lookup"
			label: "提交人"
			reference_to: "users"
			default_width: 150
		organization:
			type: "text"
			label: "部门"
			hidden: true
		submit_date:
			type: "datetime"
			label: "提交时间"
			sortable: true
			default_width: 180
		archive_date:
			type: "datetime"
			label: "归档时间"
			sortable: true
			hidden: true
			default_width: 180
		outbox_users:
			type: "[text]"
			label: "处理人"
			omit: true
			hidden: true
		external_id:
			type:"text"
			label:'表单ID'
			hidden: true
		state:
			type: "text"
			label: "审批结果"
			hidden: true

	list_views:
		submit:
			label:"我发起的"
			filter_scope: "space"
			filters: [["submitter", "=", "{userId}"]]
			columns:["name","flow_name","submitter","submit_date","archive_date"]
			sort: [{field_name: "submit_date", order: "desc"}]
		approved:
			label:"我审核的"
			filter_scope: "space"
			filters: [["outbox_users", "=", "{userId}"]]
			columns:["name","flow_name","submitter","submit_date","archive_date"]
			sort: [{field_name: "submit_date", order: "desc"}]
		# all:
		# 	label: "全部"
		# 	filter_scope: "space"
		# 	filters: [["submitter", "=", "{userId}"],["outbox_users", "=", "{userId}"]]
		# 	columns:["name","flow_name","submitter","submit_date","archive_date"]
	
	permission_set:
		user:
			allowCreate: false
			allowDelete: false
			allowEdit: false
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

	actions:
		standard_view:
			label: "查看表单"
			visible:true
			on: "record"
			todo:(object_name, record_id)->
				if record_id
					Meteor.call "archive_view", record_id, (error,result) ->
						if result 
							if result == ""
								toastr.error "未找到html！"							
							console.log "result",result
							Steedos.openWindow(result)


		