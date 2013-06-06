/**
 * Copyright (c) 2012 hammerc.org
 * See LICENSE.txt for full license information.
 */
package org.hammerc.controls
{
	import org.hammerc.controls.buttonClasses.AbstractLabelButton;
	import org.hammerc.manager.SkinManager;
	import org.hammerc.skin.ISkin;
	import org.hammerc.skin.controls.AbstractButtonSkin;
	
	/**
	 * <code>Button</code> 类定义了带有标签说明的按钮.
	 * @author wizardc
	 */
	public class Button extends AbstractLabelButton
	{
		/**
		 * 创建一个 <code>Button</code> 对象.
		 * @param skinClass 组件的皮肤绘制类.
		 */
		public function Button(skinClass:Class = null)
		{
			super(skinClass);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validSkinClass():Class
		{
			return AbstractButtonSkin;
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
