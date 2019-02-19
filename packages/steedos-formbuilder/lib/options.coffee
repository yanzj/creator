# 定义 formBuilder 所有的字段类型
FORMBUILDERFIELDTYPES = ["autocomplete", "paragraph", "header", "select",
	"checkbox-group", "radio-group", "checkbox", "text", "file",
	"date", "number", "textarea",
	"dateTime", "dateNew", "checkboxBoolean", "email", "url", "password", "user", "group",
	"table", "section"]

# 定义 禁用 的字段类型
DISABLEFIELDS = ['button','file','paragraph','autocomplete', 'hidden', 'date', 'header']

# 定义 禁用 的按钮
DISABLEDACTIONBUTTONS = ['clear','data','save']

# 定义 禁用 的字段属性
DISABLEDATTRS = ['description','maxlength','placeholder',"access","value",'min', 'max', 'step', 'inline', 'other', 'toggle', 'rows', 'subtype', 'multiple', 'name']

# 定义字段类型排序
CONTROLORDER = ['table', 'section', 'text','textarea','number','dateNew','dateTime','date','checkboxBoolean','email','url','password','select','user','group',"radio-group","checkbox-group"]

# 获取各字段类型禁用的字段属性
#TYPEUSERDISABLEDATTRS = (()->
#	attrs = {}
#	_.each FORMBUILDERFIELDTYPES, (item)->
#		attrs[item] = DISABLEDATTRS
#		switch item
#			when 'number'
#				attrs[item] = attrs[item].concat(['min', 'max', 'step'])
#	return attrs
#)()

# 定义 通用的 字段属性
BASEUSERATTRS = {
	_id: {
		label: '唯一键'
		readonly: 'readonly'
	},
	default_value: {
		label: '默认值'
		type: 'text'
	},
	is_wide: {
		label: '宽字段',
		type: 'checkbox'
	},
	is_list_display: {
		label: '列表显示',
		type: 'checkbox'
	},
	is_searchable: {
		label: '内容可搜',
		type: 'checkbox'
	}
}

# 定义字段属性：code
CODEUSERATTRS = {
	code: {
		label: '字段名'
		type: 'text'
		required: 'true'
	},
	label: {
		type: 'text'
	}
}

# 定义字段属性: 公式格式
FORMULAUSERATTRS = {
	formula: {
		label: '公式',
		type: 'textarea'
	}
}

# 定义字段属性：多选格式
MULTISELECTUSERATTRS = {
	is_multiselect: {
		label: '多选'
		value: false
		type: 'checkbox'
	}
}

# 定义字段属性: 文本字段options
OPTIONSUSERATTRS = {
	options: {
		label: "选项"
		type: 'textarea'
		placeholder: '选项1\r选项2\r选项3'
	}
}

# 获取各字段类型的属性
getTypeUserAttrs = ()->
	typeUserAttrs = {}
	_.each FORMBUILDERFIELDTYPES, (item)->
		switch item
			when 'select'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, _.pick(BASEUSERATTRS, '_id', 'is_wide', 'is_list_display', 'is_searchable')
			when 'radio-group'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, _.pick(BASEUSERATTRS, '_id', 'is_wide', 'is_list_display', 'is_searchable')
			when 'checkbox-group'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, _.pick(BASEUSERATTRS, '_id', 'is_wide', 'is_list_display', 'is_searchable')
			when 'text'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, OPTIONSUSERATTRS, BASEUSERATTRS, FORMULAUSERATTRS
			when 'textarea'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, OPTIONSUSERATTRS, BASEUSERATTRS, FORMULAUSERATTRS
			when 'number'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, {
					digits: {
						label: "小数位数"
						type: 'number'
						min: '0'
					}
				}, BASEUSERATTRS, FORMULAUSERATTRS
			when 'password'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, _.pick(BASEUSERATTRS, '_id', 'is_wide')
			when 'dateNew'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, BASEUSERATTRS
			when 'dateTime'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, BASEUSERATTRS
			when 'checkboxBoolean'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, BASEUSERATTRS
			when 'email'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, BASEUSERATTRS
			when 'url'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, BASEUSERATTRS
			when 'user'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, MULTISELECTUSERATTRS, BASEUSERATTRS
			when 'group'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, MULTISELECTUSERATTRS, BASEUSERATTRS
			when 'table'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, {
					_id: {
						label: '唯一键'
						readonly: 'readonly'
					},
					description: {
						label: '描述',
						type: 'textarea'
					},
					fields: {
						label: '字段'
					}
				}
			when 'section'
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, {
					_id: {
						label: '唯一键'
						readonly: 'readonly'
					},
					description: {
						label: '描述',
						type: 'textarea'
					},
					fields: {
						label: '字段'
					}
				}
			else
				typeUserAttrs[item] = _.extend {}, CODEUSERATTRS, BASEUSERATTRS, FORMULAUSERATTRS
	return typeUserAttrs

