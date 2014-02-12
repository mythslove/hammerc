/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import org.hammerc.controls.buttonClasses.AbstractSelectableButton;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractToggleButtonSkin;
	
	/**
	 * <code>CheckBox</code> 类定义了复选框.
	 * @author wizardc
	 */
	public class CheckBox extends AbstractSelectableButton
	{
		/**
		 * 创建一个 <code>CheckBox</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function CheckBox(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractToggleButtonSkin;
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
