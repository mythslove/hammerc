/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import org.hammerc.controls.buttonClasses.AbstractSelectableButton;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractRadioButtonSkin;
	
	/**
	 * <code>RadioButton</code> 类定义了单选按钮.
	 * @author wizardc
	 */
	public class RadioButton extends AbstractSelectableButton
	{
		/**
		 * 记录该按钮所在的单选按钮组对象.
		 */
		protected var _radioButtonGroup:RadioButtonGroup;
		
		/**
		 * 记录该按钮附带的值.
		 */
		protected var _value:*;
		
		/**
		 * 创建一个 <code>RadioButton</code> 对象.
		 * @param radioButtonGroup 该按钮所在的单选按钮组对象.
		 * @param value 该按钮附带的值.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function RadioButton(radioButtonGroup:RadioButtonGroup = null, value:* = null, skinClass:Class = null)
		{
			super(skinClass);
			this.radioButtonGroup = radioButtonGroup;
			this.value = value;
		}
		
		/**
		 * 设置或获取按钮所在的单选按钮组对象.
		 */
		public function set radioButtonGroup(value:RadioButtonGroup):void
		{
			if(_radioButtonGroup != value)
			{
				if(_radioButtonGroup != null)
				{
					_radioButtonGroup.removeRadioButton(this);
				}
				_radioButtonGroup = value;
				if(_radioButtonGroup != null)
				{
					_radioButtonGroup.addRadioButton(this);
				}
			}
		}
		public function get radioButtonGroup():RadioButtonGroup
		{
			return _radioButtonGroup;
		}
		
		/**
		 * 设置或获取按钮附带的值.
		 */
		public function set value(value:*):void
		{
			_value = value;
		}
		public function get value():*
		{
			return _value;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function buttonClick():void
		{
			if(!this.selected)
			{
				this.selected = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractRadioButtonSkin;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createDefaultSkin():ISkin
		{
			return SkinManager.getInstance().defaultTheme.getDefaultSkin(this);
		}
	}
}