# 自动生成不重复的字段code
getFieldCode = (fieldsCode, fieldLabel)->
	index = 1
	fieldCode = fieldLabel
	while fieldsCode.includes(fieldCode)
		fieldCode = fieldLabel + index
		index++
	return fieldCode

_FORMBUILDERCLONEINDEX = 1

# 定义字段的事件
BASEUSEREVENTS = {
	onadd: (fid)->
		fieldId = fid.id
		if fid.type == 'checkboxBoolean'
			$(fid.querySelector('[name="default_value"]')).removeClass("form-control").prop('type','checkbox')

		if $('#' + "default_value-" + fieldId).length > 0
			$('#' + fieldId + ' .prev-holder .form-control').val($('#' + "default_value-" + fieldId).val())
		$("input[type='textarea']",fid).each (_i, _element)->
			_id = $(_element).attr('id')
			_name = $(_element).attr('name')
			_class = $(_element).attr('class')
			_title = $(_element).attr('title')
			_placeholder = $(_element).attr('placeholder') || ''
			_value = $(_element).attr('value') || ''
			_rows =  $(_element).attr('rows') || 3
			textarea = $("<textarea id='#{_id}' name='#{_name}' class='#{_class}' title='#{_title}' placeholder='#{_placeholder}' rows='#{_rows}'>#{_value}</textarea>")
			$(_element).parent().append(textarea)
			$(_element).remove()
		$("input[type='checkbox']",fid).each (_i, _element)->
			if $(_element).val() == 'true'
				$(_element).attr('checked',true)
	onclone: (fid)->
		formFields = Creator.formBuilder.transformFormFieldsOut(fb.actions.getData())
		fieldsCode = Creator.formBuilder.getFieldsCode(formFields) || []
		fieldCode = getFieldCode(fieldsCode, fid.querySelector('.field-label').innerText)
		fid.querySelector('[name="code"]').value = fieldCode
		fid.querySelector('[name="label"]').value = fieldCode
		fid.querySelector('.field-label').innerText = fieldCode
		liId = fid.id
		Meteor.setTimeout ()->
			if $("##{liId}").parent().parent().parent().parent().hasClass('fb-table') || $("##{liId}").parent().parent().parent().parent().hasClass('fb-section')
				if _FORMBUILDERCLONEINDEX == 2
					$("##{liId}").remove()
					_FORMBUILDERCLONEINDEX = 1
				else
					_FORMBUILDERCLONEINDEX++
		, 1
}
# 获取各字段类型的事件
getTypeUserEvents = ()->
	typeUserEvents = {}
	_.each FORMBUILDERFIELDTYPES, (item)->
		typeUserEvents[item] = BASEUSEREVENTS
	return typeUserEvents

