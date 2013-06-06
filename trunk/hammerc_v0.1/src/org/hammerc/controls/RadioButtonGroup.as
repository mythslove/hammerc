/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @eventType flash.events.Event.CHANGE
	 */
	[Event(name="change", type="flash.events.Event")]
	
	/**
	 * <code>RadioButtonGroup</code> 类定义了单选按钮组对象.
	 * @author wizardc
	 */
	public class RadioButtonGroup extends EventDispatcher
	{
		/**
		 * 记录单选按钮组名称.
		 */
		protected var _groupName:String;
		
		/**
		 * 记录单选按钮组的所有单选按钮列表.
		 */
		protected var _buttonList:Vector.<RadioButton>;
		
		/**
		 * 记录当前选择的单选按钮.
		 */
		protected var _selectedButton:RadioButton;
		
		/**
		 * 创建一个 <code>RadioButtonGroup</code> 对象.
		 * @param groupName 单选按钮组名称.
		 */
		public function RadioButtonGroup(groupName:String = null)
		{
			_groupName = groupName;
			_buttonList = new Vector.<RadioButton>();
		}
		
		/**
		 * 获取单选按钮组名称.
		 */
		public function get groupName():String
		{
			return _groupName;
		}
		
		/**
		 * 设置或获取当前选择的单选按钮.
		 */
		public function set selectedButton(value:RadioButton):void
		{
			if(_selectedButton != value)
			{
				if(_selectedButton != null)
				{
					_selectedButton.selected = false;
				}
				_selectedButton = value;
				_selectedButton.selected = true;
				this.dispatchEvent(new Event(Event.CHANGE));
			}
		}
		public function get selectedButton():RadioButton
		{
			return _selectedButton;
		}
		
		/**
		 * 获取当前选择的单选按钮的值.
		 */
		public function get selectedValue():*
		{
			return _selectedButton.value;
		}
		
		/**
		 * 添加一个单选按钮.
		 * @param radioButton 要添加的单选按钮.
		 */
		public function addRadioButton(radioButton:RadioButton):void
		{
			if(_buttonList.indexOf(radioButton) == -1)
			{
				radioButton.addEventListener(Event.SELECT, selectHandler);
				_buttonList.push(radioButton);
			}
			if(radioButton.selected)
			{
				this.selectedButton = radioButton;
			}
		}
		
		/**
		 * 单选按钮被选中时的事件执行方法.
		 * @param event 单选按钮被选中时的事件对象.
		 */
		protected function selectHandler(event:Event):void
		{
			var radioButton:RadioButton = event.target as RadioButton;
			if(radioButton.selected)
			{
				this.selectedButton = radioButton;
			}
		}
		
		/**
		 * 移除一个单选按钮.
		 * @param radioButton 要移除的单选按钮.
		 */
		public function removeRadioButton(radioButton:RadioButton):void
		{
			var index:int = _buttonList.indexOf(radioButton);
			if(index != -1)
			{
				radioButton.removeEventListener(Event.SELECT, selectHandler);
				_buttonList.splice(index, 1);
			}
		}
	}
}