# 定义扩展的字段类型
getFields = ()->
	[
		{
			label: "日期",
			attrs: {
				type: 'dateNew'
			}
			icon: "📆"
		},
		{
			label: "日期-时间",
			attrs: {
				type: 'dateTime'
			}
			icon: "🕛"
		},
		{
			label: "勾选框"
			attrs: {
				type: "checkboxBoolean"
			}
			icon: "☑️"
		},
		{
			label: "邮件"
			attrs: {
				type: "email"
			}
			icon: "📧"
		},
		{
			label: "网址"
			attrs: {
				type: "url"
			}
			icon: "🌏"
		},
		{
			label: "密码"
			attrs: {
				type: "password"
			}
			icon: "🔑"
		},
		{
			label: "选择用户"
			attrs: {
				type: "user"
			}
			icon: "👤"
		},
		{
			label: "选择部门"
			attrs: {
				type: "group"
			}
			icon: "👬"
		},
		{
			label: "表格"
			attrs: {
				type: "table"
			}
			icon: "T"
		},
		{
			label: "分组"
			attrs: {
				type: "section"
			}
			icon: "S"
		}
	]

# 定义扩展的字段显示模板
getFieldTemplates  = ()->
	{
		dateNew: (fieldData) ->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' placeholder='yyyy-MM-dd HH:mm' type='text' #{Creator.formBuilder.utils.attrString(fieldData)} readonly>",
			};
		dateTime: (fieldData) ->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' placeholder='yyyy-MM-dd' type='text' #{Creator.formBuilder.utils.attrString(fieldData)} readonly>",
			};
		checkboxBoolean: (fieldData)->
			if fieldData.value
				fieldData.checked =  fieldData.value
			return {
				field: "<input id='#{fieldData.name}' type='checkbox' #{Creator.formBuilder.utils.attrString(fieldData)} disabled>",
			};
		email: (fieldData)->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' type='email' autocomplete='off' #{Creator.formBuilder.utils.attrString(fieldData)}>",
			};
		url: (fieldData)->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' type='url' autocomplete='off' #{Creator.formBuilder.utils.attrString(fieldData)}>",
			};
		password: (fieldData)->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' type='password' autocomplete='new-password' #{Creator.formBuilder.utils.attrString(fieldData)}>",
			};
		user: (fieldData)->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' type='text' readonly #{Creator.formBuilder.utils.attrString(fieldData)}>",
			};
		group: (fieldData)->
			if !fieldData.className
				fieldData.className = 'form-control'
			return {
				field: "<input id='#{fieldData.name}' type='text' readonly #{Creator.formBuilder.utils.attrString(fieldData)}>",
			};
		table: (fieldData)->
			delete fieldData.className
			return {
				field: "<div id='#{fieldData.name}' #{Creator.formBuilder.utils.attrString(fieldData)}></div>",
				onRender: ()->
					Meteor.setTimeout ()->
						tableFB = $("##{fieldData.name}").formBuilder(Creator.formBuilder.optionsForFormFields(true))
						Meteor.defer ()->
							Creator.formBuilder.stickyControls($("##{fieldData.name}"))
						if fieldData.fields
							tableFields = Creator.formBuilder.transformFormFieldsIn(JSON.parse(fieldData.fields))
							tableFB.promise.then (tableFormBuilder)->
								tableFormBuilder.actions.setData(tableFields)
								# fix bug: 第一个字段的typeUserAttrs不生效
								Meteor.setTimeout ()->
									tableFormBuilder.actions.setData(tableFields)
								, 100
					, 100
			};
		section: (fieldData)->
			delete fieldData.className
			return {
				field: "<div id='#{fieldData.name}' #{Creator.formBuilder.utils.attrString(fieldData)}></div>",
				onRender: ()->
					Meteor.setTimeout ()->
						sectionFB = $("##{fieldData.name}").formBuilder(Creator.formBuilder.optionsForFormFields(true))
						Meteor.defer ()->
							Creator.formBuilder.stickyControls($("##{fieldData.name}"))
						if fieldData.fields
							sectionFields = Creator.formBuilder.transformFormFieldsIn(JSON.parse(fieldData.fields))
							sectionFB.promise.then (sectionFormBuilder)->
								sectionFormBuilder.actions.setData(sectionFields)
								# fix bug: 第一个字段的typeUserAttrs不生效
								Meteor.setTimeout ()->
									sectionFormBuilder.actions.setData(sectionFields)
								, 100
					, 100
			};
	}

Creator.formBuilder.optionsForFormFields = (is_sub)->
	#TODO 表格，分组支持copy功能
	options = {
		i18n: {
			locale: 'zh-CN'
			location: '/packages/steedos_formbuilder/formbuilder/languages'
		},
		scrollToFieldOnAdd: true,
		onCloseFieldEdit: (editPanel)->
			fieldId = editPanel.dataset.fieldId
			if $('#' + "default_value-" + fieldId).length > 0
				Meteor.setTimeout ()->
					if $('#' + "default_value-" + fieldId).attr('type') == 'checkbox'
						$('#' + fieldId + ' .prev-holder input').prop('checked', $('#' + "default_value-" + fieldId).prop('checked'))
					else
						$('#' + fieldId + ' .prev-holder .form-control').val($('#' + "default_value-" + fieldId).val())
				, 400
		onAddField: (fieldId, field)->
			formFields = Creator.formBuilder.transformFormFieldsOut(fb.actions.getData())
			fieldsCode = Creator.formBuilder.getFieldsCode(formFields) || []
			fieldCode = getFieldCode(fieldsCode, field.label)
			field.label = field.code = fieldCode
		disabledFieldButtons: {
			table: ['copy'],
			section: ['copy']
		}
	};

	options.typeUserAttrs = getTypeUserAttrs()

	options.typeUserEvents = getTypeUserEvents()

#	options.typeUserDisabledAttrs = TYPEUSERDISABLEDATTRS

	options.disabledAttrs = _.clone(DISABLEDATTRS)

	disableFields = _.clone(DISABLEFIELDS)

	if is_sub
		disableFields.push 'table'
		disableFields.push 'section'

	# stickyControls 功能有bug， 事件是绑定在window的scroll上，在此处无法使用，因此关闭。已重新写代码实现此功能,见Creator.formBuilder.stickyControls
	options.stickyControls = {
		enable: false
	}

	options.disableFields = disableFields
	options.disabledActionButtons = _.clone(DISABLEDACTIONBUTTONS)

	options.fields = getFields()

	options.templates = getFieldTemplates()

	options.controlOrder = _.clone(CONTROLORDER)

	return options

Creator.formBuilder.stickyControls = (scope)->
	$('div').scroll (evt)->
		if scope
			controls = $(".frmb-control", scope)[0]
			stage = $(".stage-wrap", scope)[0]
		else
			controls = $("#fb-editor>div>div>.frmb-control")[0]
			stage = $('#fb-editor>div>.stage-wrap')[0]
		if !controls || !stage
			return ;
		scrollTop = $(evt.target).scrollTop()
		$cbWrap = $(controls).parent()
		cbPosition = controls.getBoundingClientRect()
		stageTop = stage.getBoundingClientRect().top
		offsetDefaults = {
			top: 0,
			bottom: 'auto',
			right: 'auto',
			left: cbPosition.left,
		}

		offset = Object.assign({}, offsetDefaults, config?.opts?.stickyControls?.offset)

		if scrollTop > stageTop
			style = {
				position: 'sticky',
			}
			cbStyle = Object.assign(style, offset)
			cbPosition = controls.getBoundingClientRect()
			stagePosition = stage.getBoundingClientRect()
			cbBottom = cbPosition.top + cbPosition.height
			stageBottom = stagePosition.top + stagePosition.height
			atBottom = cbBottom == stageBottom && cbPosition.top > scrollTop
			if cbBottom > stageBottom && cbPosition.top != stagePosition.top
				$cbWrap.css({
					position: 'absolute',
					top: 'auto',
					bottom: 0,
					right: 0,
					left: 'auto',
				})
			if cbBottom < stageBottom || atBottom
				$cbWrap.css(cbStyle)
		else
			controls.parentElement.removeAttribute('style')


Creator.formBuilder.forObjectFields = ()->
	console.log('Creator.formBuilder.forObjectFields')